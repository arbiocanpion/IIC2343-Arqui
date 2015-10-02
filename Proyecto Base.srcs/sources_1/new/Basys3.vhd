library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Basys3 is
    Port (
        sw      :   in  std_logic_vector (2 downto 0);
        btn     :   in  std_logic_vector (4 downto 0);  -- 0 Center, 1 Up, 2 Left, 3 Right, 4 Down
        led     :   out std_logic_vector (2 downto 0);
        clk     :   in  std_logic;
        clk_up  :   in  std_logic;
        seg     :   out std_logic_vector (7 downto 0);
        an      :   out std_logic_vector (3 downto 0)
    );
end Basys3;

architecture Behavioral of Basys3 is

component RegistroStatus is
    Port ( 
        clock   :  in  std_logic;
        Z       :   in  std_logic;
        N       :   in  std_logic;
        C       :   in  std_logic;
        Sout    :   out std_logic_vector (2 downto 0)
    );
    end component;

component ControlUnit is
    Port (
        Opcode  :   in std_logic_vector(6 downto 0);    -- instruction to execute
        Z       :   in std_logic;                       -- zero
        N       :   in std_logic;                       -- negative
        C       :   in std_logic;                       -- carry
        LPC     :   out std_logic;                      -- load pc
        LA      :   out std_logic;                      -- load A
        LB      :   out std_logic;                      -- load B
        SA      :   out std_logic_vector(1 downto 0);   -- mux A
        SB      :   out std_logic_vector(1 downto 0);   -- mux B
        SL      :   out std_logic_vector(2 downto 0);    -- ALU
        SAdd    :   out std_logic_vector(1 downto 0);   -- mux address
        SDin    :   out std_logic;                      -- mux datain RAM
        SPC     :   out std_logic;                      -- mux PC
        W       :   out std_logic;                      -- write RAM
        IncSp   :   out std_logic;                      -- increment stack pointer
        DecSp   :   out std_logic                       -- decrement stack pointer
    );
    end component;

component RAM
    Port ( 
        clock   :   in  std_logic;
        write   :   in  std_logic;
        address :   in  std_logic_vector (11 downto 0);
        datain  :   in  std_logic_vector (15 downto 0);
        dataout :   out std_logic_vector (15 downto 0)
    );
    end component;

component ROM
    Port ( 
        address :   in  std_logic_vector(11 downto 0);
        dataout :   out std_logic_vector(32 downto 0)
    );
    end component;

component PC 
    Port ( 
        clock   :   in  std_logic;
        load    :   in  std_logic;
        datain  :   in  std_logic_vector (11 downto 0);
        dataout :   out std_logic_vector (11 downto 0)
    );
    end component;

component Clock_Divider
    Port ( 
        clk     :   in  std_logic;
        clk_up  :   in  std_logic;
        slow    :   in  std_logic;
        clock   :   out std_logic
    );
    end component;
    
component Led_Driver
    Port (  
        dis_a   :   in  std_logic_vector (3 downto 0);
        dis_b   :   in  std_logic_vector (3 downto 0);
        dis_c   :   in  std_logic_vector (3 downto 0);
        dis_d   :   in  std_logic_vector (3 downto 0);
        clk     :   in  std_logic;
        seg     :   out std_logic_vector (7 downto 0);
        an      :   out std_logic_vector (3 downto 0)
    );
    end component;
    
component Reg
    Port (  
        clock   :   in  std_logic;
        load    :   in  std_logic;
        up      :   in  std_logic;
        down    :   in  std_logic;
        datain  :   in  std_logic_vector (15 downto 0);
        dataout :   out std_logic_vector (15 downto 0)
    );
    end component;
    
component ALU
    Port ( 
        a       :   in  std_logic_vector (15 downto 0);
        b       :   in  std_logic_vector (15 downto 0);
        sel     :   in  std_logic_vector (2 downto 0);
        result  :   out std_logic_vector (15 downto 0);
        z       :   out std_logic;
        n       :   out std_logic;
        c       :   out std_logic
    );
    end component;  

-- SENAL CLOCK
signal clock    :   std_logic;   

--SENAL instrucciones rom
signal romout   :   std_logic_vector(32 downto 0);

--SENAL Conteo PC
signal PCount   :   std_logic_vector(11 downto 0);
signal PC1      :   std_logic_vector(11 downto 0);

--SENAl RAM 
signal ramout   :   std_logic_vector(15 downto 0);
signal ramin    :   std_logic_vector(15 downto 0);

-- SEÑALES Control Unit 
signal LPC      :   std_logic;                     -- load pc
signal LA       :   std_logic;                     -- load A
signal LB       :   std_logic;                     -- load B
signal SA       :   std_logic_vector(1 downto 0);  -- mux A
signal SB       :   std_logic_vector(1 downto 0);  -- mux B
signal SL       :   std_logic_vector(2 downto 0);   -- ALU
signal SAdd     :   std_logic_vector(1 downto 0);  -- mux address
signal SDin     :   std_logic;                     -- mux datain RAM
signal SPC      :   std_logic;                     -- mux PC
signal W        :   std_logic;                     -- write RAM
signal IncSp    :   std_logic;                     -- increment stack pointer
signal DecSp    :   std_logic;                     -- decrement stack pointer
            
