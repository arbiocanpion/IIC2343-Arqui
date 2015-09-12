----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/24/2015 05:50:08 PM
-- Design Name: 
-- Module Name: FA - Behavioral
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

entity FA is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           S : out STD_LOGIC);
end FA;

architecture Behavioral of FA is

    component HA
        Port (  A: in std_logic;
                B: in std_logic;
                C: out std_logic;
                S: out std_logic);
        end component;
        
        signal S1 : std_logic;
        signal C1 : std_logic;
        signal C2 : std_logic;
        
begin

inst_H1: HA port map(
    A => A,
    B => B,
    S => S1,
    C => C1);
inst_H2: HA port map(
    A => Cin,
    B => S1,
    S => S,
    C => C2);
    
-- Carry del full adder
Cout <= C1 or C2;

end Behavioral;
