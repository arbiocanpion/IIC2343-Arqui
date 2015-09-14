library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Basys3 is
    Port (
        sw          : in   std_logic_vector (2 downto 0);
        btn         : in   std_logic_vector (4 downto 0);  -- 0 Center, 1 Up, 2 Left, 3 Right, 4 Down
        led         : out  std_logic_vector (2 downto 0);
        clk         : in   std_logic;
        clk_up      : in   std_logic;
        seg         : out  std_logic_vector (7 downto 0);
        an          : out  std_logic_vector (3 downto 0)
          );
end Basys3;

architecture Behavioral of Basys3 is

component Clock_Divider
    Port ( clk          : in std_logic;
           clk_up       : in std_logic;
           slow         : in std_logic;
           clock        : out std_logic);
    end component;
    
component Led_Driver
    Port (  dis_a       : in   std_logic_vector (3 downto 0);
            dis_b       : in   std_logic_vector (3 downto 0);
            dis_c       : in   std_logic_vector (3 downto 0);
            dis_d       : in   std_logic_vector (3 downto 0);
            clk         : in   std_logic;
            seg         : out  std_logic_vector (7 downto 0);
            an          : out  std_logic_vector (3 downto 0)
           );
    end component;
    
component Reg
    Port (  clock   :   in std_logic;
            load    :   in std_logic;
            up      :   in std_logic;
            down    :   in std_logic;
            datain  :   in std_logic_vector (15 downto 0);
            dataout :   out std_logic_vector (15 downto 0)
            );
    end component;
    
component ALU
    Port ( a        : in  std_logic_vector (15 downto 0);
           b        : in  std_logic_vector (15 downto 0);
           sel      : in  std_logic_vector (2 downto 0);
           ci       : in  std_logic;
           co       : out std_logic;
           result   : out std_logic_vector (15 downto 0));
    end component;  

-- SENAL CLOCK
signal clock   : std_logic;                     
            
-- SENALES DISPLAY
signal dis_a : std_logic_vector(3 downto 0);
signal dis_b : std_logic_vector(3 downto 0);
signal dis_c : std_logic_vector(3 downto 0);
signal dis_d : std_logic_vector(3 downto 0);

-- SENALES BOTONES
signal upA : std_logic;
signal upB : std_logic;
signal downA : std_logic;
signal downB : std_logic;

-- SENALES VALORES A y B
signal valueA : std_logic_vector(15 downto 0);
signal valueB : std_logic_vector(15 downto 0);

-- SENAL OVERFLOW
signal Cout : std_logic;

-- SENAL RESULTADO OPERACION ALU
signal Salu : std_logic_vector (15 downto 0);

-- SENAL CARRY IN
signal ci : std_logic;

begin

-- CARRY IN
with sw select ci <=
    '1' when "001",
    '0' when others;

-- AUMENTAR VALOR DE A y B
upA <= btn(1) and btn(2);   --A izquierdo
upB <= btn(1) and btn(3);   --B derecho

-- REDUCIR VALOR DE A y B
downA <= btn(4) and btn(2); --A izquierdo
downB <= btn(4) and btn(3); --B derecho

-- MOSTRAR OPERACION DE A y B
with btn(0) select
    dis_d <= Salu(3 downto 0) when '1',
    valueB (3 downto 0) when others;
    
with btn(0) select
    dis_c <= Salu(7 downto 4) when '1',
    valueB (7 downto 4) when others;
        
with btn(0) select
    dis_b <= Salu(11 downto 8) when '1',
    valueA (3 downto 0) when others;
            
with btn(0) select
    dis_a <= Salu(15 downto 12) when '1',
    valueA (7 downto 4) when others;

inst_Clock_Divider: Clock_Divider port map(
        clk         =>clk,
        clk_up      =>clk_up,
        slow        =>'1',
        clock       =>clock
    );

inst_Led_Driver: Led_Driver port map(
		dis_a => dis_a,
		dis_b => dis_b,
        dis_c => dis_c,
		dis_d => dis_d,
        clk => clk,
        seg => seg,
        an => an
	);
	
inst_RegA: Reg port map(
        clock => clock,
        load => '0',
        up => upA,
        down => downA,
        datain => "0000000000000000",
        dataout => valueA
    );
    
inst_RegB: Reg port map(
        clock => clock,
        load => '0',
        up => upB,
        down => downB,
        datain => "0000000000000000",
        dataout => valueB
    );
    
inst_ALU: ALU port map(
        A => valueA,
        B => valueB,
        sel => sw,
        ci => ci,
        co => Cout,
        result => Salu
    );

end Behavioral;
