unsigned int a[10]; //assume base address of a is in R4
unsigned int tmp; // assume tmp is in R5
int i, j; // assume i and j are in R6 and R7, respectively

for (i = 1; i < 10; i++)
  for (j = 0; j < i; j++)
    if (a[i] > a[j]) {
      tmp = a[i];
      a[i] = a[j];
      a[j] = tmp;
    }
