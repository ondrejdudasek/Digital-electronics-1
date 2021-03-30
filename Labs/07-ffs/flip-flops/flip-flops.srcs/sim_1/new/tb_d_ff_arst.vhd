----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2021 23:11:42
-- Design Name: 
-- Module Name: tb_d_ff_arst - Behavioral
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

entity tb_d_ff_arst is
--  Port ( );
end tb_d_ff_arst;

architecture Behavioral of tb_d_ff_arst is
    signal s_clk    : std_logic;
    signal s_rst    : std_logic;
    signal s_d      : std_logic;
    signal s_q      : std_logic;
    signal s_q_bar  : std_logic;
    
begin

    uut_d_ff_arst : entity work.d_ff_arst
    port map(
        clk     => s_clk,
        arst    => s_rst,
        d       => s_d,
        q       => s_q,
        q_bar   => s_q_bar
    );
    
    clock : process
    begin
        while now < 400ns 
            loop
                s_clk <= '0';
                wait for 10ns;
                s_clk <= '1';
                wait for 10ns;
            end loop;
        wait;
    end process;
    
    reset : process
    begin
        s_rst <= '0';
        wait for 5 ns;
        s_rst <= '1';
        wait for 10 ns;
        s_rst <= '0';
        wait;
    end process;
    
    stimulus : process
    begin
        s_d <= '0';
        wait for 15 ns;
        s_d <= '1';
        wait for 10 ns;
        s_d <= '1';
        wait for 10 ns;
        s_d <= '0';
        wait for 10 ns;
        wait;
    end process;

end Behavioral;
