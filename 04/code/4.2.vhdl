library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity exercise2 is
  port(a: in STD_LOGIC_VECTOR(3 downto 0);
       y: out STD_LOGIC_VECTOR(1 downto 0));
end;

architecture synth of exercise2 is
begin
  process(all)
  begin
    if a(0) then y <= "11";
    elsif a(1) then y <= "10";
    elsif a(2) then y <= "01";
    elsif a(3) then y <= "00";
    else y <= a(1 downto 0);
    end if;
  end process;
end;
