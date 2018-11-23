library ieee;
use ieee.std_logic_1164.all;

library machxo2;
use machxo2.components.all;

entity BPIF is
    generic(G_ADDR_WDTH: integer := 6;
            G_DATA_WDTH: integer := 8);
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
end BPIF;

architecture STRUCTURAL of BPIF is
    component REG_RW is
        generic(G_ADDR_WDTH: integer := 8;
                G_ADDR:      integer := 0;
                G_DATA_WDTH: integer := 8);
        port(I_CLK:   in    std_logic;
             I_nRW:   in    std_logic;
             I_ADDR:  in    std_logic_vector((G_ADDR_WDTH - 1) downto 0);
             IO_DATA: inout std_logic_vector((G_DATA_WDTH - 1) downto 0);
             O_DATA:  out   std_logic_vector((G_DATA_WDTH - 1) downto 0));
    end component;

    signal S_CLK:  std_logic;
    signal S_nRW:  std_logic;
    signal S_ADDR: std_logic_vector((G_ADDR_WDTH - 1) downto 0);
    signal S_DATA: std_logic_vector((G_DATA_WDTH - 1) downto 0);
    signal S_REG0: std_logic_vector((G_DATA_WDTH - 1) downto 0);
    signal S_REG1: std_logic_vector((G_DATA_WDTH - 1) downto 0);
    signal S_REG2: std_logic_vector((G_DATA_WDTH - 1) downto 0);
    signal S_REG3: std_logic_vector((G_DATA_WDTH - 1) downto 0);
    signal S_REG4: std_logic_vector((G_DATA_WDTH - 1) downto 0);
    signal S_REG5: std_logic_vector((G_DATA_WDTH - 1) downto 0);
    signal S_REG6: std_logic_vector((G_DATA_WDTH - 1) downto 0);
begin
    S_CLK  <= I_CLK;
    S_nRW  <= I_nRW;
    S_ADDR <= I_ADDR;
    S_DATA <= IO_DATA;

    REG0: REG_RW generic map(G_ADDR_WDTH => G_ADDR_WDTH,
                             G_ADDR      => 0,
                             G_DATA_WDTH => G_DATA_WDTH)
                 port map(I_CLK   => S_CLK,
                          I_nRW   => S_nRW,
                          I_ADDR  => S_ADDR,
                          IO_DATA => S_DATA,
                          O_DATA  => S_REG0);

    REG1: REG_RW generic map(G_ADDR_WDTH => G_ADDR_WDTH,
                             G_ADDR      => 1,
                             G_DATA_WDTH => G_DATA_WDTH)
                 port map(I_CLK   => S_CLK,
                          I_nRW   => S_nRW,
                          I_ADDR  => S_ADDR,
                          IO_DATA => S_DATA,
                          O_DATA  => S_REG1);

    REG2: REG_RW generic map(G_ADDR_WDTH => G_ADDR_WDTH,
                             G_ADDR      => 2,
                             G_DATA_WDTH => G_DATA_WDTH)
                 port map(I_CLK   => S_CLK,
                          I_nRW   => S_nRW,
                          I_ADDR  => S_ADDR,
                          IO_DATA => S_DATA,
                          O_DATA  => S_REG2);

    REG3: REG_RW generic map(G_ADDR_WDTH => G_ADDR_WDTH,
                             G_ADDR      => 3,
                             G_DATA_WDTH => G_DATA_WDTH)
                 port map(I_CLK   => S_CLK,
                          I_nRW   => S_nRW,
                          I_ADDR  => S_ADDR,
                          IO_DATA => S_DATA,
                          O_DATA  => S_REG3);

    REG4: REG_RW generic map(G_ADDR_WDTH => G_ADDR_WDTH,
                             G_ADDR      => 4,
                             G_DATA_WDTH => G_DATA_WDTH)
                 port map(I_CLK   => S_CLK,
                          I_nRW   => S_nRW,
                          I_ADDR  => S_ADDR,
                          IO_DATA => S_DATA,
                          O_DATA  => S_REG4);

    REG5: REG_RW generic map(G_ADDR_WDTH => G_ADDR_WDTH,
                             G_ADDR      => 5,
                             G_DATA_WDTH => G_DATA_WDTH)
                 port map(I_CLK   => S_CLK,
                          I_nRW   => S_nRW,
                          I_ADDR  => S_ADDR,
                          IO_DATA => S_DATA,
                          O_DATA  => S_REG5);

    REG6: REG_RW generic map(G_ADDR_WDTH => G_ADDR_WDTH,
                             G_ADDR      => 6,
                             G_DATA_WDTH => G_DATA_WDTH)
                 port map(I_CLK   => S_CLK,
                          I_nRW   => S_nRW,
                          I_ADDR  => S_ADDR,
                          IO_DATA => S_DATA,
                          O_DATA  => S_REG6);

    O_REG0 <= S_REG0;
    O_REG1 <= s_REG1;
    O_REG2 <= S_REG2;
    O_REG3 <= s_REG3;
    O_REG4 <= S_REG4;
    O_REG5 <= s_REG5;
    O_REG6 <= S_REG6;
end STRUCTURAL;
