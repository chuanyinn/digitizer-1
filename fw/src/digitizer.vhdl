library ieee;
ieee.std_logic_1164.all;

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

         I_CLK_BP:   in    std_logic;
         I_nRW_BP:   in    std_logic;
         I_ADDR:     in    std_logic_vector((G_ADDR_WDTH - 1) downto 0);
         IO_DATA_BP: inout std_logic_vector((G_DATA_WDTH - 1) downto 0));
end DIGITIZER;

architecture STRUCTURAL of DIGITIZER is
    component CLKMGR is
        port(I_CLK:  in  std_logic;
             O_CLK:  out std_logic;
             O_LOCK: out std_logic);
    end component;

    component TRIGMGR is
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
    signal S_ADDR:    std_logic_vector((G_ADDR_WDTH - 1) downto 0);
    signal S_DATA_BP: std_logic_vector((G_DATA_WDTH - 1) downto 0);

    signal S_RST:          std_logic;
    signal S_COINWIN_WDTH: std_logic_vector((G_DATA_WDTH - 1) downto 0);
    signal S_THRVAL_CH1:   std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_ADC_CH1:      std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_THRVAL_CH2:   std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_ADC_CH2:      std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_THRVAL_CH3:   std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_ADC_CH3:      std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_THRVAL_CH4:   std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_ADC_CH4:      std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_COINVAL:      std_logic_vector(2 downto 0);
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
    S_ADDR    <= I_ADDR;
    S_DATA_BP <= IO_DATA_BP;

    CLOCKMANAGER: CLKMGR port map(I_CLK  => S_CLK_25M,
                                  O_CLK  => S_CLK_100M,
                                  O_LOCK => S_LOCK);

    S_COINWIN_WDTH <= "00001010";
    S_THRVAL_CH1   <= "01111111";
    S_THRVAL_CH2   <= "01111111";
    S_THRVAL_CH3   <= "01111111";
    S_THRVAL_CH4   <= "01111111";
    S_COINVAL      <= "001";
    S_VETO_WDTH    <= "11111111";

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
                                     I_COINVAL      => S_COINVAL,
                                     I_VETO_WDTH    => S_VETO_WDTH,
                                     O_TRIG         => S_TRIG);

    O_LOCK     <= S_LOCK;
    O_CLK_100M <= S_CLK_100M;
end STRUCTURAL;
