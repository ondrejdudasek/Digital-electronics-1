----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.03.2021 14:09:00
-- Design Name: 
-- Module Name: tb_tlc - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_tlc is
    -- Entity of testbench is always empty
end entity tb_tlc;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_tlc is

    -- Local constants
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    --Local signals
    signal s_clk_100MHz : std_logic;
    signal s_reset      : std_logic;
    signal s_south      : std_logic_vector(3 - 1 downto 0);
    signal s_west       : std_logic_vector(3 - 1 downto 0);
    signal s_cars_to_west   : std_logic;
    signal s_cars_to_south  : std_logic;
    signal s_en     : std_logic;

begin
    -- Connecting testbench signals with tlc entity (Unit Under Test)
    --uut_tlc : entity work.tlc
    --    port map(
    --        clk     => s_clk_100MHz,
    --        reset   => s_reset,
    --        south_o => s_south,
    --        west_o  => s_west
    --    );
    uut_smart_traffic_fsm : entity work.smart_traffic_fsm
        port map(
            en      => s_en,
            clk     => s_clk_100MHz,
            reset   => s_reset,
            south_o => s_south,
            west_o  => s_west,
            cars_to_south   => s_cars_to_south,
            cars_to_west    => s_cars_to_west
        );

    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 30000 ns loop   -- 30 usec of simulation
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;

    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    p_reset_gen : process
    begin
        s_reset <= '0'; wait for 200 ns;
        -- Reset activated
        s_reset <= '1'; wait for 400 ns;
        -- Reset deactivated
        s_en <= '1';
        s_reset <= '0';
        wait;
    end process p_reset_gen;

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        s_cars_to_west <= '0';
        s_cars_to_south <= '0';
        --700 ns for reset
        --10+40+40+40+40 for one full cycle (approx)
        -- 
        wait for 1200 ns;
        s_cars_to_south <= '1';
        wait for 600 ns;
        -- stuck into loop for west_go
        s_cars_to_west <= '1';
        -- 40 ns for transition + 40 south_go + 40 ns transition
        -- + 40 ns for west_go + 20 half of transition
        wait for 1500 ns;
        s_cars_to_south <= '0';
        -- 20ns half of transition + 80 ns loop of south_go
        wait for 1000 ns;
        s_cars_to_west <= '0';
        wait;
    end process p_stimulus;

end architecture testbench;