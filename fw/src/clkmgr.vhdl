library ieee;
use ieee.std_logic_1164.all;

library machxo2;
use machxo2.components.all;

entity CLKMGR is
    port(I_CLK:  in  std_logic;
         O_CLK:  out std_logic;
         O_LOCK: out std_logic);
end CLKMGR;

architecture STRUCTURAL of CLKMGR is
    component EHXPLLJ is
        generic(-- Input Clock --
                CLKI_DIV:      Integer;

                -- Clock OP --
                CLKOP_ENABLE:     String;
                VCO_BYPASS_A0:    String;
                PREDIVIDER_MUXA1: Integer;
                CLKOP_DIV:        Integer;
                CLKOP_CPHASE:     Integer;
                CLKOP_FPHASE:     Integer;
                CLKOP_TRIM_POL:   String;
                CLKOP_TRIM_DELAY: Integer;
                OUTDIVIDER_MUXA2: String;

                -- Clock OS --
                CLKOS_ENABLE:     String;
                VCO_BYPASS_B0:    String;
                PREDIVIDER_MUXB1: Integer;
                CLKOS_DIV:        Integer;
                CLKOS_CPHASE:     Integer;
                CLKOS_FPHASE:     Integer;
                CLKOS_TRIM_POL:   String;
                CLKOS_TRIM_DELAY: Integer;
                OUTDIVIDER_MUXB2: String;

                -- Clock OS 2 --
                CLKOS2_ENABLE:    String;
                VCO_BYPASS_C0:    String;
                PREDIVIDER_MUXC1: Integer;
                CLKOS2_DIV:       Integer;
                CLKOS2_CPHASE:    Integer;
                CLKOS2_FPHASE:    Integer;
                OUTDIVIDER_MUXC2: String;

                -- Clock OS 3 --
                CLKOS3_Enable:    String;
                VCO_BYPASS_D0:    String;
                PREDIVIDER_MUXD1: Integer;
                CLKOS3_DIV:       Integer;
                CLKOS3_CPHASE:    Integer;
                CLKOS3_FPHASE:    Integer;
                OUTDIVIDER_MUXD2: String;

                -- Feedback Clock --
                FEEDBK_PATH: String;
                CLKFB_DIV: Integer;
                INTFB_WAKE: String;

                -- Frac N Synthesizer --
                FRACN_ENABLE: String;
                FRACN_DIV: Integer;

                -- PLL Lock --
                PLL_LOCK_MODE: Integer;

                -- Reset Enables --
                PLLRST_ENA: String;
                MRST_ENA: String;
                DCRST_ENA: String;
                DDRST_ENA: String;

                -- Not sure what these do yet? --
                STDBY_ENABLE: String;
                DPHASE_SOURCE: String);
        port(CLKI:        in  std_logic;
             CLKFB:       in  std_logic;
             PHASESEL1:   in  std_logic;
             PHASESEL0:   in  std_logic;
             PHASEDIR:    in  std_logic;
             PHASESTEP:   in  std_logic;
             LOADREG:     in  std_logic;
             STDBY:       in  std_logic;
             PLLWAKESYNC: in  std_logic;
             RST:         in  std_logic;
             RESETM:      in  std_logic;
             RESETC:      in  std_logic;
             RESETD:      in  std_logic;
             ENCLKOP:     in  std_logic;
             ENCLKOS:     in  std_logic;
             ENCLKOS2:    in  std_logic;
             ENCLKOS3:    in  std_logic;
             PLLCLK:      in  std_logic;
             PLLRST:      in  std_logic;
             PLLSTB:      in  std_logic;
             PLLWE:       in  std_logic;
             PLLDATI7:    in  std_logic;
             PLLDATI6:    in  std_logic;
             PLLDATI5:    in  std_logic;
             PLLDATI4:    in  std_logic;
             PLLDATI3:    in  std_logic;
             PLLDATI2:    in  std_logic;
             PLLDATI1:    in  std_logic;
             PLLDATI0:    in  std_logic;
             PLLADDR4:    in  std_logic;
             PLLADDR3:    in  std_logic;
             PLLADDR2:    in  std_logic;
             PLLADDR1:    in  std_logic;
             PLLADDR0:    in  std_logic;
             CLKOP:       out std_logic;
             CLKOS:       out std_logic;
             CLKOS2:      out std_logic;
             CLKOS3:      out std_logic;
             LOCK:        out std_logic;
             INTLOCK:     out std_logic;
             REFCLK:      out std_logic;
             DPHSRC:      out std_logic;
             PLLDATO7:    out std_logic;
             PLLDATO6:    out std_logic;
             PLLDATO5:    out std_logic;
             PLLDATO4:    out std_logic;
             PLLDATO3:    out std_logic;
             PLLDATO2:    out std_logic;
             PLLDATO1:    out std_logic;
             PLLDATO0:    out std_logic;
             PLLACK:      out std_logic);
    end component;

    attribute ICP_CURRENT: string;
    attribute ICP_CURRENT of PLL: label is "8";

    attribute LPF_RESISTOR: string;
    attribute LPF_RESISTOR of PLL: label is "8";

    signal S_I_CLK: std_logic;
    signal S_O_CLK: std_logic;
    signal S_LOCK:  std_logic;