-- SENALES DISPLAY
signal dis_a    :   std_logic_vector(3 downto 0);
signal dis_b    :   std_logic_vector(3 downto 0);
signal dis_c    :   std_logic_vector(3 downto 0);
signal dis_d    :   std_logic_vector(3 downto 0);

-- SENALES BOTONES
signal upA      :   std_logic;
signal upB      :   std_logic;
signal downA    :   std_logic;
signal downB    :   std_logic;

-- SENALES VALORES A, B y C
signal valueA   :   std_logic_vector(15 downto 0);
signal valueB   :   std_logic_vector(15 downto 0);

-- SENAL CARRY OUT ALU
signal Cout     :   std_logic;  -- TODO: Eliminar, va a ser conexión de ALU con Registro Status

-- SENAL RESULTADO OPERACION ALU
signal Salu     :   std_logic_vector (15 downto 0);

-- SENAL STATUS
signal Z        :   std_logic;
signal N        :   std_logic;
signal C        :   std_logic;
signal Sout     :   std_logic_vector (2 downto 0);

-- SENALES MUX A, MUX B    -(Pongan las otras salidas de MUX aquí)
signal MuxAout  :   std_logic_vector(15 downto 0);
signal MuxBout  :   std_logic_vector(15 downto 0);

begin

-- Mux A
with SA select MuxAout <=
    valueA                  when "00",
    "0000000000000000"      when "01",
    "0000000000000001"      when "10",
    valueA                  when others;

-- Mux B
with SB select MuxBout <=
    valueB                  when "00",
    "0000000000000000"      when "01",
    romout(32 downto 17)    when "10",
    ramout                  when "11";

-- MUX DATAIN DE LA RAM
with SDin select ramin <=
    "0000" & PC1    when '1',  -- cuando el selector del mux es 1 se guarda el contador +1
    Salu            when others;       -- sino se guarda el resultado de la ALU

-- AUMENTAR VALOR DE A y B
upA <= btn(1) and btn(2);   -- A izquierdo
upB <= btn(1) and btn(3);   -- B derecho

-- REDUCIR VALOR DE A y B
downA <= btn(4) and btn(2); -- A izquierdo
downB <= btn(4) and btn(3); -- B derecho

-- MOSTRAR RESULTADO OPERACION DE A y B
with btn(0) select
    dis_d <= Salu(3 downto 0)   when '1',
    valueB (3 downto 0)         when others;
    
with btn(0) select
    dis_c <= Salu(7 downto 4)   when '1',
    valueB (7 downto 4)         when others;
        
with btn(0) select
    dis_b <= Salu(11 downto 8)  when '1',
    valueA (3 downto 0)         when others;
            
with btn(0) select
    dis_a <= Salu(15 downto 12) when '1',
    valueA (7 downto 4)         when others;

inst_Clock_Divider: Clock_Divider port map(
    clk     =>  clk,
    clk_up  =>  clk_up,
    slow    =>  '1',
    clock   =>  clock
    );

inst_Led_Driver: Led_Driver port map(
	dis_a   =>  dis_a,
	dis_b   =>  dis_b,
    dis_c   =>  dis_c,
	dis_d   =>  dis_d,
    clk     =>  clk,
    seg     =>  seg,
    an      =>  an
	);
	
inst_RegA: Reg port map(
    clock   =>  clock,
    load    =>  LA,
    up      =>  upA,
    down    =>  downA,
    datain  =>  Salu,
    dataout =>  valueA
    );
    
inst_RegB: Reg port map(
    clock   =>  clock,
    load    =>  LB,
    up      =>  upB,
    down    =>  downB,
    datain  =>  Salu,
    dataout =>  valueB
    );   

inst_ALU: ALU port map(
    A       =>  MuxAout,
    B       =>  MuxBout,
    sel     =>  SL,
    result  =>  Salu,
    z       =>  Z,
    n       =>  N,
    c       =>  C
    );
    
inst_PC: PC port map(
    clock   =>  clock,
    load    =>  LPC,
    datain  =>  romout(28 downto 17), -- en realidad esto tiene que pasar antes por un mux
    dataout =>  PCount
    );
    
inst_ROM: ROM port map(
    address =>  PCount,
    dataout =>  romout
    );
    
inst_RAM: RAM port map(
    clock   =>  clock,
    write   =>  W,
    address =>  "000000000000",     -- Hacer conexion
    datain  =>  Salu,
    dataout =>  ramout
    );

inst_ControlUnit: ControlUnit port map(
    Opcode  =>  ramout(6 downto 0),
    Z       =>  Sout(2),
    N       =>  Sout(1),
    C       =>  Sout(0),
    LPC     =>  LPC,
    LA      =>  LA,
    LB      =>  LB,
    SA      =>  SA,
    SB      =>  SB,
    SL      =>  SL,
    SAdd    =>  SAdd,
    SDin    =>  SDin,
    SPC     =>  SPC,
    W       =>  W,
    IncSp   =>  IncSp,
    DecSp   =>  DecSp
    );

inst_Status: RegistroStatus port map(
    clock   =>  clock,
    Z       =>  Z,
    N       =>  N,
    C       =>  C,
    Sout    =>  Sout
    );
    
end Behavioral;
