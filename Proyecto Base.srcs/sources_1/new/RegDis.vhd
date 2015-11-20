library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity RedDis is
    Port (
    	clock    	:	in 	std_logic;
    	loadDis 	:	in 	STD_LOGIC;
        dataIN 		:	in 	STD_LOGIC_VECTOR (15 downto 0);
        dis_a       :   out std_logic_vector(3 downto 0);
        dis_b       :   out std_logic_vector(3 downto 0);
        dis_c       :   out std_logic_vector(3 downto 0);
        dis_d       :   out std_logic_vector(3 downto 0)
    );
end RedDis;

architecture Behavioral of RedDis is

signal reg : std_logic_vector(15 downto 0) := (others => '0');

begin

reg_prosses : process (clock)
        begin
          if (rising_edge(clock)) then
            if (loadDis = '1') then
                reg <= dataIN;       
            end if;
          end if;
        end process;
        
dis_a <= reg(3 downto 0);
dis_b <= reg(7 downto 4);
dis_c <= reg(11 downto 8);
dis_d <= reg(15 downto 12);
        
end Behavioral;
