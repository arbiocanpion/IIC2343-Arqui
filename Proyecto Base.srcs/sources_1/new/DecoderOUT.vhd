library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DecoderOUT is
    Port (
    	clock    	:	in 	std_logic;
        portAddress :	in STD_LOGIC_VECTOR (15 downto 0);
        loadOut 	:	in STD_LOGIC;
        loadLCD 	:	out STD_LOGIC;
        loadDis 	:	out STD_LOGIC;
        loadLED 	:	out STD_LOGIC
    );
end DecoderOUT;

architecture Behavioral of DecoderOUT is

begin

reg_prosses : process (clock)
        begin
          if (rising_edge(clock)) then
            if (loadOut = '1' and portAddress = "0000000000000000") then
                loadDis <= '1';
                loadLED <= '0';
                loadLCD <= '0';
            elsif (loadOut = '1' and portAddress = "0000000000000001") then
                loadDis <= '0';
                loadLED <= '1';
                loadLCD <= '0';
            elsif (loadOut = '1' and portAddress = "0000000000000010") then
                loadDis <= '0';
                loadLED <= '0';
                loadLCD <= '1';
            else
            	loadDis <= '0';
                loadLED <= '0';
                loadLCD <= '0';
            end if;
          end if;
        end process;
        
end Behavioral;