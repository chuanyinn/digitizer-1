library ieee;
use ieee.std_logic_1164.all;

entity DIGITIZER is
    generic(G_ADC_RES:   integer := 8;
            G_ADDR_WDTH: integer := 6;
            G_DATA_WDTH: integer := 8);
    port(I_CLK_25M:  in    std_logic;
         O_LOCK:     out   std_logic;
         O_CLK_100M: out   std_logic;
         I_ADC_CH1:  in    std_logic_vector((G_ADC_RES - 1) downto 0);
         I_ADC_CH2:  in    std_logic_vector((G_ADC_RES - 1) downto 0);
         I_ADC_CH3:  in    std_logic_vector((G_ADC_RES - 1) downto 0);
         I_ADC_CH4:  in    std_logic_vector((G_ADC_RES - 1) downto 0);
         O_TRIG:     out   std_logic;

         I_CLK_BP:   in    std_logic;
         I_nRW_BP:   in    std_logic;
         I_ADDR_BP:  in    std_logic_vector((G_ADDR_WDTH - 1) downto 0);
         IO_DATA_BP: inout std_logic_vector((G_DATA_WDTH - 1) downto 0));
end DIGITIZER;

architecture STRUCTURAL of DIGITIZER is
    component CLKMGR is
        port(I_CLK:  in  std_logic;
             O_CLK:  out std_logic;
             O_LOCK: out std_logic);
    end component;

    component BPIF is
        generic(G_ADDR_WDTH: integer;
                G_DATA_WDTH: integer);
        port(I_CLK:   in    std_logic;
             I_nRW:   in    std_logic;
             I_ADDR:  in    std_logic_vector((G_ADDR_WDTH - 1) downto 0);
             IO_DATA: inout std_logic_vector((G_DATA_WDTH - 1) downto 0);
             O_REG0:  out   std_logic_vector((G_DATA_WDTH - 1) downto 0);
             O_REG1:  out   std_logic_vector((G_DATA_WDTH - 1) downto 0);
             O_REG2:  out   std_logic_vector((G_DATA_WDTH - 1) downto 0);
             O_REG3:  out   std_logic_vector((G_DATA_WDTH - 1) downto 0);
             O_REG4:  out   std_logic_vector((G_DATA_WDTH - 1) downto 0);
             O_REG5:  out   std_logic_vector((G_DATA_WDTH - 1) downto 0);
             O_REG6:  out   std_logic_vector((G_DATA_WDTH - 1) downto 0));
    end component;

    component TRIGMGR is
        generic(G_ADC_RES:    integer;
                G_PULSE_WDTH: integer);
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
    end component;

    signal S_CLK_25M:  std_logic;
    signal S_LOCK:     std_logic;
    signal S_CLK_100M: std_logic;
    signal S_ADC_CH1:  std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_ADC_CH2:  std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_ADC_CH3:  std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_ADC_CH4:  std_logic_vector((G_ADC_RES - 1) downto 0);

    signal S_CLK_BP:  std_logic;
    signal S_nRW_BP:  std_logic;
    signal S_ADDR_BP: std_logic_vector((G_ADDR_WDTH - 1) downto 0);
    signal S_DATA_BP: std_logic_vector((G_DATA_WDTH - 1) downto 0);

    signal S_RST:          std_logic := '0';
    signal S_COINWIN_WDTH: std_logic_vector((G_DATA_WDTH - 1) downto 0);
    signal S_THRVAL_CH1:   std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_THRVAL_CH2:   std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_THRVAL_CH3:   std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_THRVAL_CH4:   std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_COINVAL:      std_logic_vector((G_DATA_WDTH - 1) downto 0);
    signal S_VETO_WDTH:    std_logic_vector((G_DATA_WDTH - 1) downto 0);
    signal S_TRIG:         std_logic;
begin
    S_CLK_25M  <= I_CLK_25M;
    S_ADC_CH1  <= I_ADC_CH1;
    S_ADC_CH2  <= I_ADC_CH2;
    S_ADC_CH3  <= I_ADC_CH3;
    S_ADC_CH4  <= I_ADC_CH4;

    S_CLK_BP  <= I_CLK_BP;
    S_nRW_BP  <= I_nRW_BP;
    S_ADDR_BP <= I_ADDR_BP;
    S_DATA_BP <= IO_DATA_BP;

    CLOCKMANAGER: CLKMGR port map(I_CLK  => S_CLK_25M,
                                  O_CLK  => S_CLK_100M,
                                  O_LOCK => S_LOCK);

    BPINT: BPIF generic map(G_ADDR_WDTH => G_ADDR_WDTH,
                            G_DATA_WDTH => G_DATA_WDTH)
                port map(I_CLK => S_CLK_BP,
                         I_nRW => S_nRW_BP,
                         I_ADDR => S_ADDR_BP,
                         IO_DATA => S_DATA_BP,
                         O_REG0  => S_THRVAL_CH1,
                         O_REG1  => S_THRVAL_CH2,
                         O_REG2  => S_THRVAL_CH3,
                         O_REG3  => S_THRVAL_CH4,
                         O_REG4  => S_COINWIN_WDTH,
                         O_REG5  => S_COINVAL,
                         O_REG6  => S_VETO_WDTH);

    TRIGGERMANAGER: TRIGMGR generic map(G_ADC_RES    => G_ADC_RES,
                                        G_PULSE_WDTH => G_DATA_WDTH)
                            port map(I_CLK          => S_CLK_100M,
                                     I_RST          => S_RST,
                                     I_COINWIN_WDTH => S_COINWIN_WDTH,
                                     I_THRVAL_CH1   => S_THRVAL_CH1,
                                     I_ADC_CH1      => S_ADC_CH1,
                                     I_THRVAL_CH2   => S_THRVAL_CH2,
                                     I_ADC_CH2      => S_ADC_CH2,
                                     I_THRVAL_CH3   => S_THRVAL_CH3,
                                     I_ADC_CH3      => S_ADC_CH3,
                                     I_THRVAL_CH4   => S_THRVAL_CH4,
                                     I_ADC_CH4      => S_ADC_CH4,
                                     I_COINVAL      => S_COINVAL(2 downto 0),
                                     I_VETO_WDTH    => S_VETO_WDTH,
                                     O_TRIG         => S_TRIG);

    O_TRIG     <= S_TRIG;
    O_LOCK     <= S_LOCK;
    O_CLK_100M <= S_CLK_100M;
end STRUCTURAL;
