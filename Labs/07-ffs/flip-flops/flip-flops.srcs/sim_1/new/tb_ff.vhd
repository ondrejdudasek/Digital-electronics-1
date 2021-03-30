----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2021 21:31:01
-- Design Name: 
-- Module Name: tb_ff - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_ff is
--  Port ( );
end tb_ff;

architecture Behavioral of tb_ff is
    signal s_clk    : std_logic;
    signal s_rst    : std_logic;
    signal s_d      : std_logic;
    signal s_j      : std_logic;
    signal s_k      : std_logic;
    signal s_t      : std_logic;
    signal s_d_ff_arst_q        : std_logic;
    signal s_d_ff_arst_q_bar    : std_logic;
    signal s_d_ff_rst_q         : std_logic;
    signal s_d_ff_rst_q_bar     : std_logic;
    signal s_jk_ff_rst_q        : std_logic;
    signal s_jk_ff_rst_q_bar    : std_logic;
    signal s_t_ff_rst_q         : std_logic;
    signal s_t_ff_rst_q_bar     : std_logic;
begin
    uut_d_ff_arst : entity work.d_ff_arst
    port map(
        clk     => s_clk,
        arst    => s_rst,
        d       => s_d,
        q       => s_d_ff_arst_q,
        q_bar   => s_d_ff_arst_q_bar
    );
    uut_d_ff_rst    : entity work.d_ff_rst
    port map(
        clk     => s_clk,
        rst     => s_rst,
        d       => s_d,
        q       => s_d_ff_rst_q,
        q_bar   => s_d_ff_rst_q_bar
    );
    uut_jk_ff_rst   : entity work.jk_ff_rst
    port map(
        clk     => s_clk,
        rst     => s_rst,
        j       => s_j,
        k       => s_k,
        q       => s_jk_ff_rst_q,
        q_bar   => s_jk_ff_rst_q_bar
    );
    uut_t_ff_rst    : entity work.t_ff_rst
    port map(
        clk     => s_clk,
        rst     => s_rst,
        t       => s_t,
        q       => s_t_ff_rst_q,
        q_bar   => s_t_ff_rst_q_bar
    );


    p_stimulus  : process
    begin
        s_clk <= '0';
        s_rst <= '0';
        s_d <= '0';
        s_j <= '0';
        s_k <= '0';
        s_t <= '0';
        
        wait for 50 ns;
        
        -- show d_ff_arst asynchronous reset
        s_rst <= '1';
        wait for 50 ns;
        
        -- reset remaining circuits
        s_clk <= '1';
        wait for 50 ns;
        -- reset cycle
        s_clk <= '0';
        s_rst <= '0';
        
        
        -- Start testing outputs at 200ns
        -- #1
        -- D flip flop reset
        s_d <= '0';
        -- JK flip flop keep
        s_j <= '0';
        s_k <= '0';
        -- T flip flop keep
        s_t <= '0';
        wait for 50 ns;
        s_clk <= '1';
        wait for 50 ns;
        s_clk <= '0';
        
        -- #2
        -- D flip flop set
        s_d <= '1';
        -- JK flip flop reset
        s_j <= '0';
        s_k <= '1';
        -- T flip flop toggle
        s_t <= '1';
        wait for 50 ns;
        s_clk <= '1';
        wait for 50 ns;
        s_clk <= '0';
        
        -- #3
        -- D flip flop set again
        s_d <= '1';
        -- JK flip flop keep
        s_j <= '1';
        s_k <= '0';
        -- T flip flop keep
        s_t <= '0';
        wait for 50 ns;
        s_clk <= '1';
        wait for 50 ns;
        s_clk <= '0';
        
        -- #4
        -- D flip flop reset
        s_d <= '0';
        -- JK flip flop invert
        s_j <= '1';
        s_k <= '1';
        -- T flip flop toggle
        s_t <= '1';
        wait for 50 ns;
        s_clk <= '1';
        wait for 50 ns;
        s_clk <= '0';
    
        -- #5
        -- D flip flop tested
        -- JK flip flop invert
        s_j <= '1';
        s_k <= '1';
        -- T flip flop keep 
        s_t <= '0';
        wait for 50 ns;
        s_clk <= '1';
        wait for 50 ns;
        s_clk <= '0';
        
        -- #6
        -- JK flip flop set
        s_j <= '1';
        s_k <= '0';
        -- T flip flop tested 
        wait for 50 ns;
        s_clk <= '1';
        wait for 50 ns;
        s_clk <= '0';
        
        -- #7
        -- JK flip flop keep
        s_j <= '0';
        s_k <= '0';
        wait for 50 ns;
        s_clk <= '1';
        wait for 50 ns;
        s_clk <= '0';
        
        -- #8
        -- JK flip flop reset
        s_j <= '0';
        s_k <= '1';
        wait for 50 ns;
        s_clk <= '1';
        wait for 50 ns;
        s_clk <= '0';
        
        wait;
    end process;
end Behavioral;
