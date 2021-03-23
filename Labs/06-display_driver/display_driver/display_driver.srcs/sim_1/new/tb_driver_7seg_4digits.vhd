------------------------------------------------------------------------
--
-- Template for 4-digit 7-segment display driver testbench.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2020-Present Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_driver_7seg_4digits is
    -- Entity of testbench is always empty
end entity tb_driver_7seg_4digits;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_driver_7seg_4digits is

    -- Local constants
    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;

    --Local signals
    signal s_clk_100MHz : std_logic;
    
    signal s_reset  : std_logic;
    signal s_data0  : std_logic_vector ( 4 - 1 downto 0 );
    signal s_data1  : std_logic_vector ( 4 - 1 downto 0 );
    signal s_data2  : std_logic_vector ( 4 - 1 downto 0 );
    signal s_data3  : std_logic_vector ( 4 - 1 downto 0 );
    signal s_dp_i   : std_logic_vector ( 4 - 1 downto 0 );
    signal s_dp_o   : std_logic;
    signal s_dig_o  : std_logic_vector( 4 - 1 downto 0 );
    signal s_seg_o  : std_logic_vector( 7 - 1 downto 0 );

begin
    -- Connecting testbench signals with driver_7seg_4digits entity
    -- (Unit Under Test)
    --- WRITE YOUR CODE HERE
    uut_driver_7seg_4digits : entity work.driver_7seg_4digits
        port map(
            clk => s_clk_100MHz,
            reset => s_reset,
            data0_i => s_data0,
            data1_i => s_data1,
            data2_i => s_data2,
            data3_i => s_data3,
            dp_i => s_dp_i,
            dp_o => s_dp_o,
            seg_o => s_seg_o,
            dig_o => s_dig_o
        );

    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        -- Perform all values reset to zero all values.
        -- Otherwise the simulation doesn't work as it should
        s_clk_100MHz <= '0';
        s_reset <= '1';
        s_data0 <= "0011";
        s_data1 <= "0001";
        s_data2 <= "0101";
        s_data3 <= "0010";
        s_dp_i <= "0001";
        wait for c_CLK_100MHZ_PERIOD / 2;
        s_clk_100MHz <= '1';
        wait for c_CLK_100MHZ_PERIOD / 2;
        s_clk_100MHz <= '0';
         wait for c_CLK_100MHZ_PERIOD / 2;
        s_clk_100MHz <= '1';
        wait for c_CLK_100MHZ_PERIOD / 2;
        s_clk_100MHz <= '0';
        s_reset <= '0';
        -- Reset done
        -- Perform all values reset to zero all values.
        -- Otherwise the simulation doesn't work as it should
        
        
        while now < 750 ns loop         -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        
        -- Reset generation process
        s_reset <= '1';
        wait for c_CLK_100MHZ_PERIOD;
        s_reset <= '0';
        wait for c_CLK_100MHZ_PERIOD;
        
        -- Data generation process
        
        wait;
    end process p_clk_gen;
    
    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    --- WRITE YOUR CODE HERE

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    --- WRITE YOUR CODE HERE

end architecture testbench;
