#include "EasyNucleoIO.h"
#include "math.h"
#include "stddef.h"
#include "stm32f0xx.h"

// SPI setup

#define ALT 2

void spiInit() {
  // set ALT function for SPI pins
  pinMode(17, ALT);  // PA4/SPI1_NSS (A3)
  pinMode(18, ALT);  // PA5/SPI1_SCK (A4)
  pinMode(19, ALT);  // PA6/SPI1_MISO (A5)
  pinMode(20, ALT);  // PA7/SPI1_MOSI (A6)

  // configure SPI:
  // SPI enabled -> SPE; BAUD rate -> BR; Master -> MSTR;
  // BR = fclk/8, master mode
  SPI1->CR1 |= SPI_CR1_BR_1 | SPI_CR1_MSTR;
  // Enable NSS select signal, pulse NSS between transfers, 16-bit data,
  SPI1->CR2 |= SPI_CR2_SSOE | SPI_CR2_NSSP | (0xF) << 8;
  // enable SPI
  SPI1->CR1 |= SPI_CR1_SPE;
}

// send a 16-bits (short) on SPI1
unsigned short SPI1SendReceive16(unsigned short outDat) {
  SPI1->DR = outDat;
  while (!(SPI1->SR & SPI_SR_RXNE))
    ;  // wait for response
  return SPI1->DR;
}

void spiWrite(unsigned char address, unsigned char value) {
  SPI1SendReceive16(address << 8 | value);
}

unsigned char spiRead(unsigned char address) {
  return SPI1SendReceive16(address << 8 | (1 << 15));
}

// LED matrix logic.

// LED matrix digital pin numbers (Dx).
const int ledRows[] = {13, 1, 0, 2, 10, 11, 12, 9};
const int ledCols[] = {3, 6, 7, 8, 21, 16, 15, 14};

// Lights up an individual dot at a given row and column.
void setMatrixDot(const size_t row, const size_t col) {
  for (size_t i = 0; i < 8; ++i) {
    digitalWrite(ledRows[i], 1);
    digitalWrite(ledCols[i], 0);
  }
  digitalWrite(ledRows[row], 0);
  digitalWrite(ledCols[col], 1);
}

// Setups up LED matrix pins to output mode.
void matrixInit() {
  for (size_t i = 0; i < 8; ++i) {
    pinMode(ledRows[i], OUTPUT);
    pinMode(ledCols[i], OUTPUT);
  }
}

// Converts an accelerometer read data to an angle relative to the
// zero-level, in degrees.
int accelerometerDeg(const int16_t data) {
  // g * sin(theta) / (2 g) = x
  // theta ~ sin(theta) = 2 x = 2 * data / (1<<15) = data / (1<<14)
  return (180 * data) / (3 * (1 << 14));
}

// Converts a number of "units", relative to zero, into a row/column
// index for the LED matrix.
size_t nToRowColumn(const int n) {
  if (n < -4) return 0;
  if (n >= 4) return 7;
  return n + 4;
}

int main() {
  // Initialize clocks and hardware.
  EasyNucleoIOInit();
  spiInit();
  matrixInit();

  // Setup the LIS3DH for use.
  spiWrite(0x20, 0x77);  // highest conversion rate, all axis on
  spiWrite(0x23, 0x88);  // block update, and high resolution

  // Check WHO_AM_I register. should return 0x33
  volatile uint8_t debug = spiRead(0x0F);

  // Startup sequence: flash each matrix dot in order.
  for (size_t r = 0; r < 8; ++r) {
    for (size_t c = 0; c < 8; ++c) {
      setMatrixDot(r, c);
      delayLoop(10);
    }
  }

  delayLoop(500);

  for (;;) {
    // Collect the X and Y values from the LIS3DH.
    const int16_t x = spiRead(0x28) | (spiRead(0x29) << 8);
    const int16_t y = spiRead(0x2A) | (spiRead(0x2B) << 8);

    // Set corresponding LED matrix dot.
    setMatrixDot(nToRowColumn(-accelerometerDeg(x) / 2),
                 nToRowColumn(-accelerometerDeg(y) / 2));

    // Small delay to reduce flicker
    delayLoop(100);
  }
}
