library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity RegLed is
    Port (
    	clock    	:	in 	std_logic;
    	loadLED 	:	in 	STD_LOGIC;
        dataIN 		:	in 	STD_LOGIC_VECTOR (15 downto 0);
        led         :   out  std_logic_vector (15 downto 0)
    );
end RegLed;

architecture Behavioral of RegLed is

signal reg : std_logic_vector(15 downto 0) := (others => '0');

begin

reg_prosses : process (clock)
        begin
          if (rising_edge(clock)) then
            if (loadLED = '1') then
                reg <= dataIN;       
            end if;
          end if;
        end process;
        
led <= reg;
        
end Behavioral;
