----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2021 20:40:13
-- Design Name: 
-- Module Name: tb_d_latch - Behavioral
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

entity tb_d_latch is
--  Port ( );
end tb_d_latch;

architecture Behavioral of tb_d_latch is
    signal enable       : std_logic;
    signal async_reset  : std_logic;
    signal d            : std_logic;
    signal q            : std_logic;
    signal q_bar        : std_logic;
begin
    uut_p_d_latch : entity work.d_latch
        port map(
            en => enable,
            arst => async_reset,
            d => d,
            q => q,
            q_bar => q_bar
        );
    p_clk_gen : process
    begin
        d <= '0';
        enable <= '0';
        async_reset <= '1';
        wait for 50 ns;
        async_reset <= '0';
        wait for 50 ns;
        d <= '1';
        wait for 50 ns;
        enable <= '1';
        d <= '0';    
        wait for 50 ns;
        d <= '1';
        wait;
    end process;
end Behavioral;
