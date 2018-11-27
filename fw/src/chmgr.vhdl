library ieee;
use ieee.std_logic_1164.all;

library machxo2;
use machxo2.components.all;

entity CHMGR is
    generic(G_ADC_RES:   integer := 8;
            G_DATA_WDTH: integer := 8);
    port(I_CLK:       in  std_logic;
         I_RST:       in  std_logic;
         I_PRE_TRIG:  in  std_logic_vector((G_DATA_WDTH - 1) downto 0);
         I_POST_TRIG: in  std_logic_vector((G_DATA_WDTH - 1) downto 0);
         I_TRIG:      in  std_logic;
         I_ADC:       in  std_logic_vector((G_ADC_RES - 1) downto 0);
         I_CLK_READ:  in  std_logic;
         I_EN_READ:   in  std_logic;
         O_DATA:      out std_logic_vector((G_ADC_RES - 1) downto 0));
end CHMGR;

architecture STRUCTURAL of CHMGR is
    component UCNT is
        generic(G_WDTH: integer);
        port(I_CLK:  in  std_logic;
             I_RST:  in  std_logic;
             I_EN:   in  std_logic;
             I_LD:   in  std_logic;
             I_VAL:  in  std_logic_vector((G_WDTH - 1) downto 0);
             O_CNT:  out std_logic_vector((G_WDTH - 1) downto 0));
    end component;

    component ADD10 is
        port(I_CLK: in  std_logic;
             I_L:   in  std_logic_vector(9 downto 0);
             I_M:   in  std_logic_vector(9 downto 0);
             O_N:   out std_logic_vector(9 downto 0);
             O_C:   out std_logic);
    end component;

    component FD1S3IX is
        generic(GSR: string);
        port(CK: in  std_logic;
             CD: in  std_logic;
             D:  in  std_logic;
             Q:  out std_logic);
    end component;

    component DP8KC is
        generic(INIT_DATA:           string;
                INITVAL_1F:          string;
                INITVAL_1E:          string;
                INITVAL_1D:          string;
                INITVAL_1C:          string;
                INITVAL_1B:          string;
                INITVAL_1A:          string;
                INITVAL_19:          string;
                INITVAL_18:          string;
                INITVAL_17:          string;
                INITVAL_16:          string;
                INITVAL_15:          string;
                INITVAL_14:          string;
                INITVAL_13:          string;
                INITVAL_12:          string;
                INITVAL_11:          string;
                INITVAL_10:          string;
                INITVAL_0F:          string;
                INITVAL_0E:          string;
                INITVAL_0D:          string;
                INITVAL_0C:          string;
                INITVAL_0B:          string;
                INITVAL_0A:          string;
                INITVAL_09:          string;
                INITVAL_08:          string;
                INITVAL_07:          string;
                INITVAL_06:          string;
                INITVAL_05:          string;
                INITVAL_04:          string;
                INITVAL_03:          string;
                INITVAL_02:          string;
                INITVAL_01:          string;
                INITVAL_00:          string;

                RESETMODE:           string;
                GSR:                 string;
                ASYNC_RESET_RELEASE: string;

                CSDECODE_A:          string;
                WRITEMODE_A:         string;
                REGMODE_A:           string;
                DATA_WIDTH_A:        integer;

                CSDECODE_B:          string;
                WRITEMODE_B:         string;
                REGMODE_B:           string;
                DATA_WIDTH_B:        integer);
        port(CEA:   in  std_logic;
             CLKA:  in  std_logic;
             WEA:   in  std_logic;
             CSA2:  in  std_logic;
             CSA1:  in  std_logic;
             CSA0:  in  std_logic;
             RSTA:  in  std_logic;
             CEB:   in  std_logic;
             CLKB:  in  std_logic;
             WEB:   in  std_logic;
             CSB2:  in  std_logic;
             CSB1:  in  std_logic;
             CSB0:  in  std_logic;
             RSTB:  in  std_logic;
             DIA8:  in  std_logic;
             DIA7:  in  std_logic;
             DIA6:  in  std_logic;
             DIA5:  in  std_logic;
             DIA4:  in  std_logic;
             DIA3:  in  std_logic;
             DIA2:  in  std_logic;
             DIA1:  in  std_logic;
             DIA0:  in  std_logic;
             ADA12: in  std_logic;
             ADA11: in  std_logic;
             ADA10: in  std_logic;
             ADA9:  in  std_logic;
             ADA8:  in  std_logic;
             ADA7:  in  std_logic;
             ADA6:  in  std_logic;
             ADA5:  in  std_logic;
             ADA4:  in  std_logic;
             ADA3:  in  std_logic;
             ADA2:  in  std_logic;
             ADA1:  in  std_logic;
             ADA0:  in  std_logic;
             DIB8:  in  std_logic;
             DIB7:  in  std_logic;
             DIB6:  in  std_logic;
             DIB5:  in  std_logic;
             DIB4:  in  std_logic;
             DIB3:  in  std_logic;
             DIB2:  in  std_logic;
             DIB1:  in  std_logic;
             DIB0:  in  std_logic;
             ADB12: in  std_logic;
             ADB11: in  std_logic;
             ADB10: in  std_logic;
             ADB9:  in  std_logic;
             ADB8:  in  std_logic;
             ADB7:  in  std_logic;
             ADB6:  in  std_logic;
             ADB5:  in  std_logic;
             ADB4:  in  std_logic;
             ADB3:  in  std_logic;
             ADB2:  in  std_logic;
             ADB1:  in  std_logic;
             ADB0:  in  std_logic;
             OCEA:  in  std_logic;
             OCEB:  in  std_logic;
             DOA8:  out std_logic;
             DOA7:  out std_logic;
             DOA6:  out std_logic;
             DOA5:  out std_logic;
             DOA4:  out std_logic;
             DOA3:  out std_logic;
             DOA2:  out std_logic;
             DOA1:  out std_logic;
             DOA0:  out std_logic;
             DOB8:  out std_logic;
             DOB7:  out std_logic;
             DOB6:  out std_logic;
             DOB5:  out std_logic;
             DOB4:  out std_logic;
             DOB3:  out std_logic;
             DOB2:  out std_logic;
             DOB1:  out std_logic;
             DOB0:  out std_logic);
    end component;

    component FIFO8KB
        generic(GSR:                 string;
                AEPONTER:            string;
                AEPOINTER1:          string;
                AFPOINTER:           string;
                AFPOINTER1:          string;
                FULLPOINTER:         string;
                FULLPOINTER1:        string;
                REGMODE:             string;
                RESETMODE:           string;
                ASYNC_RESET_RELEASE: string;
                CSDECODE_W:          string;
                DATA_WIDTH_W:        integer;
                CSDECODE_R:          string;
                DATA_WIDTH_R:        integer);
        port(RST:    in  std_logic;
             RPRST:  in  std_logic;
             FULLI:  in  std_logic;
             EMPTYI: in  std_logic;
             CLKW:   in  std_logic;
             WE:     in  std_logic;
             CSW1:   in  std_logic;
             CSW0:   in  std_logic;
             DI17:   in  std_logic;
             DI16:   in  std_logic;
             DI15:   in  std_logic;
             DI14:   in  std_logic;
             DI13:   in  std_logic;
             DI12:   in  std_logic;
             DI11:   in  std_logic;
             DI10:   in  std_logic;
             DI9:    in  std_logic;
             DI8:    in  std_logic;
             DI7:    in  std_logic;
             DI6:    in  std_logic;
             DI5:    in  std_logic;
             DI4:    in  std_logic;
             DI3:    in  std_logic;
             DI2:    in  std_logic;
             DI1:    in  std_logic;
             DI0:    in  std_logic;
             CLKR:   in  std_logic;
             RE:     in  std_logic;
             ORE:    in  std_logic;
             CSR1:   in  std_logic;
             CSR0:   in  std_logic;
             DO17:   out std_logic;
             DO16:   out std_logic;
             DO15:   out std_logic;
             DO14:   out std_logic;
             DO13:   out std_logic;
             DO12:   out std_logic;
             DO11:   out std_logic;
             DO10:   out std_logic;
             DO9:    out std_logic;
             DO8:    out std_logic;
             DO7:    out std_logic;
             DO6:    out std_logic;
             DO5:    out std_logic;
             DO4:    out std_logic;
             DO3:    out std_logic;
             DO2:    out std_logic;
             DO1:    out std_logic;
             DO0:    out std_logic;
             AFF:    out std_logic;
             FF:     out std_logic;
             AEF:    out std_logic;
             EF:     out std_logic);
    end component;

    signal S_CLK:       std_logic;
    signal S_RST:       std_logic;
    signal S_PRE_TRIG:  std_logic_vector(9 downto 0);
    signal S_POST_TRIG: std_logic_vector(9 downto 0);
    signal S_TRIG:      std_logic;
    signal S_ADC:       std_logic_vector((G_ADC_RES - 1) downto 0);
    signal S_CLK_READ:  std_logic;
    signal S_EN_READ:   std_logic;
    signal S_DATA:      std_logic_vector((G_ADC_RES - 1) downto 0);

    signal S_W_PTR:     std_logic_vector(9 downto 0);

    signal S_PRE_TRIG_PTR:      std_logic_vector(9 downto 0);
    signal S_POST_TRIG_PTR_VAL: std_logic_vector(9 downto 0);
    signal S_POST_TRIG_PTR:     std_logic_vector(9 downto 0);

    signal S_R_EN:  std_logic;
    signal S_R_PTR: std_logic_vector(9 downto 0);

    signal S_TX_DATA: std_logic_vector((G_ADC_RES - 1) downto 0);

    signal S_FULL:  std_logic;
    signal S_EMPTY: std_logic;
