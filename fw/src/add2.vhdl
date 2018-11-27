library ieee;
use ieee.std_logic_1164.all;

entity ADD2 is
    port(I_L0: in  std_logic;
         I_L1: in  std_logic;
         I_M0: in  std_logic;
         I_M1: in  std_logic;
         O_N0: out std_logic;
         O_N1: out std_logic;
         O_C:  out std_logic);
end ADD2;

architecture STRUCTURAL of ADD2 is
    component HADD is
        port(I_L: in  std_logic;
             I_M: in  std_logic;
             O_N: out std_logic;
             O_C: out std_logic);
    end component;

    component FADD is
        port(I_L: in  std_logic;
             I_M: in  std_logic;
             I_N: in  std_logic;
             O_O: out std_logic;
    		 O_C: out std_logic);
    end component;

    signal S_L0: std_logic;
    signal S_L1: std_logic;
    signal S_M0: std_logic;
    signal S_M1: std_logic;
    signal S_N0: std_logic;
    signal S_N1: std_logic;
    signal S_C:  std_logic;

    signal S_CAR: std_logic;
begin
    S_L0 <= I_L0;
    S_L1 <= I_L1;
    S_M0 <= I_M0;
    S_M1 <= I_M1;

    HADD1: HADD port map(I_L => S_L0,
                         I_M => S_M0,
                         O_N => S_N0,
                         O_C => S_CAR);

    FADD1: FADD port map(I_L => S_L1,
                         I_M => S_M1,
                         I_N => S_CAR,
                         O_O => S_N1,
                         O_C => S_C);

    O_N0 <= S_N0;
    O_N1 <= S_N1;
    O_C  <= S_C;
end STRUCTURAL;
