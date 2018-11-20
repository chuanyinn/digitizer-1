library ieee;
use ieee.std_logic_1164.all;

entity FADD is
    port(I_L: in  std_logic;
         I_M: in  std_logic;
         I_N: in  std_logic;
         O_O: out std_logic;
         O_C: out std_logic);
end FADD;

architecture STRUCTURAL of FADD is
    component HADD is
        port(I_L: std_logic;
             I_M: std_logic;
             O_N: std_logic;
             O_C: std_logic);
    end component;

    signal S_L: std_logic;
    signal S_M: std_logic;
    signal S_N: std_logic;
    signal S_O: std_logic;
    signal S_C: std_logic;

    signal S_HADD1_N: std_logic;
    signal S_HADD1_C: std_logic;
    signal S_HADD2_C: std_logic;
begin
    S_L <= I_L;
    S_M <= I_M;
    S_N <= I_N;

    HADD1: HADD port map(I_L => S_L,
                         I_M => S_M,
                         O_N => S_HADD1_N,
                         O_C => S_HADD1_C);

    HADD2: HADD port map(I_L => S_N,
                         I_M => S_HADD1_N,
                         O_N => S_O,
                         O_C => S_HADD2_C);

    S_C <= S_HADD1_C or S_HADD2_C;

    O_O <= S_O;
    O_C <= S_C;
end STRUCTURAL;
