library ieee;
use ieee.std_logic_1164.all;

entity TRIG is
    generic(G_VETO_WDTH: integer := 8);
    port(I_CLK:       in  std_logic;
         I_RST:       in  std_logic;
         I_VETO_WDTH: in  std_logic_vector((G_VETO_WDTH - 1) downto 0);
         I_SIG:       in  std_logic;
         O_PULSE:     out std_logic);
end TRIG;

architecture STRUCTURAL of TRIG is
    component FD1S3IX is
        generic(GSR: string);
        port(CK: in  std_logic
             CD: in  std_logic
             D:  in  std_logic
             Q:  out std_logic);
    end component;

    component PULSEGEN is
        generic(G_WDTH: integer := 8);
        port(I_CLK:   in  std_logic;
             I_RST:   in  std_logic;
             I_WDTH:  in  std_logic_vector((G_WDTH - 1) downto 0);
             I_TRIG:  in  std_logic;
             O_PULSE: out std_logic);
    end component;

    signal S_CLK:       std_logic;
    signal S_RST:       std_logic;
    signal S_VETO_WDTH: std_logic_vector((G_VETO_WDTH - 1) downto 0);
    signal S_SIG:       std_logic;
    signal S_PULSE:     std_logic;

    signal S_IS_TRIG: std_logic;
    signal S_IS_VETO: std_logic;
begin
    S_CLK       <= I_CLK;
    S_RST       <= I_RST;
    S_VETO_WDTH <= I_VETO_WDTH;
    S_SIG       <= I_SIG;

    S_IS_TRIG <= S_SIG and (not S_IS_VETO);

    TRIGWIN: FD1S3IX generic map(GSR => "ENABLED")
                     port map(CK => S_CLK,
                              CD => S_RST,
                              D  => S_IS_TRIG,
                              Q  => S_PULSE);

    VETOWIN: PULSEGENERATOR generic map(G_WDTH => G_VETO_WDTH);
                            port map(I_CLK   => S_CLK,
                                     I_RST   => S_RST,
                                     I_WDTH  => S_VETO_WDTH,
                                     I_SIG   => S_IS_TRIG,
                                     O_PULSE => S_IS_VETO);

    O_PULSE <= S_PULSE;
end STRUCTURAL;
