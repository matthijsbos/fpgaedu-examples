--taken from https://en.wikibooks.org/wiki/VHDL_for_FPGA_Design/4-Bit_ALU
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
entity ALU_VHDL is
   port
   (
      clock: in std_logic;
      reset: in std_logic;
      Nibble1 : in std_logic_vector(3 downto 0);
      Nibble2 : in std_logic_vector(3 downto 0);      
      Operation : in std_logic_vector(2 downto 0);
      
      Carry_Out : out std_logic;
      Flag : out std_logic;
      Result : out std_logic_vector(3 downto 0)
   );
end entity ALU_VHDL;
 
architecture Behavioral of ALU_VHDL is

   signal Temp: std_logic_vector(4 downto 0);

begin

   process(Nibble1, Nibble2, Operation, temp) is
   begin
      Flag <= '0';
      case Operation is
 	 when "000" => -- res = nib1 + nib2, flag = carry = overflow
 	    Temp   <= std_logic_vector((unsigned("0" & Nibble1) + unsigned(Nibble2)));
            Result <= temp(3 downto 0);
 	    Carry_Out   <= temp(4);
 	 when "001" => -- res = |nib1 - nib2|, flag = 1 iff nib2 > nib1
 	    if (Nibble1 >= Nibble2) then
 	       Result <= std_logic_vector(unsigned(Nibble1) - unsigned(Nibble2));
 	       Flag   <= '0';
            else
 	       Result <= std_logic_vector(unsigned(Nibble2) - unsigned(Nibble1));
 	       Flag   <= '1';
            end if;
 	 when "010" =>
 	    Result <= Nibble1 and Nibble2;
 	 when "011" =>
 	    Result <= Nibble1 or Nibble2;
 	 when "100" =>
 	    Result <= Nibble1 xor Nibble2;
 	 when "101" =>
 	    Result <= not Nibble1;
  	 when "110" =>
            Result <= not Nibble2;
 	 when others => -- res = nib1 + nib2 + 1, flag = 0
 	    Temp   <= std_logic_vector((unsigned("0" & Nibble1) + unsigned(not Nibble2)) + 1);
 	    Result <= temp(3 downto 0);
 	    Flag   <= temp(4);
      end case;
   end process;

end architecture Behavioral;
