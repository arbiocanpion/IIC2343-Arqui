----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.10.2015 16:56:33
-- Design Name: 
-- Module Name: RegSP - Behavioral
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

entity RegSP is
    Port ( IncSp : in STD_LOGIC;
           DecSP : in STD_LOGIC;
           SPout : out STD_LOGIC_VECTOR (11 downto 0));
end RegSP;

architecture Behavioral of RegSP is

signal dir : std_logic_vector(11 downto 0) := (others => '1');

begin

dir_prosses : process (clock)
        begin
          if (rising_edge(clock)) then
            if (IncSp = '1') then
                dir <= dir + 1;
            elsif (DecSP = '1') then
                dir <= dir - 1;            
            end if;
          end if;
        end process;
        
SPout <= dir;
        
end Behavioral;