begin
    S_I_CLK <= I_CLK;

    PLL: EHXPLLJ generic map(CLKI_DIV => 2,

                             -- Clock OP --
                             CLKOP_ENABLE => "ENABLED",
                             VCO_BYPASS_A0 => "DISABLED",
                             PREDIVIDER_MUXA1 => 0,
                             CLKOP_DIV => 42,
                             CLKOP_CPHASE => 41,
                             CLKOP_FPHASE => 0,
                             CLKOP_TRIM_POL => "RISING",
                             CLKOP_TRIM_DELAY => 0,
                             OUTDIVIDER_MUXA2 => "DIVA",

                             -- Clock OS --
                             CLKOS_ENABLE => "DISABLED",
                             VCO_BYPASS_B0 => "DISABLED",
                             PREDIVIDER_MUXB1 => 0,
                             CLKOS_DIV => 42,
                             CLKOS_CPHASE => 41,
                             CLKOS_FPHASE => 0,
                             CLKOS_TRIM_POL => "RISING",
                             CLKOS_TRIM_DELAY => 0,
                             OUTDIVIDER_MUXB2 => "DIVB",

                             -- Clock OS 2 --
                             CLKOS2_ENABLE => "DISABLED",
                             VCO_BYPASS_C0 => "DISABLED",
                             PREDIVIDER_MUXC1 => 0,
                             CLKOS2_DIV => 42,
                             CLKOS2_CPHASE => 41,
                             CLKOS2_FPHASE => 0,
                             OUTDIVIDER_MUXC2 => "DIVC",

                             -- Clock OS 3 --
                             CLKOS3_Enable => "DISABLED",
                             VCO_BYPASS_D0 => "DISABLED",
                             PREDIVIDER_MUXD1 => 0,
                             CLKOS3_DIV => 42,
                             CLKOS3_CPHASE => 41,
                             CLKOS3_FPHASE => 0,
                             OUTDIVIDER_MUXD2 => "DIVD",

                             -- Feedback Clock --
                             FEEDBK_PATH => "CLKOP",
                             CLKFB_DIV => 1,
                             INTFB_WAKE => "DISABLED",

                             -- Frac N Synthesizer --
                             FRACN_ENABLE => "DISABLED",
                             FRACN_DIV => 0,

                             -- PLL Lock --
                             PLL_LOCK_MODE => 0,

                             -- Reset Enables --
                             PLLRST_ENA => "DISABLED",
                             MRST_ENA => "DISABLED",
                             DCRST_ENA => "DISABLED",
                             DDRST_ENA => "DISABLED",

                             -- Not sure what these do yet? --
                             STDBY_ENABLE => "DISABLED",
                             DPHASE_SOURCE => "DISABLED")
                 port map(CLKI        => S_I_CLK,
                          CLKFB       => S_O_CLK,
                          PHASESEL1   => '0',
                          PHASESEL0   => '0',
                          PHASEDIR    => '0',
                          PHASESTEP   => '0',
                          LOADREG     => '0',
                          STDBY       => '0',
                          PLLWAKESYNC => '0',
                          RST         => '0',
                          RESETM      => '0',
                          RESETC      => '0',
                          RESETD      => '0',
                          ENCLKOP     => '0',
                          ENCLKOS     => '0',
                          ENCLKOS2    => '0',
                          ENCLKOS3    => '0',
                          PLLCLK      => '0',
                          PLLRST      => '0',
                          PLLSTB      => '0',
                          PLLWE       => '0',
                          PLLDATI7    => '0',
                          PLLDATI6    => '0',
                          PLLDATI5    => '0',
                          PLLDATI4    => '0',
                          PLLDATI3    => '0',
                          PLLDATI2    => '0',
                          PLLDATI1    => '0',
                          PLLDATI0    => '0',
                          PLLADDR4    => '0',
                          PLLADDR3    => '0',
                          PLLADDR2    => '0',
                          PLLADDR1    => '0',
                          PLLADDR0    => '0',
                          CLKOP       => S_O_CLK,
                          CLKOS       => open,
                          CLKOS2      => open,
                          CLKOS3      => open,
                          LOCK        => S_LOCK,
                          INTLOCK     => open,
                          REFCLK      => open,
                          DPHSRC      => open,
                          PLLDATO7    => open,
                          PLLDATO6    => open,
                          PLLDATO5    => open,
                          PLLDATO4    => open,
                          PLLDATO3    => open,
                          PLLDATO2    => open,
                          PLLDATO1    => open,
                          PLLDATO0    => open,
                          PLLACK      => open);

    O_CLK  <= S_O_CLK;
    O_LOCK <= S_LOCK;
end STRUCTURAL;
