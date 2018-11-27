library ieee;
use ieee.std_logic_1164.all;

library machxo2;
use machxo2.components.all;

entity ADD10 is
    port(I_CLK: in  std_logic;
         I_L:   in  std_logic_vector(9 downto 0);
         I_M:   in  std_logic_vector(9 downto 0);
         O_N:   out std_logic_vector(9 downto 0);
         O_C:   out std_logic);
end ADD10;

architecture STRUCTURAL of ADD10 is
    component FD1S3AX is
        generic(GSR: string);
        port(CK: in  std_logic;
             D:  in  std_logic;
             Q:  out std_logic);
    end component;

    component ADD2 is
        port(I_L0: in  std_logic;
             I_L1: in  std_logic;
             I_M0: in  std_logic;
             I_M1: in  std_logic;
             O_N0: out std_logic;
             O_N1: out std_logic;
             O_C:  out std_logic);
    end component;

    signal S_CLK: std_logic;
    signal S_L:   std_logic_vector(9 downto 0);
    signal S_M:   std_logic_vector(9 downto 0);
    signal S_N:   std_logic_vector(9 downto 0);
    signal S_C:   std_logic;

    signal S_ADD2_1_N0: std_logic;
    signal S_ADD2_1_N1: std_logic;
    signal S_ADD2_1_C:  std_logic;

    signal S_ADD2_2_N0: std_logic;
    signal S_ADD2_2_N1: std_logic;
    signal S_ADD2_2_C:  std_logic;

    signal S_ADD2_3_N0: std_logic;
    signal S_ADD2_3_N1: std_logic;
    signal S_ADD2_3_C:  std_logic;

    signal S_ADD2_4_N0: std_logic;
    signal S_ADD2_4_N1: std_logic;
    signal S_ADD2_4_C:  std_logic;

    signal S_ADD2_5_N0: std_logic;
    signal S_ADD2_5_N1: std_logic;
    signal S_ADD2_5_C:  std_logic;

    signal S_DTFF1_Q:  std_logic;
    signal S_DTFF2_Q:  std_logic;
    signal S_DTFF3_Q:  std_logic;
    signal S_DTFF4_Q:  std_logic;
    signal S_DTFF5_Q:  std_logic;
    signal S_DTFF6_Q:  std_logic;
    signal S_DTFF7_Q:  std_logic;
    signal S_DTFF8_Q:  std_logic;
    signal S_DTFF9_Q:  std_logic;
    signal S_DTFF10_Q: std_logic;
    signal S_DTFF11_Q: std_logic;
    signal S_DTFF12_Q: std_logic;
    signal S_DTFF13_Q: std_logic;
    signal S_DTFF14_Q: std_logic;
    signal S_DTFF15_Q: std_logic;

    signal S_ADD2_6_N0: std_logic;
    signal S_ADD2_6_N1: std_logic;
    signal S_ADD2_6_C:  std_logic;

    signal S_ADD2_7_N0: std_logic;
    signal S_ADD2_7_N1: std_logic;
    signal S_ADD2_7_C:  std_logic;

    signal S_ADD2_8_N0: std_logic;
    signal S_ADD2_8_N1: std_logic;
    signal S_ADD2_8_C:  std_logic;

    signal S_ADD2_9_N0: std_logic;
    signal S_ADD2_9_N1: std_logic;
    signal S_ADD2_9_C:  std_logic;

    signal S_OR1: std_logic;

    signal S_DTFF16_Q: std_logic;
    signal S_DTFF17_Q: std_logic;
    signal S_DTFF18_Q: std_logic;
    signal S_DTFF19_Q: std_logic;
    signal S_DTFF20_Q: std_logic;
    signal S_DTFF21_Q: std_logic;
    signal S_DTFF22_Q: std_logic;
    signal S_DTFF23_Q: std_logic;
    signal S_DTFF24_Q: std_logic;
    signal S_DTFF25_Q: std_logic;
    signal S_DTFF26_Q: std_logic;
    signal S_DTFF27_Q: std_logic;
    signal S_DTFF28_Q: std_logic;
    signal S_DTFF29_Q: std_logic;

    signal S_ADD2_10_N0: std_logic;
    signal S_ADD2_10_N1: std_logic;
    signal S_ADD2_10_C:  std_logic;

    signal S_ADD2_11_N0: std_logic;
    signal S_ADD2_11_N1: std_logic;
    signal S_ADD2_11_C:  std_logic;

    signal S_ADD2_12_N0: std_logic;
    signal S_ADD2_12_N1: std_logic;
    signal S_ADD2_12_C:  std_logic;

    signal S_OR2: std_logic;

    signal S_DTFF30_Q: std_logic;
    signal S_DTFF31_Q: std_logic;
    signal S_DTFF32_Q: std_logic;
    signal S_DTFF33_Q: std_logic;
    signal S_DTFF34_Q: std_logic;
    signal S_DTFF35_Q: std_logic;
    signal S_DTFF36_Q: std_logic;
    signal S_DTFF37_Q: std_logic;
    signal S_DTFF38_Q: std_logic;
    signal S_DTFF39_Q: std_logic;
    signal S_DTFF40_Q: std_logic;
    signal S_DTFF41_Q: std_logic;
    signal S_DTFF42_Q: std_logic;

    signal S_ADD2_13_N0: std_logic;
    signal S_ADD2_13_N1: std_logic;
    signal S_ADD2_13_C:  std_logic;

    signal S_ADD2_14_N0: std_logic;
    signal S_ADD2_14_N1: std_logic;
    signal S_ADD2_14_C:  std_logic;

    signal S_OR3: std_logic;

    signal S_DTFF43_Q: std_logic;
    signal S_DTFF44_Q: std_logic;
    signal S_DTFF45_Q: std_logic;
    signal S_DTFF46_Q: std_logic;
    signal S_DTFF47_Q: std_logic;
    signal S_DTFF48_Q: std_logic;
    signal S_DTFF49_Q: std_logic;
    signal S_DTFF50_Q: std_logic;
    signal S_DTFF51_Q: std_logic;
    signal S_DTFF52_Q: std_logic;
    signal S_DTFF53_Q: std_logic;
    signal S_DTFF54_Q: std_logic;

    signal S_ADD2_15_N0: std_logic;
    signal S_ADD2_15_N1: std_logic;
    signal S_ADD2_15_C:  std_logic;

    signal S_OR4: std_logic;
