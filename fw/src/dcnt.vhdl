library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity DCNT is
    generic(G_WDTH: integer := 8);
    port(I_CLK: in  std_logic;
         I_RST: in  std_logic;
         I_LD:  in  std_logic;
         I_EN:  in  std_logic;
         I_VAL: in  std_logic_vector((G_WDTH - 1) downto 0);
         O_CNT: out std_logic_vector((G_WDTH - 1) downto 0));
end DCNT;

architecture BEHAVIORAL of DCNT is
    signal S_CLK: std_logic;
    signal S_RST: std_logic;
    signal S_LD:  std_logic;
    signal S_EN:  std_logic;
    signal S_VAL: std_logic_vector((G_WDTH - 1) downto 0);
    signal S_CNT: std_logic_vector((G_WDTH - 1) downto 0) := (others => '0');
begin
    S_CLK <= I_CLK;
    S_RST <= I_RST;
    S_LD  <= I_LD;
    S_EN  <= I_EN;
    S_VAL <= I_VAL;

    process(S_CLK)
    begin
        if(rising_edge(S_CLK)) then
            if(S_RST = '1') then
                S_CNT <= (others => '0');
            elsif(S_LD = '1') then
                S_CNT <= S_VAL;
            elsif(S_EN = '1') then
                S_CNT <= S_CNT + '1';
            end if;
        end if;
    end process;

    O_CNT <= S_CNT;
end BEHAVIORAL;
