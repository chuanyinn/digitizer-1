library ieee;
use ieee.std_logic_1164.all;

entity COINADD is
    port(I_L: in  std_logic;
         I_M: in  std_logic;
         I_N: in  std_logic;
         I_O: in  std_logic;
         O_P: out std_logic_vector(2 downto 0));
end COINADD;

architecture STRUCTURAL of COINADD is
    component HADD is
        port(I_L: in  std_logic;
             I_M: in  std_logic;
             O_N: out std_logic;
             O_C: out std_logic);
    end component;

    signal S_L: std_logic;
    signal S_M: std_logic;
    signal S_N: std_logic;
    signal S_O: std_logic;
    signal S_P: std_logic_vector(2 downto 0);

    signal S_HADD1_N: std_logic;
    signal S_HADD1_C: std_logic;
    signal S_HADD2_N: std_logic;
    signal S_HADD2_C: std_logic;
    signal S_HADD3_C: std_logic;
begin
    S_L <= I_L;
    S_M <= I_M;
    S_N <= I_N;
    S_O <= I_O;

    HADD1: HADD port map(I_L => S_L,
                         I_M => S_M,
                         O_N => S_HADD1_N,
                         O_C => S_HADD1_C);

    HADD2: HADD port map(I_L => S_N,
                         I_M => S_O,
                         O_N => S_HADD2_N,
                         O_C => S_HADD2_C);

    HADD3: HADD port map(I_L => S_HADD1_N,
                         I_M => S_HADD2_N,
                         O_N => S_P(0),
                         O_C => S_HADD3_C);

    FADD1: FADD port map(I_L => S_HADD1_C,
                         I_M => S_HADD2_C,
                         I_N => S_HADD3_C,
                         O_O => S_P(1),
                         O_C => S_P(2));

    O_P <= S_P;
end STRUCTURAL;