begin
    S_CLK <= I_CLK;
    S_L   <= I_L;
    S_M   <= I_M;

    ADD2_1: ADD2 port map(I_L0 => S_L(0),
                          I_L1 => S_L(1),
                          I_M0 => S_M(0),
                          I_M1 => S_M(1),
                          O_N0 => S_ADD2_1_N0,
                          O_N1 => S_ADD2_1_N1,
                          O_C  => S_ADD2_1_C);
    --
    ADD2_2: ADD2 port map(I_L0 => S_L(2),
                          I_L1 => S_L(3),
                          I_M0 => S_M(2),
                          I_M1 => S_M(3),
                          O_N0 => S_ADD2_2_N0,
                          O_N1 => S_ADD2_2_N1,
                          O_C  => S_ADD2_2_C);
    --
    ADD2_3: ADD2 port map(I_L0 => S_L(4),
                          I_L1 => S_L(5),
                          I_M0 => S_M(4),
                          I_M1 => S_M(5),
                          O_N0 => S_ADD2_3_N0,
                          O_N1 => S_ADD2_3_N1,
                          O_C  => S_ADD2_3_C);
    --
    ADD2_4: ADD2 port map(I_L0 => S_L(6),
                          I_L1 => S_L(7),
                          I_M0 => S_M(6),
                          I_M1 => S_M(7),
                          O_N0 => S_ADD2_4_N0,
                          O_N1 => S_ADD2_4_N1,
                          O_C  => S_ADD2_4_C);
    --
    ADD2_5: ADD2 port map(I_L0 => S_L(8),
                          I_L1 => S_L(9),
                          I_M0 => S_M(8),
                          I_M1 => S_M(9),
                          O_N0 => S_ADD2_5_N0,
                          O_N1 => S_ADD2_5_N1,
                          O_C  => S_ADD2_5_C);
    --
    DTFF1: FD1S3AX generic map(GSR => "ENABLED")
                   port map(CK => S_CLK,
                            D  => S_ADD2_1_N0,
                            Q  => S_DTFF1_Q);
    --
    DTFF2: FD1S3AX generic map(GSR => "ENABLED")
                   port map(CK => S_CLK,
                            D  => S_ADD2_1_N1,
                            Q  => S_DTFF2_Q);
    --
    DTFF3: FD1S3AX generic map(GSR => "ENABLED")
                   port map(CK => S_CLK,
                            D  => S_ADD2_1_C,
                            Q  => S_DTFF3_Q);
    --
    DTFF4: FD1S3AX generic map(GSR => "ENABLED")
                   port map(CK => S_CLK,
                            D  => S_ADD2_2_N0,
                            Q  => S_DTFF4_Q);
    --
    DTFF5: FD1S3AX generic map(GSR => "ENABLED")
                   port map(CK => S_CLK,
                            D  => S_ADD2_2_N1,
                            Q  => S_DTFF5_Q);
    --
    DTFF6: FD1S3AX generic map(GSR => "ENABLED")
                   port map(CK => S_CLK,
                            D  => S_ADD2_2_C,
                            Q  => S_DTFF6_Q);
    --
    DTFF7: FD1S3AX generic map(GSR => "ENABLED")
                   port map(CK => S_CLK,
                            D  => S_ADD2_3_N0,
                            Q  => S_DTFF7_Q);
    --
    DTFF8: FD1S3AX generic map(GSR => "ENABLED")
                   port map(CK => S_CLK,
                            D  => S_ADD2_3_N1,
                            Q  => S_DTFF8_Q);
    --
    DTFF9: FD1S3AX generic map(GSR => "ENABLED")
                   port map(CK => S_CLK,
                            D  => S_ADD2_3_C,
                            Q  => S_DTFF9_Q);
    --
    DTFF10: FD1S3AX generic map(GSR => "ENABLED")
                   port map(CK => S_CLK,
                            D  => S_ADD2_4_N0,
                            Q  => S_DTFF10_Q);
    --
    DTFF11: FD1S3AX generic map(GSR => "ENABLED")
                   port map(CK => S_CLK,
                            D  => S_ADD2_4_N1,
                            Q  => S_DTFF11_Q);
    --
    DTFF12: FD1S3AX generic map(GSR => "ENABLED")
                   port map(CK => S_CLK,
                            D  => S_ADD2_4_C,
                            Q  => S_DTFF12_Q);
    --
    DTFF13: FD1S3AX generic map(GSR => "ENABLED")
                   port map(CK => S_CLK,
                            D  => S_ADD2_5_N0,
                            Q  => S_DTFF13_Q);
    --
    DTFF14: FD1S3AX generic map(GSR => "ENABLED")
                   port map(CK => S_CLK,
                            D  => S_ADD2_5_N1,
                            Q  => S_DTFF14_Q);
    --
    DTFF15: FD1S3AX generic map(GSR => "ENABLED")
                   port map(CK => S_CLK,
                            D  => S_ADD2_5_C,
                            Q  => S_DTFF15_Q);
    --
    ADD2_6: ADD2 port map(I_L0 => S_DTFF3_Q,
                          I_L1 => '0',
                          I_M0 => S_DTFF4_Q,
                          I_M1 => S_DTFF5_Q,
                          O_N0 => S_ADD2_6_N0,
                          O_N1 => S_ADD2_6_N1,
                          O_C  => S_ADD2_6_C);
    --
    ADD2_7: ADD2 port map(I_L0 => S_DTFF6_Q,
                          I_L1 => '0',
                          I_M0 => S_DTFF7_Q,
                          I_M1 => S_DTFF8_Q,
                          O_N0 => S_ADD2_7_N0,
                          O_N1 => S_ADD2_7_N1,
                          O_C  => S_ADD2_7_C);
    --
    ADD2_8: ADD2 port map(I_L0 => S_DTFF9_Q,
                          I_L1 => '0',
                          I_M0 => S_DTFF10_Q,
                          I_M1 => S_DTFF11_Q,
                          O_N0 => S_ADD2_8_N0,
                          O_N1 => S_ADD2_8_N1,
                          O_C  => S_ADD2_8_C);
    --
    ADD2_9: ADD2 port map(I_L0 => S_DTFF12_Q,
                          I_L1 => '0',
                          I_M0 => S_DTFF13_Q,
                          I_M1 => S_DTFF14_Q,
                          O_N0 => S_ADD2_9_N0,
                          O_N1 => S_ADD2_9_N1,
                          O_C  => S_ADD2_9_C);
    --
    S_OR1 <= S_DTFF15_Q or S_ADD2_9_C;
    --
    DTFF16: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_DTFF1_Q,
                             Q  => S_DTFF16_Q);
    --
    DTFF17: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_DTFF2_Q,
                             Q  => S_DTFF17_Q);
    --
    DTFF18: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_6_N0,
                             Q  => S_DTFF18_Q);
    --
    DTFF19: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_6_N1,
                             Q  => S_DTFF19_Q);
    --
    DTFF20: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_6_C,
                             Q  => S_DTFF20_Q);
    --
    DTFF21: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_7_N0,
                             Q  => S_DTFF21_Q);
    --
    DTFF22: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_7_N1,
                             Q  => S_DTFF22_Q);
    --
    DTFF23: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_7_C,
                             Q  => S_DTFF23_Q);
    --
    DTFF24: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_8_N0,
                             Q  => S_DTFF24_Q);
    --
    DTFF25: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_8_N1,
                             Q  => S_DTFF25_Q);
    --
    DTFF26: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_8_C,
                             Q  => S_DTFF26_Q);
    --
    DTFF27: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_9_N0,
                             Q  => S_DTFF27_Q);
    --
    DTFF28: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_9_N1,
                             Q  => S_DTFF28_Q);
    --
    DTFF29: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_OR1,
                             Q  => S_DTFF29_Q);
    --
    ADD2_10: ADD2 port map(I_L0 => S_DTFF20_Q,
                           I_L1 => '0',
                           I_M0 => S_DTFF21_Q,
                           I_M1 => S_DTFF22_Q,
                           O_N0 => S_ADD2_10_N0,
                           O_N1 => S_ADD2_10_N1,
                           O_C  => S_ADD2_10_C);
    --
    ADD2_11: ADD2 port map(I_L0 => S_DTFF23_Q,
                           I_L1 => '0',
                           I_M0 => S_DTFF24_Q,
                           I_M1 => S_DTFF25_Q,
                           O_N0 => S_ADD2_11_N0,
                           O_N1 => S_ADD2_11_N1,
                           O_C  => S_ADD2_11_C);
    --
    ADD2_12: ADD2 port map(I_L0 => S_DTFF26_Q,
                           I_L1 => '0',
                           I_M0 => S_DTFF27_Q,
                           I_M1 => S_DTFF28_Q,
                           O_N0 => S_ADD2_12_N0,
                           O_N1 => S_ADD2_12_N1,
                           O_C  => S_ADD2_12_C);
    --
    S_OR2 <= S_DTFF29_Q or S_ADD2_12_C;
    --
    DTFF30: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_DTFF16_Q,
                             Q  => S_DTFF30_Q);
    --
    DTFF31: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_DTFF17_Q,
                             Q  => S_DTFF31_Q);
    --
    DTFF32: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_DTFF18_Q,
                             Q  => S_DTFF32_Q);
    --
    DTFF33: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_DTFF19_Q,
                             Q  => S_DTFF33_Q);
    --
    DTFF34: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_10_N0,
                             Q  => S_DTFF34_Q);
    --
    DTFF35: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_10_N1,
                             Q  => S_DTFF35_Q);
    --
    DTFF36: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_10_C,
                             Q  => S_DTFF36_Q);
    --
    DTFF37: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_11_N0,
                             Q  => S_DTFF37_Q);
    --
    DTFF38: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_11_N1,
                             Q  => S_DTFF38_Q);
    --
    DTFF39: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_11_C,
                             Q  => S_DTFF39_Q);
    --
    DTFF40: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_12_N0,
                             Q  => S_DTFF40_Q);
    --
    DTFF41: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_12_N1,
                             Q  => S_DTFF41_Q);
    --
    DTFF42: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_OR2,
                             Q  => S_DTFF42_Q);
    --
    ADD2_13: ADD2 port map(I_L0 => S_DTFF36_Q,
                           I_L1 => '0',
                           I_M0 => S_DTFF37_Q,
                           I_M1 => S_DTFF38_Q,
                           O_N0 => S_ADD2_13_N0,
                           O_N1 => S_ADD2_13_N1,
                           O_C  => S_ADD2_13_C);
    --
    ADD2_14: ADD2 port map(I_L0 => S_DTFF39_Q,
                           I_L1 => '0',
                           I_M0 => S_DTFF40_Q,
                           I_M1 => S_DTFF41_Q,
                           O_N0 => S_ADD2_14_N0,
                           O_N1 => S_ADD2_14_N1,
                           O_C  => S_ADD2_14_C);
    --
    S_OR3 <= S_DTFF42_Q or S_ADD2_14_C;
    --
    DTFF43: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_DTFF30_Q,
                             Q  => S_DTFF43_Q);
    --
    DTFF44: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_DTFF31_Q,
                             Q  => S_DTFF44_Q);
    --
    DTFF45: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_DTFF32_Q,
                             Q  => S_DTFF45_Q);
    --
    DTFF46: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_DTFF33_Q,
                             Q  => S_DTFF46_Q);
    --
    DTFF47: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_DTFF34_Q,
                             Q  => S_DTFF47_Q);
    --
    DTFF48: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_DTFF35_Q,
                             Q  => S_DTFF48_Q);
    --
    DTFF49: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_13_N0,
                             Q  => S_DTFF49_Q);
    --
    DTFF50: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_13_N1,
                             Q  => S_DTFF50_Q);
    --
    DTFF51: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_13_C,
                             Q  => S_DTFF51_Q);
    --
    DTFF52: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_14_N0,
                             Q  => S_DTFF52_Q);
    --
    DTFF53: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_14_N1,
                             Q  => S_DTFF53_Q);
    --
    DTFF54: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_OR3,
                             Q  => S_DTFF54_Q);
    --
    ADD2_15: ADD2 port map(I_L0 => S_DTFF51_Q,
                           I_L1 => '0',
                           I_M0 => S_DTFF52_Q,
                           I_M1 => S_DTFF53_Q,
                           O_N0 => S_ADD2_15_N0,
                           O_N1 => S_ADD2_15_N1,
                           O_C  => S_ADD2_15_C);
    --
    S_OR4 <= S_DTFF54_Q or S_ADD2_15_C;
    --
    DTFF55: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_DTFF43_Q,
                             Q  => S_N(0));
    --
    DTFF56: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_DTFF44_Q,
                             Q  => S_N(1));
    --
    DTFF57: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_DTFF45_Q,
                             Q  => S_N(2));
    --
    DTFF58: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_DTFF46_Q,
                             Q  => S_N(3));
    --
    DTFF59: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_DTFF47_Q,
                             Q  => S_N(4));
    --
    DTFF60: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_DTFF48_Q,
                             Q  => S_N(5));
    --
    DTFF61: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_DTFF49_Q,
                             Q  => S_N(6));
    --
    DTFF62: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_DTFF50_Q,
                             Q  => S_N(7));
    --
    DTFF63: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_15_N0,
                             Q  => S_N(8));
    --
    DTFF64: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_ADD2_15_N1,
                             Q  => S_N(9));
    --
    DTFF65: FD1S3AX generic map(GSR => "ENABLED")
                    port map(CK => S_CLK,
                             D  => S_OR4,
                             Q  => S_C);
    --
    O_N <= S_N;
    O_C <= S_C;
end STRUCTURAL;
