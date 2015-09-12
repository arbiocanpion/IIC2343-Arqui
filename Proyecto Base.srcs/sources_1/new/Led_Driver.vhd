library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity Led_Driver is
    Port (
        dis_a       : in   std_logic_vector (3 downto 0);
        dis_b       : in   std_logic_vector (3 downto 0);
        dis_c       : in   std_logic_vector (3 downto 0);
        dis_d       : in   std_logic_vector (3 downto 0);
        clk         : in   std_logic;
        seg         : out  std_logic_vector (7 downto 0);
        an          : out  std_logic_vector (3 downto 0)
          );
end Led_Driver;

architecture Behavioral of Led_Driver is    

constant clock_divide_max : std_logic_vector(17 downto 0) := "011110000100000000";
constant segment_var_max : std_logic_vector(1 downto 0) := "11";

signal clock_divide_counter: std_logic_vector(26 downto 0) := (others => '0');
signal segment_var : std_logic_vector(3 downto 0) := (others => '0');

signal slected_dis : std_logic_vector(3 downto 0) := (others => '0');

begin

clock_divide : process (clk)
    begin
        if (rising_edge(clk)) then
            if (clock_divide_counter = clock_divide_max) then
                clock_divide_counter <= (others => '0');
            else
                clock_divide_counter <= clock_divide_counter + 1;
            end if;
        end if;
    end process;

segment_swapper : process (clk)
    begin
       if (rising_edge(clk)) then
            if (clock_divide_counter = clock_divide_max) then
                if (segment_var = segment_var_max) then
                    segment_var <= (others => '0');
                else
                    segment_var <= segment_var + 1;
                end if;
           end if;
       end if;
    end process;

with segment_var select
    an <= "0111" when "00",
          "1011" when "01",
          "1101" when "10",
          "1110" when "11";
          
with segment_var select
slected_dis <= dis_a when "00",
                dis_b when "01",
                dis_c when "10",
                dis_d when "11";
   
with slected_dis select
    seg <= "11000000" when "0000",
            "11111001" when "0001",
            "10100100" when "0010",
            "10110000" when "0011",
            "10011001" when "0100",
            "10010010" when "0101",
            "10000010" when "0110",
            "11111000" when "0111",
            "10000000" when "1000",
            "10010000" when "1001",
            "10001000" when "1010",
            "10000011" when "1011",
            "11000110" when "1100",
            "10100001" when "1101",
            "10000110" when "1110",
            "10001110" when "1111";
            
end Behavioral;
