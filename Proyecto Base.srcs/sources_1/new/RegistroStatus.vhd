----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.10.2015 18:23:55
-- Design Name: 
-- Module Name: RegistroStatus - Behavioral
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

entity RegistroStatus is
    Port ( 
        clock   :  in  std_logic;
        Z       :   in  std_logic;
        N       :   in  std_logic;
        C       :   in  std_logic;
        Sout    :   out std_logic_vector (2 downto 0)
    );
end RegistroStatus;

architecture Behavioral of RegistroStatus is

begin

reg_prosses : process (clock)
        begin
          if (rising_edge(clock)) then
            Sout <= Z & N & C;
          end if;
        end process;
        
end Behavioral;
