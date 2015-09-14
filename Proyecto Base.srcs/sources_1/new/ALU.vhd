library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port ( a        : in  std_logic_vector (15 downto 0);
           b        : in  std_logic_vector (15 downto 0);
           sel      : in  std_logic_vector (2 downto 0);
           ci       : in  std_logic;
           co       : out std_logic;
           result   : out std_logic_vector (15 downto 0));
end ALU;

architecture Behavioral of ALU is

component Adder
    Port (
        A : std_logic_vector (15 downto 0);
        B : std_logic_vector (15 downto 0);
        Cin : in std_logic;
        Cout : out std_logic;
        S : out std_logic_vector (15 downto 0)
    );
    end component;

-- SENALES DE RESULTADO DE OPERACIONES
signal resultAdder : std_logic_vector (15 downto 0);
signal resultSubstracter : std_logic_vector (15 downto 0);
signal CoutAdder : std_logic;
signal CoutSubstracter : std_logic;
signal CoutShiftRight : std_logic;
signal CoutShiftLeft : std_logic;

begin

-- MUXS

with sel select result <=
    resultAdder when "000",
    resultSubstracter when "001",
    a and b when "010",
    a or b when "011",
    a xor b when "100",
    not(a) when "101",
    '0' & a(15 downto 1) when "110",
    a(14 downto 0) & '0' when "111",
    "0000000000000000" when others;

with sel select co <=
    CoutAdder when "000",
    CoutSubstracter when "001",
    CoutShiftRight when "110",
    CoutShiftLeft when "111",
    '0' when others;
    
with sel select CoutShiftRight <=
        a(0) when "110",
        '0' when others;

with sel select CoutShiftLeft <=
        a(15) when "111",
        '0' when others;

-- INSTANCIAS

inst_Adder: Adder port map(
        A => a,
        B => b,
        Cin => ci,
        Cout => CoutAdder,
        S => resultAdder
    );
    
inst_Substracter: Adder port map(
        A => a,
        B => not(b),
        Cin => ci,
        Cout => CoutSubstracter,
        S => resultSubstracter
    );
   
end Behavioral;
