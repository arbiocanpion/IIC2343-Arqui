----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/11/2015 11:44:44 PM
-- Design Name: 
-- Module Name: ShiftLeft - Behavioral
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

entity ShiftLeft is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           result : out STD_LOGIC_VECTOR (15 downto 0);
           Cout : out STD_LOGIC);
end ShiftLeft;

architecture Behavioral of ShiftLeft is

begin

result(0) <= '0';
result(1) <= A(0);
result(2) <= A(1);
result(3) <= A(2);
result(4) <= A(3);
result(5) <= A(4);
result(6) <= A(5);
result(7) <= A(6);
result(8) <= A(7);
result(9) <= A(8);
result(10) <= A(9);
result(11) <= A(10);
result(12) <= A(11);
result(13) <= A(12);
result(14) <= A(13);
result(15) <= A(14);
Cout <= A(15);

end Behavioral;
