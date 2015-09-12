----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/11/2015 11:44:44 PM
-- Design Name: 
-- Module Name: ShiftRight - Behavioral
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

entity ShiftRight is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           result : out STD_LOGIC_VECTOR (15 downto 0);
           Cout : out STD_LOGIC);
end ShiftRight;

architecture Behavioral of ShiftRight is

begin

Cout <= A(0);
result(0) <= A(1);
result(1) <= A(2);
result(2) <= A(3);
result(3) <= A(4);
result(4) <= A(5);
result(5) <= A(6);
result(6) <= A(7);
result(7) <= A(8);
result(8) <= A(9);
result(9) <= A(10);
result(10) <= A(11);
result(11) <= A(12);
result(12) <= A(13);
result(13) <= A(14);
result(14) <= A(15);
result(15) <= '0';

end Behavioral;
