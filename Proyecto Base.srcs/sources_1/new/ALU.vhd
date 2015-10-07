library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- TODO: Agregar salida para registro status, la información esta en el apunte 6 página 5-6
entity ALU is
    Port ( 
        a           :   in  std_logic_vector (15 downto 0);
        b           :   in  std_logic_vector (15 downto 0);
        sel         :   in  std_logic_vector (2 downto 0);
        result      :   out std_logic_vector (15 downto 0);
        z           :   out std_logic;
        n           :   out std_logic;
        c           :   out std_logic
    );
end ALU;

architecture Behavioral of ALU is

component Adder
    Port (
        A           :   in  std_logic_vector (15 downto 0);
        B           :   in  std_logic_vector (15 downto 0);
        Cin         :   in  std_logic;
        Cout        :   out std_logic;
        S           :   out std_logic_vector (15 downto 0)
    );
    end component;

-- SENALES DE RESULTADO DE OPERACIONES
signal resultAdd    :   std_logic_vector (15 downto 0);
signal resultSubs   :   std_logic_vector (15 downto 0);
signal CoutAdd      :   std_logic;
signal CoutShiftR   :   std_logic;
signal CoutShiftL   :   std_logic;
signal bMuxed       :   std_logic_vector(15 downto 0);
signal resultALU    :   std_logic_vector(15 downto 0);

begin

-- MUXS

result <= resultALU;

with sel select resultALU <=
    resultAdd               when "000",
    resultAdd               when "001",
    a and b                 when "010",
    a or b                  when "011",
    a xor b                 when "100",
    not(a)                  when "101",
    '0' & a(15 downto 1)    when "110",
    a(14 downto 0) & '0'    when "111",
    "0000000000000000"      when others;
    
with sel select CoutShiftR <=
    a(0)                when "110",
    '0'                 when others;

with sel select CoutShiftL <=
    a(15)               when "111",
    '0'                 when others;

with sel(0) select bMuxed <=
    b                   when '0',
    not(b)              when '1';

with resultALU select z <=
    '1'                 when "0000000000000000",
    '0'                 when others;

with resultALU(15) select n <=
    '1'                 when '1',
    '0'                 when others;

with sel select c <=
    CoutAdd             when "000",
    CoutShiftR          when "110",
    CoutShiftL          when "111",
    '0'                 when others;

inst_Adder: Adder port map(
    A       =>  a,
    B       =>  bMuxed,
    Cin     =>  sel(0),
    Cout    =>  CoutAdd,
    S       =>  resultAdd
    );
   
end Behavioral;
