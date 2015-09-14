library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity PC is
    Port ( clock    : in  std_logic;
           load     : in  std_logic;
           datain   : in  std_logic_vector (11 downto 0);
           dataout  : out std_logic_vector (11 downto 0));
end PC;

architecture Behavioral of PC is

signal pc : std_logic_vector(11 downto 0) := (others => '0');

begin

pc_prosses : process (clock)
    begin
      if (rising_edge(clock)) then
        if (load = '1') then
            pc <= datain;
        else
            pc <= pc + 1;
        end if;
      end if;
    end process;
    
dataout <= pc;

end Behavioral;
