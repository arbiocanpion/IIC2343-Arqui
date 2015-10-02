library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- TODO: Agregar salida para registro status, la información esta en el apunte 6 página 5-6
entity ALU is
    Port ( 
        a           :   in  std_logic_vector (15 downto 0);
        b           :   in  std_logic_vector (15 downto 0);
        sel         :   in  std_logic_vector (2 downto 0);
        ci          :   in  std_logic;
        co          :   out std_logic;
        result      :   out std_logic_vector (15 downto 0)
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
signal CoutSubs     :   std_logic;
signal CoutShiftR   :   std_logic;
signal CoutShiftL   :   std_logic;
signal bMuxed       :   std_logic_vector(15 downto 0);

begin

-- MUXS

with sel select result <=
    resultAdd               when "000",
    resultAdd               when "001",
    a and b                 when "010",
    a or b                  when "011",
    a xor b                 when "100",
    not(a)                  when "101",
    '0' & a(15 downto 1)    when "110",
    a(14 downto 0) & '0'    when "111",
    "0000000000000000"      when others;

with sel select co <=
    CoutAdd                 when "000",
    CoutSubs                when "001",
    CoutShiftR              when "110",
    CoutShiftL              when "111",
    '0'                     when others;
    
with sel select CoutShiftR <=
        a(0)    when "110",
        '0'     when others;

with sel select CoutShiftL <=
        a(15)   when "111",
        '0'     when others;

with ci select bMuxed <=
        b xor "0000000000000000" when '0',
        b xor "1111111111111111" when '1';

inst_Adder: Adder port map(
        A       =>  a,
        B       =>  bMuxed,
        Cin     =>  ci,
        Cout    =>  CoutAdd,
        S       =>  resultAdd
    );
   
end Behavioral;