begin
    S_CLK                                   <= I_CLK;
    S_RST                                   <= I_RST;
    S_PRE_TRIG(9)                           <= '1';
    S_PRE_TRIG(8)                           <= '1';
    S_PRE_TRIG((G_DATA_WDTH - 1) downto 0)  <= I_PRE_TRIG;
    S_POST_TRIG(9)                          <= '0';
    S_POST_TRIG(8)                          <= '0';
    S_POST_TRIG((G_DATA_WDTH - 1) downto 0) <= I_POST_TRIG;
    S_TRIG                                  <= I_TRIG;
    S_ADC                                   <= I_ADC;
    S_CLK_READ                              <= I_CLK_READ;
    S_EN_READ                               <= I_EN_READ;

    W_POINTER: UCNT generic map(G_WDTH => 10)
                    port map(I_CLK => S_CLK,
                             I_RST => S_RST,
                             I_EN  => '1',
                             I_LD  => '0',
                             I_VAL => (others => '0'),
                             O_CNT => S_W_PTR);

    PRE_TRIG_PTR: ADD10 port map(I_CLK => S_CLK,
                                 I_L   => S_PRE_TRIG,
                                 I_M   => S_W_PTR,
                                 O_N   => S_PRE_TRIG_PTR,
                                 O_C   => open);

    POST_TRIG_PTR: ADD10 port map(I_CLK => S_CLK,
                                  I_L   => S_POST_TRIG,
                                  I_M   => S_W_PTR,
                                  O_N   => S_POST_TRIG_PTR_VAL,
                                  O_C   => open);

     S_R_EN <= '1' when (S_R_PTR /= S_POST_TRIG_PTR) else '0';

     R_PTR: UCNT generic map(G_WDTH => 10)
                 port map(I_CLK => S_CLK,
                          I_RST => S_RST,
                          I_EN  => S_R_EN,
                          I_LD  => S_TRIG,
                          I_VAL => S_PRE_TRIG_PTR,
                          O_CNT => S_R_PTR);

     GEN_PT_PTR: for I in 0 to 9 generate
         DTFF_PT_PTRX: FD1S3IX generic map(GSR => "ENABLED")
                               port map(CK => S_CLK,
                                        CD => S_RST,
                                        D  => S_POST_TRIG_PTR_VAL(I),
                                        Q  => S_POST_TRIG_PTR(I));
     end generate GEN_PT_PTR;

     CIRCRAM: DP8KC generic map(INIT_DATA           => "STATIC",
                                INITVAL_1F          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_1E          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_1D          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_1C          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_1B          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_1A          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_19          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_18          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_17          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_16          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_15          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_14          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_13          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_12          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_11          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_10          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_0F          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_0E          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_0D          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_0C          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_0B          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_0A          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_09          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_08          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_07          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_06          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_05          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_04          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_03          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_02          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_01          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",
                                INITVAL_00          => "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000",

                                RESETMODE           => "SYNC",
                                GSR                 => "ENABLED",
                                ASYNC_RESET_RELEASE => "SYNC",

                                CSDECODE_A          => "0b000",
                                WRITEMODE_A         => "NORMAL",
                                REGMODE_A           => "NOREG",
                                DATA_WIDTH_A        => 9,

                                CSDECODE_B          => "0b000",
                                WRITEMODE_B         => "NORMAL",
                                REGMODE_B           => "NOREG",
                                DATA_WIDTH_B        => 9)
                    port map(CEA   => '1',
                             CLKA  => S_CLK,
                             WEA   => '1',
                             CSA2  => '0',
                             CSA1  => '0',
                             CSA0  => '0',
                             RSTA  => S_RST,
                             CEB   => S_R_EN,
                             CLKB  => S_CLK,
                             WEB   => '0',
                             CSB2  => '0',
                             CSB1  => '0',
                             CSB0  => '0',
                             RSTB  => S_RST,
                             DIA8  => '0',
                             DIA7  => S_ADC(7),
                             DIA6  => S_ADC(6),
                             DIA5  => S_ADC(5),
                             DIA4  => S_ADC(4),
                             DIA3  => S_ADC(3),
                             DIA2  => S_ADC(2),
                             DIA1  => S_ADC(1),
                             DIA0  => S_ADC(0),
                             ADA12 => S_W_PTR(9),
                             ADA11 => S_W_PTR(8),
                             ADA10 => S_W_PTR(7),
                             ADA9  => S_W_PTR(6),
                             ADA8  => S_W_PTR(5),
                             ADA7  => S_W_PTR(4),
                             ADA6  => S_W_PTR(3),
                             ADA5  => S_W_PTR(2),
                             ADA4  => S_W_PTR(1),
                             ADA3  => S_W_PTR(0),
                             ADA2  => '0',
                             ADA1  => '0',
                             ADA0  => '0',
                             DIB8  => '0',
                             DIB7  => '0',
                             DIB6  => '0',
                             DIB5  => '0',
                             DIB4  => '0',
                             DIB3  => '0',
                             DIB2  => '0',
                             DIB1  => '0',
                             DIB0  => '0',
                             ADB12 => S_R_PTR(9),
                             ADB11 => S_R_PTR(8),
                             ADB10 => S_R_PTR(7),
                             ADB9  => S_R_PTR(6),
                             ADB8  => S_R_PTR(5),
                             ADB7  => S_R_PTR(4),
                             ADB6  => S_R_PTR(3),
                             ADB5  => S_R_PTR(2),
                             ADB4  => S_R_PTR(1),
                             ADB3  => S_R_PTR(0),
                             ADB2  => '0',
                             ADB1  => '0',
                             ADB0  => '0',
                             OCEA  => '0',
                             OCEB  => '1',
                             DOA8  => open,
                             DOA7  => open,
                             DOA6  => open,
                             DOA5  => open,
                             DOA4  => open,
                             DOA3  => open,
                             DOA2  => open,
                             DOA1  => open,
                             DOA0  => open,
                             DOB8  => open,
                             DOB7  => S_TX_DATA(7),
                             DOB6  => S_TX_DATA(6),
                             DOB5  => S_TX_DATA(5),
                             DOB4  => S_TX_DATA(4),
                             DOB3  => S_TX_DATA(3),
                             DOB2  => S_TX_DATA(2),
                             DOB1  => S_TX_DATA(1),
                             DOB0  => S_TX_DATA(0));

    EVNTRAM: FIFO8KB generic map(GSR                 => "ENABLED",
                                 AEPONTER            => "0b00000110011111",
                                 AEPOINTER1          => "0b00000110100111",
                                 AFPOINTER           => "0b01111001100001",
                                 AFPOINTER1          => "0b01111001011001",
                                 FULLPOINTER         => "0b01111111111001",
                                 FULLPOINTER1        => "0b01111111110001",
                                 REGMODE             => "NOREG",
                                 RESETMODE           => "ASYNC",
                                 ASYNC_RESET_RELEASE => "SYNC",
                                 CSDECODE_W          => "0b11",
                                 DATA_WIDTH_W        => 9,
                                 CSDECODE_R          => "0b11",
                                 DATA_WIDTH_R        => 9)
                     port map(RST    => S_RST,
                              RPRST  => '0',
                              FULLI  => S_FULL,
                              EMPTYI => S_EMPTY,
                              CLKW   => S_CLK,
                              WE     => S_R_EN,
                              CSW1   => '1',
                              CSW0   => '1',
                              DI17   => '0',
                              DI16   => '0',
                              DI15   => '0',
                              DI14   => '0',
                              DI13   => '0',
                              DI12   => '0',
                              DI11   => '0',
                              DI10   => '0',
                              DI9    => '0',
                              DI8    => '0',
                              DI7    => S_TX_DATA(7),
                              DI6    => S_TX_DATA(6),
                              DI5    => S_TX_DATA(5),
                              DI4    => S_TX_DATA(4),
                              DI3    => S_TX_DATA(3),
                              DI2    => S_TX_DATA(2),
                              DI1    => S_TX_DATA(1),
                              DI0    => S_TX_DATA(0),
                              CLKR   => S_CLK_READ,
                              RE     => S_EN_READ,
                              ORE    => S_EN_READ,
                              CSR1   => '1',
                              CSR0   => '1',
                              DO17   => open,
                              DO16   => open,
                              DO15   => open,
                              DO14   => open,
                              DO13   => open,
                              DO12   => open,
                              DO11   => open,
                              DO10   => open,
                              DO9    => open,
                              DO8    => open,
                              DO7    => S_DATA(7),
                              DO6    => S_DATA(6),
                              DO5    => S_DATA(5),
                              DO4    => S_DATA(4),
                              DO3    => S_DATA(3),
                              DO2    => S_DATA(2),
                              DO1    => S_DATA(1),
                              DO0    => S_DATA(0),
                              AFF    => open,
                              FF     => S_FULL,
                              AEF    => open,
                              EF     => S_EMPTY);

    O_DATA <= S_DATA;
end STRUCTURAL;
