library ieee;
use ieee.std_logic_1164.all;

library machxo2;
use machxo2.components.all;

entity COINDETR is
    port(I_CLK:         in  std_logic;
         I_COINVAL:     in  std_logic_vector(2 downto 0);
         I_COINWIN_CH1: in  std_logic;
         I_COINWIN_CH2: in  std_logic;
         I_COINWIN_CH3: in  std_logic;
         I_COINWIN_CH4: in  std_logic;
         O_PULSE:       out std_logic);
end COINDETR;

architecture STRUCTURAL of COINDETR is
    component COINADD is
        port(I_L: in  std_logic;
             I_M: in  std_logic;
             I_N: in  std_logic;
             I_O: in  std_logic;
             O_P: out std_logic_vector(2 downto 0));
    end component;

    component FD1S3AX is
        generic(GSR: string);
        port(CK: in  std_logic;
             D:  in  std_logic;
             Q:  out std_logic);
    end component;

    component EDETR is
        port(I_CLK:   in  std_logic;
             I_SIG:   in  std_logic;
             O_PULSE: out std_logic);
    end component;

    signal S_CLK:         std_logic;
    signal S_COINVAL:     std_logic_vector(2 downto 0);
    signal S_COINWIN_CH1: std_logic;
    signal S_COINWIN_CH2: std_logic;
    signal S_COINWIN_CH3: std_logic;
    signal S_COINWIN_CH4: std_logic;
    signal S_PULSE:       std_logic;

    signal S_COINWIN_ADD: std_logic_vector(2 downto 0);
    signal S_NCOIN:       std_logic_vector(2 downto 0);

    signal S_IS_COIN: std_logic;
begin
    S_CLK         <= I_CLK;
    S_COINVAL     <= I_COINVAL;
    S_COINWIN_CH1 <= I_COINWIN_CH1;
    S_COINWIN_CH2 <= I_COINWIN_CH2;
    S_COINWIN_CH3 <= I_COINWIN_CH3;
    S_COINWIN_CH4 <= I_COINWIN_CH4;

    COINWIN_ADD: COINADD port map(I_L => S_COINWIN_CH1,
                                  I_M => S_COINWIN_CH2,
                                  I_N => S_COINWIN_CH3,
                                  I_O => S_COINWIN_CH4,
                                  O_P => S_COINWIN_ADD);

    DTFF_2: FD1S3AX generic map(GSR => "ENABLED")
                          port map(CK => S_CLK,
                                   D  => S_COINWIN_ADD(2),
                                   Q  => S_NCOIN(2));

    DTFF_1: FD1S3AX generic map(GSR => "ENABLED")
                          port map(CK => S_CLK,
                                   D  => S_COINWIN_ADD(1),
                                   Q  => S_NCOIN(1));

    DTFF_0: FD1S3AX generic map(GSR => "ENABLED")
                          port map(CK => S_CLK,
                                   D  => S_COINWIN_ADD(0),
                                   Q  => S_NCOIN(0));

    S_IS_COIN <= '1' when (S_NCOIN > S_COINVAL) else '0';

    COIN_PULSE: EDETR port map(I_CLK   => S_CLK,
                               I_SIG   => S_IS_COIN,
                               O_PULSE => S_PULSE);

    O_PULSE <= S_PULSE;
end STRUCTURAL;
