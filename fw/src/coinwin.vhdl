library ieee;
use ieee.std_logic_1164.all;

entity COINWIN is
    generic(G_ADC_RES:      integer := 8;
            G_COINWIN_WDTH: integer := 8);
    port(I_CLK:          in  std_logic;
         I_RST:          in  std_logic;
         I_COINWIN_WDTH: in  std_logic_vector((G_COINWIN_WDTH - 1) downto 0);
         I_THRVAL:       in  std_logic_vector((G_ADC_RES - 1) downto 0);
         I_ADC:          in  std_logic_vector((G_ADC_RES - 1) downto 0);
         O_PULSE:        out std_logic);
end COINWIN;

architecture STRUCTURAL of COINWIN is
    component EDETR is
        port(I_CLK:   in  std_logic;
             I_SIG:   in  std_logic;
             O_PULSE: out std_logic);
    end component;

    component PULSEGEN is
        generic(G_WDTH: integer);
        port(I_CLK:   in  std_logic;
             I_RST:   in  std_logic;
             I_WDTH:  in  std_logic_vector((G_WDTH - 1) downto 0);
             I_TRIG:  in  std_logic;
             O_PULSE: out std_logic);
    end component;

    signal S_CLK:          std_logic;
    signal S_RST:          std_logic;
    signal S_COINWIN_WDTH: std_logic_vector((G_COINWIN_WDTH - 1) downto 0);
    signal S_THRVAL:       std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_ADC:          std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_PULSE:        std_logic;

    signal S_IS_ABOVE_THR: std_logic;

    signal S_IS_EDGE: std_logic;
    signal S_COINWIN: std_logic;
begin
    S_CLK          <= I_CLK;
    S_RST          <= I_RST;
    S_COINWIN_WDTH <= I_COINWIN_WDTH;
    S_THRVAL       <= I_THRVAL;
    S_ADC          <= I_ADC;

    S_IS_ABOVE_THR <= '1' when (S_ADC < S_THRVAL) else '0';

    EDET: EDETR port map(I_CLK   => S_CLK,
                         I_SIG   => S_IS_ABOVE_THR,
                         O_PULSE => S_IS_EDGE);

    COINWIN: PULSEGEN generic map(G_WDTH => G_COINWIN_WDTH)
                      port map(I_CLK   => S_CLK,
                               I_RST   => S_RST,
                               I_WDTH  => S_COINWIN_WDTH,
                               I_TRIG  => S_IS_EDGE,
                               O_PULSE => S_PULSE);

    O_PULSE <= S_PULSE;
end STRUCTURAL;
