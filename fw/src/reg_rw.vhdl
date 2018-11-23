library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library machxo2;
use machxo2.components.all;

entity REG_RW is
    generic(G_ADDR_WDTH: integer := 8;
            G_ADDR:      integer := 0;
            G_DATA_WDTH: integer := 8);
    port(I_CLK:   in    std_logic;
         I_nRW:   in    std_logic;
         I_ADDR:  in    std_logic_vector((G_ADDR_WDTH - 1) downto 0);
         IO_DATA: inout std_logic_vector((G_DATA_WDTH - 1) downto 0);
         O_DATA:  out   std_logic_vector((G_DATA_WDTH - 1) downto 0));
end REG_RW;

architecture STRUCTURAL of REG_RW is
    component FD1P3AX is
        generic(GSR: string);
        port(CK: in  std_logic;
             SP: in  std_logic;
             D:  in  std_logic;
             Q:  out std_logic);
    end component;

    signal S_CLK:     std_logic;
    signal S_nRW:     std_logic;
    signal S_ADDR:    std_logic_vector((G_ADDR_WDTH - 1) downto 0);
    signal S_IO_DATA: std_logic_vector((G_DATA_WDTH - 1) downto 0);
    signal S_DATA:    std_logic_vector((G_DATA_WDTH - 1) downto 0);

    signal S_SELECT: std_logic;
    signal S_READ:   std_logic;
    signal S_WRITE:  std_logic;
begin
    S_CLK     <= I_CLK;
    S_nRW     <= I_nRW;
    S_ADDR    <= I_ADDR;
    S_IO_DATA <= IO_DATA;

    S_SELECT <= '1' when (S_ADDR = std_logic_vector(to_unsigned(G_ADDR, G_ADDR_WDTH))) else '0';
    S_READ   <= S_SELECT and not(S_nRW);
    S_WRITE  <= S_SELECT and S_nRW;

    GEN_REG_RW: for I in 0 to (G_DATA_WDTH - 1) generate
        DTFFX: FD1P3AX generic map(GSR => "ENABLED")
                       port map(CK => S_CLK,
                                SP => S_WRITE,
                                D  => S_IO_DATA(I),
                                Q  => S_DATA(I));
    end generate GEN_REG_RW;

    S_IO_DATA <= S_DATA when (S_READ = '1') else (others => 'Z');

    O_DATA <= S_DATA;
end STRUCTURAL;
