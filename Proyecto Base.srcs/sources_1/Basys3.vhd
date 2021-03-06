library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Basys3 is
    Port (
        sw          : in    std_logic_vector(15 downto 0); -- Se�ales de entrada de los interruptores -- Arriba   = '1'   -- Los 3 swiches de la derecha: 2, 1 y 0.
        btn         : in    std_logic_vector(4 downto 0);  -- Se�ales de entrada de los botones       -- Apretado = '1'   -- 0 central, 1 arriba, 2 izquierda, 3 derecha y 4 abajo.
        led         : out   std_logic_vector(15 downto 0);  -- Se�ales de salida  a  los leds          -- Prendido = '1'   -- Los 4 leds de la derecha: 3, 2, 1 y 0.
        lcd         : out   std_logic_vector(10 downto 0);
        clk         : in    std_logic;                      -- No Tocar - Se�al de entrada del clock   -- Frecuencia = 100Mhz.
        seg         : out   std_logic_vector(7 downto 0);  -- No Tocar - Salida de las se�ales de segmentos.
        an          : out   std_logic_vector(3 downto 0)   -- No Tocar - Salida del selector de diplay.
        );
end Basys3;

architecture Behavioral of Basys3 is

component RegistroStatus is
    Port ( 
        clock   :   in  std_logic;
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
        SL      :   out std_logic_vector(2 downto 0);   -- ALU
        SAdd    :   out std_logic_vector(1 downto 0);   -- mux address
        SDin    :   out std_logic;                      -- mux datain RAM
        SPC     :   out std_logic;                      -- mux PC
        W       :   out std_logic;                      -- write RAM
        IncSp   :   out std_logic;                      -- increment stack pointer
        DecSp   :   out std_logic;                      -- decrement stack pointer
        Lout    :   out std_logic                       -- load out data
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

component Clock_Divider -- No Tocar
    Port (
        clk         : in    std_logic;
        speed       : in    std_logic_vector (1 downto 0);
        clock       : out   std_logic
          );
    end component;

component Debouncer
    Port (
        clk         : in    std_logic;
        datain      : in    std_logic_vector (4 downto 0);
        dataout     : out   std_logic_vector (4 downto 0));
    end component;

component Timer 
    Port (  
        clk         : in    std_logic;
        seconds     : out   std_logic_vector (15 downto 0);
        mseconds    : out   std_logic_vector (15 downto 0);
        useconds    : out   std_logic_vector (15 downto 0)
          );
    end component;

signal d_btn            : std_logic_vector(4 downto 0);
    
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


component RegSP
    Port ( 
        clock   :  in  std_logic;
        IncSp   :   in  STD_LOGIC;
        DecSP   :   in  STD_LOGIC;
        SPout   :   out STD_LOGIC_VECTOR (11 downto 0)
    );
    end component;

component Adder
    Port ( 
        A       :   in  std_logic_vector (15 downto 0);
        B       :   in  std_logic_vector (15 downto 0);
        Cin     :   in  std_logic;
        Cout    :   out std_logic;
        S       :   out std_logic_vector (15 downto 0)
    );
    end component;

component RedDis
    Port (
        clock       :   in  std_logic;
        loadDis     :   in  std_logic;
        dataIN      :   in  std_logic_vector (15 downto 0);
        dis_a       :   out std_logic_vector(3 downto 0);
        dis_b       :   out std_logic_vector(3 downto 0);
        dis_c       :   out std_logic_vector(3 downto 0);
        dis_d       :   out std_logic_vector(3 downto 0)
    );
    end component;

component RegLed
    Port (
        clock       :   in  std_logic;
        loadLED     :   in  STD_LOGIC;
        dataIN      :   in  STD_LOGIC_VECTOR (15 downto 0);
        led         :   out  std_logic_vector (15 downto 0)
    );
    end component;

component DecoderOUT is
    Port (
        clock       :   in  std_logic;
        portAddress :   in STD_LOGIC_VECTOR (15 downto 0);
        loadOut     :   in STD_LOGIC;
        loadLCD     :   out STD_LOGIC;
        loadDis     :   out STD_LOGIC;
        loadLED     :   out STD_LOGIC
    );
    end component;

-- SENAL CLOCK
signal clock        :   std_logic;   

--SENAL instrucciones rom
signal romout       :   std_logic_vector(32 downto 0);

--SENAL Conteo PC
signal PCout       :   std_logic_vector(15 downto 0);

--SENAl RAM 
signal ramout       :   std_logic_vector(15 downto 0);
signal ramin        :   std_logic_vector(15 downto 0);

-- SE�ALES Control Unit 
signal LPC          :   std_logic;                      -- load pc
signal LA           :   std_logic;                      -- load A
signal LB           :   std_logic;                      -- load B
signal SA           :   std_logic_vector(1 downto 0);   -- mux A
signal SB           :   std_logic_vector(1 downto 0);   -- mux B
signal SL           :   std_logic_vector(2 downto 0);   -- ALU
signal SAdd         :   std_logic_vector(1 downto 0);   -- mux address
signal SDin         :   std_logic;                      -- mux datain RAM
signal SPC          :   std_logic;                      -- mux PC
signal W            :   std_logic;                      -- write RAM
signal IncSp        :   std_logic;                      -- increment stack pointer
signal DecSp        :   std_logic;                      -- decrement stack pointer
signal Lout         :   std_logic;                      -- load out data
            
-- SENALES DISPLAY
signal dis_a        :   std_logic_vector(3 downto 0);
signal dis_b        :   std_logic_vector(3 downto 0);
signal dis_c        :   std_logic_vector(3 downto 0);
signal dis_d        :   std_logic_vector(3 downto 0);

-- SENALES BOTONES
signal upA          :   std_logic;
signal upB          :   std_logic;
signal downA        :   std_logic;
signal downB        :   std_logic;

-- SENALES VALORES A, B, SP
signal valueA       :   std_logic_vector(15 downto 0);
signal valueB       :   std_logic_vector(15 downto 0);
signal valueSP      :   std_logic_vector(11 downto 0);

-- SENAL RESULTADO OPERACION ALU
signal Salu         :   std_logic_vector (15 downto 0);

-- SENAL STATUS
signal Z            :   std_logic;
signal N            :   std_logic;
signal C            :   std_logic;
signal Sout         :   std_logic_vector (2 downto 0);

-- SENALES MUX A, MUX B    -(Pongan las otras salidas de MUX aqu�)
signal MuxAout      :   std_logic_vector(15 downto 0);
signal MuxBout      :   std_logic_vector(15 downto 0);

-- SENAL MUX INPUT
signal MuxINOut     :   std_logic_vector(15 downto 0);

-- SENALES DECODER OUT
signal loadLCD      :   std_logic;
signal loadDis      :   std_logic;
signal loadLED      :   std_logic;

-- SENAL MUX ADDRESS
signal MuxSOut      :   std_logic_vector(11 downto 0);

-- SENAL MUX DATAIN
signal MuxSDinOut   :   std_logic_vector(15 downto 0);
signal SadderPC     :   std_logic_vector(15 downto 0);

-- SENAL MUX PC
signal MuxSPout     :   std_logic_vector(11 downto 0);
signal CoutAdderPC  :   std_logic;

-- SENALES TIMER
signal seconds      :   std_logic_vector(15 downto 0);
signal mseconds     :   std_logic_vector(15 downto 0);
signal useconds     :   std_logic_vector(15 downto 0);

begin

--clock <= clk;    

-- CONECCION LCD
lcd <= loadLCD & valueA(9 downto 0);

-- Mux A
with SA select MuxAout <=
    valueA                  when "00",
    "0000000000000000"      when "01",
    "0000000000000001"      when "10",
    MuxINOut                when "11";

-- Mux B
with SB select MuxBout <=
    valueB                  when "00",
    "0000000000000000"      when "01",
    romout(32 downto 17)    when "10",
    ramout                  when "11";

-- Mux Input data in
with romout(32 downto 17) select MuxINOut <=
    sw                      when "0000000000000000",
    "00000000000" & btn     when "0000000000000001",
    seconds                 when "0000000000000010",
    mseconds                when "0000000000000011",
    useconds                when "0000000000000100",
    "0000000000000000"      when others;

-- Mux Address in
with SAdd select MuxSOut <=
    romout(28 downto 17)    when "00",
    valueB(11 downto 0)     when "01",
    valueSP                 when "10",
    "000000000000"          when "11";

-- Mux Data in (RAM)
with SDin select MuxSDinOut <=
    Salu                    when '0',
    SadderPC                when '1';

-- Mux PC
with SPC select MuxSPout <=
    romout(28 downto 17)    when '0',
    ramout(11 downto 0)     when '1';

-- AUMENTAR VALOR DE A y B
--upA     <= btn(1)   and btn(2); -- A izquierdo
--upB     <= btn(1)   and btn(3); -- B derecho

-- REDUCIR VALOR DE A y B
--downA   <= btn(4)   and btn(2); -- A izquierdo
--downB   <= btn(4)   and btn(3); -- B derecho

inst_Clock_Divider: Clock_Divider port map( -- No Tocar - Intancia de Clock_Divider.
    clk         => clk,  -- No Tocar - Entrada del clock completo (100Mhz).
    speed       => "00", -- Selector de velocidad: "00" full, "01" fast, "10" normal y "11" slow. 
    clock       => clock -- No Tocar - Salida del clock reducido: 50Mhz, 8hz, 2hz y 0.5hz.
    );

inst_Debouncer: Debouncer port map(
    clk         => clk,
    datain      => btn,
    dataout     => d_btn
    );

inst_Timer: Timer port map(
    clk         => clk,
    seconds     => seconds,
    mseconds    => mseconds,
    useconds    => useconds
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
    datain  =>  MuxSPout,
    dataout =>  PCout(11 downto 0)
    );
    
inst_ROM: ROM port map(
    address =>  PCout(11 downto 0),
    dataout =>  romout
    );
    
inst_RAM: RAM port map(
    clock   =>  clock,
    write   =>  W,
    address =>  MuxSOut,
    datain  =>  MuxSDinOut,
    dataout =>  ramout
    );

inst_ControlUnit: ControlUnit port map(
    Opcode  =>  romout(6 downto 0),
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
    DecSp   =>  DecSp,
    Lout    =>  Lout
    );

inst_Status: RegistroStatus port map(
    clock   =>  clock,
    Z       =>  Z,
    N       =>  N,
    C       =>  C,
    Sout    =>  Sout
    );

inst_RegSP: RegSP port map(
    clock   =>  clock,
    IncSp   =>  IncSp,
    DecSP   =>  DecSp,
    SPout   =>  valueSP
    );

inst_AdderPC: Adder port map(
    A       =>  "0000000000000001",
    B       =>  PCout,
    Cin     =>  '0',
    Cout    =>  CoutAdderPC,
    S       =>  SadderPC
    );

inst_RegDis: RedDis port map(
    clock   =>  clock,
    loadDis =>  loadDis,
    dataIN  =>  valueA,
    dis_a   =>  dis_a,
    dis_b   =>  dis_b,
    dis_c   =>  dis_c,
    dis_d   =>  dis_d
    );

inst_RegLed: RegLed port map(
    clock   =>  clock,
    loadLED =>  loadLED,
    dataIN  =>  valueA,
    led     =>  led
    );

inst_DecoderOUT: DecoderOUT port map(
    clock       =>  clock,
    portAddress =>  MuxBout,
    loadOut     =>  Lout,
    loadLCD     =>  loadLCD,
    loadDis     =>  loadDis,
    loadLED     =>  loadLED
    );
    
end Behavioral;
