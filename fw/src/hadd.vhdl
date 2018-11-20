library ieee;
use ieee.std_logic_1164.all;

entity HADD is
    port(I_L: in  std_logic;
         I_M: in  std_logic;
         O_N: out std_logic;
         O_C: out std_logic);
end HADD;

architecture STRUCTURAL of HADD is
    signal S_L: std_logic;
    signal S_M: std_logic;
    signal S_N: std_logic;
    signal S_C: std_logic;
begin
    S_L <= I_L;
    S_M <= I_M;

    S_N <= S_L xor S_M;
    S_C <= S_L and S_M;

    O_N <= S_N;
    O_C <= S_C;
end STRUCTURAL;
