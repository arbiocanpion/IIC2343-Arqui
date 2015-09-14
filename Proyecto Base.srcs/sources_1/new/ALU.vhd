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
    
component ShiftLeft is
        Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
               result : out STD_LOGIC_VECTOR (15 downto 0);
               Cout : out STD_LOGIC);
    end component;
    
component ShiftRight is
        Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
               result : out STD_LOGIC_VECTOR (15 downto 0);
               Cout : out STD_LOGIC);
    end component;

-- SENALES DE RESULTADO DE OPERACIONES
signal resultAdder : std_logic_vector (15 downto 0);
signal resultSubstracter : std_logic_vector (15 downto 0);
signal resultShiftRight : std_logic_vector (15 downto 0);
signal resultShiftLeft : std_logic_vector (15 downto 0);
signal CoutAdder : std_logic;
signal CoutSubstracter : std_logic;
signal CoutShiftRight : std_logic;
signal CoutShiftLeft : std_logic;

begin

-- MUXS

with sel select result <=
    resultAdder when "000",
    resultSubstracter when "001",
    A and B when "010",
    A or B when "100",
    A xor B when "011",
    not(A) when "101",
    resultShiftRight when "110",
    resultShiftLeft when "111",
    "0000000000000000" when others;

with sel select co <=
    CoutAdder when "000",
    CoutSubstracter when "001",
    CoutShiftRight when "110",
    CoutShiftLeft when "111",
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
        Cin => not(ci), -- ci es '0' por defecto
        Cout => CoutSubstracter,
        S => resultSubstracter
    );
    
inst_ShiftRight: ShiftRight port map(
        A => a,
        result => resultShiftRight,
        Cout => CoutShiftRight
    );
        
inst_ShiftLeft: ShiftLeft port map(
        A => a,
        result => resultShiftLeft,
        Cout => CoutShiftLeft
    );
   
end Behavioral;
