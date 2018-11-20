library ieee;
use ieee.std_logic_1164.all;

library machxo2;
use machxo2.components.all;

entity EDETR is
    port(I_CLK:   in  std_logic;
         I_SIG:   in  std_logic;
         O_PULSE: out std_logic);
end EDETR;

architecture STRUCTURAL of EDETR is
    component FD1S3AX is
        generic(GSR: string);
        port(CK: in  std_logic;
             D:  in  std_logic;
             Q:  out std_logic);
    end component;

    signal S_CLK:   std_logic;
    signal S_SIG:   std_logic;
    signal S_PULSE: std_logic;

    signal S_SIG_t2: std_logic;
    signal S_SIG_t1: std_logic;
begin
    S_CLK <= I_CLK;
    S_SIG <= I_SIG;

    DTFF_t2: FD1S3AX generic map(GSR => "ENABLED")
                     port map(CK => S_CLK,
                              D  => S_SIG,
                              Q  => S_SIG_t2);

    DTFF_t1: FD1S3AX generic map(GSR => "ENABLED")
                     port map(CK => S_CLK,
                              D  => S_SIG_t2,
                              Q  => S_SIG_t1);

    S_PULSE <= S_SIG_t2 and (not S_SIG_t1);

    O_PULSE <= S_PULSE;
end STRUCTURAL;
