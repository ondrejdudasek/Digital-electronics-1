----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.03.2021 22:10:03
-- Design Name: 
-- Module Name: mux_2bit_4to1_tb - Behavioral_tb
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

entity mux_2bit_4to1_tb is
end mux_2bit_4to1_tb;

architecture testbench of mux_2bit_4to1_tb is

signal sel : std_logic_vector(1 downto 0);
signal a,b,c,d,f : std_logic_vector(1 downto 0);
    
begin
uut_mux_2bit_4to1 : entity work.mux_2bit_4to1 port map(
    a_i => a,
    b_i => b,
    c_i => c,
    d_i => d,
    sel_i => sel,
    f_o => f);

stim : process
begin
sel <= "00"; 
a <= "11";
b <= "10";
c <= "01";
d <= "00";
wait for 200 ns;
sel <=  "01";
wait for 200 ns;
sel <= "10";
wait for 200 ns;
sel <= "11";
wait for 200 ns;

end process stim;
end architecture testbench;
