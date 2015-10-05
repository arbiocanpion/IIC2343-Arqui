----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.09.2015 19:33:18
-- Design Name: 
-- Module Name: RegS - Behavioral
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

entity RegS is
    Port ( 
    	Z 		: 	in std_logic;		-- zero: 		1 when result = "000..."
        N 		: 	in std_logic;		-- negative:	the most significative bit (indicates if result is negative)
        V 		: 	in std_logic;		-- overflow:	if ALU has overflow
        C 		: 	in std_logic;		-- carry:		carry out of ALU
        Stout	: 	out std_logic_vector (3 downto 0));
end RegS;

architecture Behavioral of RegS is

begin


end Behavioral;
