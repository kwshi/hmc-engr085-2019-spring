library IEEE; use IEEE.STD_LOGIC_1164.all;

entity fsm2 is
  port(clk, reset: in  STD_LOGIC;
       a, b:       in  STD_LOGIC;
       y:          out STD_LOGIC);
end;

architecture synth of fsm2 is
  type statetype is (S0, S1, S2, S3);
  signal state, nextstate: statetype;
begin
  process(clk, reset) begin
    if reset then state <= S0;
    elsif rising_edge(clk) then
      state <= nextstate;
    end if;
  end process;

  process(all) begin
    case state is
      when S0 => if (a xor b) then
                     nextstate <= S1;
                 else nextstate <= S0;
                 end if;
      when S1 => if (a and b) then
                     nextstate <= S2;
                 else nextstate <= S0;
                 end if;
      when S2 => if (a or b) then
                     nextstate <= S3;
                 else nextstate <= S0;
                 end if;
      when S3 => if (a or b) then
                     nextstate <= S3;
                 else nextstate <= S0;
                 end if;
    end case;
  end process;

  y <= '1' when ((state = S1) or (state = S2))
      else '0';
end;
