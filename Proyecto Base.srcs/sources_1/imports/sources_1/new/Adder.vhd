----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/08/2015 12:31:24 AM
-- Design Name: 
-- Module Name: Adder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Adder is
    Port ( 
        A           :   in  std_logic_vector (15 downto 0);
        B           :   in  std_logic_vector (15 downto 0);
        Cin         :   in  std_logic;
        Cout        :   out std_logic;
        S           :   out std_logic_vector (15 downto 0)
    );
end Adder;

architecture Behavioral of Adder is

component FA
        Port (
            A       :   in  std_logic;
            B       :   in  std_logic;
            Cin     :   in  std_logic;
            Cout    :   out std_logic;
            S       :   out std_logic);    
        end component;

signal CoutBuffer : std_logic_vector(15 downto 0);

begin

inst_F0: FA port map(
    A       =>  A(0),
    B       =>  B(0),
    Cin     =>  Cin,
    Cout    =>  CoutBuffer(0),
    S       =>  S(0)
    );
    
inst_F1: FA port map(
    A       =>  A(1),
    B       =>  B(1),
    Cin     =>  CoutBuffer(0),
    Cout    =>  CoutBuffer(1),
    S       =>  S(1)
    );

inst_F2: FA port map(
    A       =>  A(2),
    B       =>  B(2),
    Cin     =>  CoutBuffer(1),
    Cout    =>  CoutBuffer(2),
    S       =>  S(2)
    );

inst_F3: FA port map(
    A       =>  A(3),
    B       =>  B(3),
    Cin     =>  CoutBuffer(2),
    Cout    =>  CoutBuffer(3),
    S       =>  S(3)
    );

inst_F4: FA port map(
    A       =>  A(4),
    B       =>  B(4),
    Cin     =>  CoutBuffer(3),
    Cout    =>  CoutBuffer(4),
    S       =>  S(4)
    );

inst_F5: FA port map(
    A       =>  A(5),
    B       =>  B(5),
    Cin     =>  CoutBuffer(4),
    Cout    =>  CoutBuffer(5),
    S       =>  S(5)
    );

inst_F6: FA port map(
    A       =>  A(6),
    B       =>  B(6),
    Cin     =>  CoutBuffer(5),
    Cout    =>  CoutBuffer(6),
    S       =>  S(6)
    );

inst_F7: FA port map(
    A       =>  A(7),
    B       =>  B(7),
    Cin     =>  CoutBuffer(6),
    Cout    =>  CoutBuffer(7),
    S       =>  S(7)
    );
        
inst_F8: FA port map(
    A       =>  A(8),
    B       =>  B(8),
    Cin     =>  CoutBuffer(7),
    Cout    =>  CoutBuffer(8),
    S       =>  S(8)
    );
                
inst_F9: FA port map(
    A       =>  A(9),
    B       =>  B(9),
    Cin     =>  CoutBuffer(8),
    Cout    =>  CoutBuffer(9),
    S       =>  S(9)
    );
                
inst_F10: FA port map(
    A       =>  A(10),
    B       =>  B(10),
    Cin     =>  CoutBuffer(9),
    Cout    =>  CoutBuffer(10),
    S       =>  S(10)
    );
                
inst_F11: FA port map(
    A       =>  A(11),
    B       =>  B(11),
    Cin     =>  CoutBuffer(10),
    Cout    =>  CoutBuffer(11),
    S       =>  S(11)
    );
                
inst_F12: FA port map(
    A       =>  A(12),
    B       =>  B(12),
    Cin     =>  CoutBuffer(11),
    Cout    =>  CoutBuffer(12),
    S       =>  S(12)
    );
                
inst_F13: FA port map(
    A       =>  A(13),
    B       =>  B(13),
    Cin     =>  CoutBuffer(12),
    Cout    =>  CoutBuffer(13),
    S       =>  S(13)
    );
                
inst_F14: FA port map(
    A       =>  A(14),
    B       =>  B(14),
    Cin     =>  CoutBuffer(13),
    Cout    =>  CoutBuffer(14),
    S       =>  S(14)
    );
                
inst_F15: FA port map(
    A       =>  A(15),
    B       =>  B(15),
    Cin     =>  CoutBuffer(14),
    Cout    =>  Cout,
    S       =>  S(15)
    );

end Behavioral;