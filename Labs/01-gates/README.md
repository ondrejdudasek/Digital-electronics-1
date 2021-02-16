# Labs 1: Gates
## Verification of De Morgan's law
### Code
```vhdl
library ieee;               -- Standard library
use ieee.std_logic_1164.all;-- Package for data types and logic operations

entity gates is
    port(
        a_i    : in  std_logic;         -- Data input
        b_i    : in  std_logic;         -- Data input
        c_i    : in  std_logic;
        f_o    : out std_logic;         -- OR output function
        fand_o : out std_logic;         -- AND output function
        for_o  : out std_logic          -- XOR output function
    );
end entity gates;

architecture dataflow of gates is
begin
    f_o  <= ((not b_i) and a_i ) or ((not b_i) and (not c_i));
    fand_o <= ((not b_i) nand a_i) nand ((not b_i) nand (not c_i));
    for_o <= not ((not (a_i or (not c_i))) or b_i);

end architecture dataflow;
```

### Logic functions
![Logic Functions](Images/formulas.gif)

### EDA Playground example
![EDA Playground Example](Images/gates.png)
[EDA Playground link](https://www.edaplayground.com/x/8Lvx)

### Function table
| **a** | **b** |**c** | **f(c,b,a)** |
| :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 1 |
| 0 | 0 | 1 | 0 |
| 0 | 1 | 0 | 0 |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 0 | 1 |
| 1 | 0 | 1 | 1 |
| 1 | 1 | 0 | 0 |
| 1 | 1 | 1 | 0 |

## Verification of distributive laws
### Code
```vhdl
-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;

--------------------------------
-- Digital electronics lab 01
--  Test distiributive laws
--   x AND y OR x AND z = x AND ( y OR z )
--   (x OR y) AND (x OR Z ) = x OR (y AND z)
--------------------------------

--- Gates declaration
entity gates is
	port(
    	x_i		: in	std_logic;
        y_i		: in	std_logic;
        z_i		: in	std_logic;
        -- x AND y OR x AND z
        f_a1	: out	std_logic;
        -- x AND (y OR z)
        f_a2	: out	std_logic;
        
        -- (x OR y) ADN (x OR z)
        f_b1	: out	std_logic;
        -- x OR (y AND z)
        f_b2	: out	std_logic
	);
end entity gates;

-- architecture for basic gates
architecture dataflow of gates is
begin
	f_a1 <= (x_i AND y_i) OR (x_i AND z_i);
    f_a2 <= x_i AND (y_i OR z_i);
    f_b1 <= (x_i OR y_i) AND (x_i OR z_i);
    f_b2 <= x_i OR (y_i AND z_i);
end architecture dataflow;
```
### Simulated time waveforms
![](Images/gates.png)


### [Public EDA Playground example](https://www.edaplayground.com/x/rt_J)
