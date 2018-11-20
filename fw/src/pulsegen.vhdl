library ieee;
use ieee.std_logic_1164.all;

entity PULSEGEN is
    generic(G_WDTH: integer := 8);
    port(I_CLK:   in  std_logic;
         I_RST:   in  std_logic;
         I_WDTH:  in  std_logic_vector((G_WDTH - 1) downto 0);
         I_TRIG:  in  std_logic;
         O_PULSE: out std_logic);
end PULSEGEN;

architecture STRUCTURAL of PULSEGEN is
    component DCNT is
        generic(G_WDTH: integer);
        port(I_CLK: in  std_logic;
             I_RST: in  std_logic;
             I_LD:  in  std_logic;
             I_EN:  in  std_logic;
             I_VAL: in  std_logic_vector((G_WDTH - 1) downto 0);
             O_CNT: out std_logic_vector((G_WDTH - 1) downto 0));
    end component;

    signal S_CLK:   std_logic;
    signal S_RST:   std_logic;
    signal S_WDTH:  std_logic_vector((G_WDTH - 1) downto 0);
    signal S_TRIG:  std_logic;
    signal S_PULSE: std_logic;

    signal S_PULSEGEN_CNTR_VAL: std_logic_vector((G_WDTH - 1) downto 0);

    constant C_ZEROES: std_logic_vector((G_WDTH - 1) downto 0) := (others => '0');
begin
    S_CLK  <= I_CLK;
    S_RST  <= I_RST;
    S_WDTH <= I_WDTH;
    S_TRIG <= I_TRIG;

    PLSEGEN: DCNT generic map(G_WDTH => G_WDTH)
                  port map(I_CLK  => S_CLK,
                           I_RST  => S_RST,
                           I_LD   => S_TRIG,
                           I_EN   => S_PULSE,
                           I_VAL  => S_WDTH,
                           O_DATA => S_PULSEGEN_CNTR_VAL);

    S_PULSE <= '1' when (S_PULSEGEN_CNTR_VAL /= C_ZEROES) else '0';

    O_PULSE <= S_PULSE;
end STRUCTURAL;
