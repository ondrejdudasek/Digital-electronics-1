----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.04.2021 17:01:59
-- Design Name: 
-- Module Name: smart_traffic_fsm - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity smart_traffic_fsm is
port(
        en      : in std_logic;
        clk     : in  std_logic;
        reset   : in  std_logic;
        cars_to_south   : in std_logic;
        cars_to_west    : in std_logic;
        -- Traffic lights (RGB LEDs) for two directions
        south_o : out std_logic_vector(3 - 1 downto 0);
        west_o  : out std_logic_vector(3 - 1 downto 0)
);
end smart_traffic_fsm;

architecture Behavioral of smart_traffic_fsm is
    -- Define the states
    type   t_state is ( SOUTH_GO, SOUTH_WAIT_TW, STOP_TW,
                        WEST_WAIT_TW, WEST_GO, WEST_WAIT_TS,
                       STOP_TS, SOUTH_WAIT_TS);
    -- Define the signal that uses different states
    signal s_state  : t_state;

    -- Internal clock enable
    signal s_en     : std_logic;
    -- Local delay counter
    signal   s_cnt  : unsigned(5 - 1 downto 0);

    -- Specific values for local counter
    constant c_DELAY_4SEC : unsigned(5 - 1 downto 0) := b"1_0000";
    constant c_DELAY_2SEC : unsigned(5 - 1 downto 0) := b"0_1000";
    constant c_DELAY_1SEC : unsigned(5 - 1 downto 0) := b"0_0100";
    constant c_ZERO       : unsigned(5 - 1 downto 0) := b"0_0000";

begin

    p_smart_traffic_fsm : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then       -- Synchronous reset
                s_state <= STOP_TS ;      -- Set initial state
                s_cnt   <= c_ZERO;      -- Clear all bits

            elsif (s_en = '1') then
                case s_state is

                    when SOUTH_GO =>
                        if (s_cnt < c_DELAY_4SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            if (cars_to_south = '1') and (cars_to_west = '0') then
                                s_state <= SOUTH_GO;
                                s_cnt <= c_DELAY_4SEC - c_DELAY_1SEC;
                                -- This will cause 1s checks both values changed.
                                -- In case of real crossroad, intervals are much longer.
                                -- Setting smaller countdown time between checks
                                -- after long time in one state the reaction to 
                                -- change would be faster.
                            else
                                s_state <= SOUTH_WAIT_TW;
                                s_cnt   <= c_ZERO;
                            end if;
                        end if;

                    when SOUTH_WAIT_TW =>
                        if (s_cnt < c_DELAY_1SEC ) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= STOP_TW;
                            s_cnt <= c_ZERO;
                        end if;

                    when STOP_TW =>
                        if (s_cnt < c_DELAY_2SEC ) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= WEST_WAIT_TW;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when WEST_WAIT_TW =>
                        if (s_cnt < c_DELAY_1SEC ) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= WEST_GO;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when WEST_GO =>
                        if (s_cnt <  c_DELAY_4SEC ) then
                            s_cnt <= s_cnt + 1;
                        else
                            if (cars_to_south = '0') and (cars_to_west = '1') then
                                s_state <= WEST_GO;
                                s_cnt <= c_DELAY_4SEC - c_DELAY_1SEC;
                            else
                                s_state <= WEST_WAIT_TS;
                                s_cnt <= c_ZERO;
                            end if;
                        end if;
                        
                    when WEST_WAIT_TS =>
                        if (s_cnt < c_DELAY_1SEC ) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= STOP_TS;
                            s_cnt <= c_ZERO;
                        end if;

                    when STOP_TS =>
                        if (s_cnt < c_DELAY_2SEC ) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SOUTH_WAIT_TS;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when SOUTH_WAIT_TS =>
                        if (s_cnt < c_DELAY_1SEC ) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SOUTH_GO;
                            s_cnt <= c_ZERO;
                        end if;
                        

                    when others =>
                        s_state <= STOP_TS;

                end case;
            end if; -- Synchronous reset
        end if; -- Rising edge
    end process p_smart_traffic_fsm;
    
    p_output_fsm : process(s_state)
    begin
        south_o(0)  <= '0';
        west_o(0)   <= '0';
        case s_state is
            when STOP_TS =>
                south_o(2) <= '1';   -- Red (RGB = 100)
                south_o(1) <= '0';
                west_o(2) <= '1';   -- Red (RGB = 100)
                west_o(1) <= '0';
                
            when STOP_TW =>
                south_o(2) <= '1';   -- Red (RGB = 100)
                south_o(1) <= '0';
                west_o(2) <= '1';   -- Red (RGB = 100)
                west_o(1) <= '0';
                
            when WEST_GO =>
                south_o <= "100";
                west_o(2) <= '0';   -- Green (RGB = 010)
                west_o(1) <= '1';
                
            when SOUTH_GO =>                          
                south_o(2) <= '0';  -- Green (RGB = 01
                south_o(1) <= '1';
                west_o(2) <= '1';   -- Red (RGB = 100)
                west_o(1) <= '0';
                                
            when WEST_WAIT_TS =>
                south_o(2) <= '1';   -- Red (RGB = 100)
                south_o(1) <= '0';
                west_o(2) <= '1';   -- Yellow (RGB = 110)
                west_o(1) <= '1';
                
            when WEST_WAIT_TW =>
                south_o(2) <= '1';   -- Red (RGB = 100)
                south_o(1) <= '0';
                west_o(2) <= '1';   -- Yellow (RGB = 110)
                west_o(1) <= '1';
                
            when SOUTH_WAIT_TS =>
                south_o(2) <= '1';   -- Yellow (RGB = 110)
                south_o(1) <= '1';
                west_o(2) <= '1';   -- Red (RGB = 100)
                west_o(1) <= '0';
                
            when SOUTH_WAIT_TW =>
                south_o <= "110";   -- Yellow (RGB = 110)
                west_o(2) <= '1';   -- Red (RGB = 100)
                west_o(1) <= '0';
                
            when others =>
                south_o(2) <= '1';   -- Red (RGB = 100)
                south_o(1) <= '0';
                west_o(2) <= '1';   -- Red (RGB = 100)
                west_o(1) <= '0';
        end case;
    end process p_output_fsm;
    s_en <= en;
end Behavioral;
