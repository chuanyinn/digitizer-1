library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity UCNT is
    generic(G_WDTH: integer := 8);
    port(I_CLK: in  std_logic;
         I_RST: in  std_logic;
         I_EN:  in  std_logic;
         I_LD:  in  std_logic;
         I_VAL: in  std_logic_vector((G_WDTH - 1) downto 0);
         O_CNT: out std_logic_vector((G_WDTH - 1) downto 0));
end UCNT;

architecture BEHAVIORAL of UCNT is
    signal S_CNT: std_logic_vector((G_WDTH - 1) downto 0) := (others => '0');
begin
    process(I_CLK)
    begin
        if(rising_edge(I_CLK)) then
            if(I_RST = '1') then
                S_CNT <= (others => '0');
            elsif(I_LD = '1') then
                S_CNT <= I_VAL;
            elsif(I_EN = '1') then
                S_CNT <= S_CNT + '1';
            end if;
        end if;
    end process;

	O_CNT <= S_CNT;
end BEHAVIORAL;
