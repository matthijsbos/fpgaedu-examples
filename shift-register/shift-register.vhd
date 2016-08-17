--implementation taken from https://startingelectronics.org/software/VHDL-CPLD-course/tut11-shift-register/
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity shift_register_top is
    Port ( clock : in  STD_LOGIC;
           reset: in STD_LOGIC;
           D   : in  STD_LOGIC;
           LED : out STD_LOGIC_VECTOR(7 downto 0));
end shift_register_top;
    
architecture Behavioral of shift_register_top is
    signal shift_reg : STD_LOGIC_VECTOR(7 downto 0) := X"00";
begin  
    -- shift register
    process (clock)
    begin
        if (clock'event and clock = '1') then
            shift_reg(7) <= D;
            shift_reg(6) <= shift_reg(7);
            shift_reg(5) <= shift_reg(6);
            shift_reg(4) <= shift_reg(5);
            shift_reg(3) <= shift_reg(4);
            shift_reg(2) <= shift_reg(3);
            shift_reg(1) <= shift_reg(2);
            shift_reg(0) <= shift_reg(1);
        end if;
    end process;
    
    -- hook up the shift register bits to the LEDs
    LED <= shift_reg;

end Behavioral;
