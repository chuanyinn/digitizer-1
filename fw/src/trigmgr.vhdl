library ieee;
use ieee.std_logic_1164.all;

entity TRIGMGR is
    generic(G_ADC_RES:    integer := 8;
            G_PULSE_WDTH: integer := 8);
    port(I_CLK:          in  std_logic;
         I_RST:          in  std_logic;
         I_COINWIN_WDTH: in  std_logic_vector((G_PULSE_WDTH - 1) downto 0);
         I_THRVAL_CH1:   in  std_logic_vector((G_ADC_RES - 1) downto 0);
         I_ADC_CH1:      in  std_logic_vector((G_ADC_RES - 1) downto 0);
         I_THRVAL_CH2:   in  std_logic_vector((G_ADC_RES - 1) downto 0);
         I_ADC_CH2:      in  std_logic_vector((G_ADC_RES - 1) downto 0);
         I_THRVAL_CH3:   in  std_logic_vector((G_ADC_RES - 1) downto 0);
         I_ADC_CH3:      in  std_logic_vector((G_ADC_RES - 1) downto 0);
         I_THRVAL_CH4:   in  std_logic_vector((G_ADC_RES - 1) downto 0);
         I_ADC_CH4:      in  std_logic_vector((G_ADC_RES - 1) downto 0);
         I_COINVAL:      in  std_logic_vector(2 downto 0);
         I_VETO_WDTH:    in  std_logic_vector((G_PULSE_WDTH - 1) downto 0);
         O_TRIG:         out std_logic);
end TRIGMGR;

architecture STRUCTURAL of TRIGMGR is
    component COINWIN is
        generic(G_ADC_RES:      integer;
                G_COINWIN_WDTH: integer);
        port(I_CLK:          in  std_logic;
             I_RST:          in  std_logic;
             I_COINWIN_WDTH: in  std_logic_vector((G_COINWIN_WDTH - 1) downto 0);
             I_THRVAL:       in  std_logic_vector((G_ADC_RES - 1) downto 0);
             I_ADC:          in  std_logic_vector((G_ADC_RES - 1) downto 0);
             O_PULSE:        out std_logic);
    end component;

    component COINDETR is
        port(I_CLK:         in  std_logic;
             I_COINVAL:     in  std_logic_vector(2 downto 0);
             I_COINWIN_CH1: in  std_logic;
             I_COINWIN_CH2: in  std_logic;
             I_COINWIN_CH3: in  std_logic;
             I_COINWIN_CH4: in  std_logic;
             O_PULSE:       out std_logic);
    end component;

    component TRIG is
        generic(G_VETO_WDTH: integer);
        port(I_CLK:       in  std_logic;
             I_RST:       in  std_logic;
             I_VETO_WDTH: in  std_logic_vector((G_VETO_WDTH - 1) downto 0);
             I_SIG:       in  std_logic;
             O_PULSE:     out std_logic);
    end component;

    signal S_CLK:          std_logic;
    signal S_RST:          std_logic;
    signal S_COINWIN_WDTH: std_logic_vector((G_PULSE_WDTH - 1) downto 0);
    signal S_THRVAL_CH1:   std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_ADC_CH1:      std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_THRVAL_CH2:   std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_ADC_CH2:      std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_THRVAL_CH3:   std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_ADC_CH3:      std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_THRVAL_CH4:   std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_ADC_CH4:      std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_COINVAL:      std_logic_vector(2 downto 0);
    signal S_VETO_WDTH:    std_logic_vector((G_PULSE_WDTH - 1) downto 0);
    signal S_TRIG:         std_logic;

    signal S_COINWIN_CH1: std_logic;
    signal S_COINWIN_CH2: std_logic;
    signal S_COINWIN_CH3: std_logic;
    signal S_COINWIN_CH4: std_logic;

    signal S_COIN: std_logic;
begin
    S_CLK          <= I_CLK;
    S_RST          <= I_RST;
    S_COINWIN_WDTH <= I_COINWIN_WDTH;
    S_THRVAL_CH1   <= I_THRVAL_CH1;
    S_ADC_CH1      <= I_ADC_CH1;
    S_THRVAL_CH2   <= I_THRVAL_CH2;
    S_ADC_CH2      <= I_ADC_CH2;
    S_THRVAL_CH3   <= I_THRVAL_CH3;
    S_ADC_CH3      <= I_ADC_CH3;
    S_THRVAL_CH4   <= I_THRVAL_CH4;
    S_ADC_CH4      <= I_ADC_CH4;
    S_COINVAL      <= I_COINVAL;
    S_VETO_WDTH    <= I_VETO_WDTH;

    COINWIN_CH1: COINWIN generic map(G_ADC_RES      => G_ADC_RES,
                                     G_COINWIN_WDTH => G_PULSE_WDTH)
                         port map(I_CLK          => S_CLK,
                                  I_RST          => S_RST,
                                  I_COINWIN_WDTH => S_COINWIN_WDTH,
                                  I_THRVAL       => S_THRVAL_CH1,
                                  I_ADC          => S_ADC_CH1,
                                  O_PULSE        => S_COINWIN_CH1);

    COINWIN_CH2: COINWIN generic map(G_ADC_RES      => G_ADC_RES,
                                     G_COINWIN_WDTH => G_PULSE_WDTH)
                         port map(I_CLK          => S_CLK,
                                  I_RST          => S_RST,
                                  I_COINWIN_WDTH => S_COINWIN_WDTH,
                                  I_THRVAL       => S_THRVAL_CH2,
                                  I_ADC          => S_ADC_CH2,
                                  O_PULSE        => S_COINWIN_CH2);

    COINWIN_CH3: COINWIN generic map(G_ADC_RES      => G_ADC_RES,
                                     G_COINWIN_WDTH => G_PULSE_WDTH)
                         port map(I_CLK          => S_CLK,
                                  I_RST          => S_RST,
                                  I_COINWIN_WDTH => S_COINWIN_WDTH,
                                  I_THRVAL       => S_THRVAL_CH3,
                                  I_ADC          => S_ADC_CH3,
                                  O_PULSE        => S_COINWIN_CH3);

    COINWIN_CH4: COINWIN generic map(G_ADC_RES      => G_ADC_RES,
                                     G_COINWIN_WDTH => G_PULSE_WDTH)
                         port map(I_CLK          => S_CLK,
                                  I_RST          => S_RST,
                                  I_COINWIN_WDTH => S_COINWIN_WDTH,
                                  I_THRVAL       => S_THRVAL_CH4,
                                  I_ADC          => S_ADC_CH4,
                                  O_PULSE        => S_COINWIN_CH4);

    COINDET: COINDETR port map(I_CLK     => S_CLK,
                               I_COINVAL => S_COINVAL,
                               I_COINWIN_CH1 => S_COINWIN_CH1,
                               I_COINWIN_CH2 => S_COINWIN_CH2,
                               I_COINWIN_CH3 => S_COINWIN_CH3,
                               I_COINWIN_CH4 => S_COINWIN_CH4,
                               O_PULSE       => S_COIN);

    TRIGGER: TRIG generic map(G_VETO_WDTH => G_PULSE_WDTH)
                  port map(I_CLK       => S_CLK,
                           I_RST       => S_RST,
                           I_VETO_WDTH => S_VETO_WDTH,
                           I_SIG       => S_COIN,
                           O_PULSE     => S_TRIG);

    O_TRIG <= S_TRIG;
end STRUCTURAL;
