----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2021 21:03:07
-- Design Name: 
-- Module Name: jk_ff_rst - Behavioral
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

entity jk_ff_rst is
    Port ( 
           clk      : in STD_LOGIC;
           rst      : in STD_LOGIC;
           j        : in STD_LOGIC;
           k        : in STD_LOGIC;
           q        : out STD_LOGIC;
           q_bar    : out STD_LOGIC
    );
end jk_ff_rst;

architecture Behavioral of jk_ff_rst is
    signal s_q  : std_logic;
begin
    p_jk_ff_rst : process(clk, rst, j, k, s_q)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                s_q <= '0';
            end if;
            
            if ( j = '0' ) then
                if ( k = '1' ) then -- reset
                    s_q <= '0';
                end if; -- if j and k = 0, there is no change
            else -- j = 1
                if ( k = '0' ) then -- set
                    s_q <= '1';
                else    -- invert
                    s_q <= not s_q;
                end if;
            end if;
            
            if (rst = '1') then
                s_q <= '0';
            end if;
            
            
        end if;
    end process;
    q <= s_q;
    q_bar <= not s_q;
end Behavioral;
