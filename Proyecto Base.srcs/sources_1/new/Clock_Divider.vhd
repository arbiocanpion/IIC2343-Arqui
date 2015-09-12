library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity Clock_Divider is
    Port ( clk                  : in std_logic;
           clk_up               : in std_logic;
           slow                 : in std_logic;
           clock                : out std_logic);
end Clock_Divider;

architecture Behavioral of Clock_Divider is

    constant normal_max         : std_logic_vector(26 downto 0) := "100000000000000000000000000";
    constant fast_max           : std_logic_vector(26 downto 0) := "001000000000000000000000000";
    constant faster_max         : std_logic_vector(26 downto 0) := "000010000000000000000000000";
    
    signal clock_divide_max     : std_logic_vector(26 downto 0) := normal_max;
    signal clock_divide_counter : std_logic_vector(26 downto 0) := (others => '0');
    signal internal_clock       : std_logic;
    signal max_sel              : std_logic_vector(1 downto 0);
    
begin

max_sel <= slow & clk_up;

with max_sel select
    clock_divide_max <= normal_max when "11",
                        fast_max when "01",
                        faster_max when others;
                        
clock_divide : process (clk)
    begin
        if (rising_edge(clk)) then
            if (clock_divide_counter >= clock_divide_max) then
                clock_divide_counter <= (others => '0');
                internal_clock <= internal_clock xor '1';
            else
                clock_divide_counter <= clock_divide_counter + 1;
            end if;
        end if;
    end process;
    
clock <= internal_clock;

end Behavioral;
