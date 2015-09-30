----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.09.2015 00:00:00
-- Design Name: 
-- Module Name: ControlUnit - Behavioral
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

entity ControlUnit is
	Port (
		Opcode	: 	in std_logic_vector(6 downto 0); 	-- instruction to execute
    	Z 		: 	in std_logic;						-- zero
        N 		: 	in std_logic;						-- negative
        V 		: 	in std_logic;						-- overflow
        C 		: 	in std_logic;						-- carry
		LPC		: 	out std_logic;                   	-- load pc
		LA 		: 	out std_logic;                   	-- load A
		LB 		: 	out std_logic;                   	-- load B
		SA 		: 	out std_logic_vector(1 downto 0);	-- mux A
		SB 		: 	out std_logic_vector(1 downto 0);	-- mux B
		SL 		: 	out std_logic_vector(2 downto 0) 	-- ALU
		SAdd 	: 	out std_logic_vector(1 downto 0);	-- mux address
		SDin 	: 	out std_logic;                   	-- mux datain RAM
		SPC 	: 	out std_logic;                   	-- mux PC
		W 		: 	out std_logic;                   	-- write RAM
		IncSp 	: 	out std_logic;                   	-- increment stack pointer
		DecSp 	: 	out std_logic                    	-- decrement stack pointer
	);
end ControlUnit;

architecture Behavioral of ControlUnit is 

begin

with Opcode select LPC <=
	'1'	 						when "0111101", -- JMP
	Z and '1'					when "0111110", -- JEQ
	Z xor '1'					when "0111111", -- JNE
	(N xor '0') and (Z xor '0')	when "1000000", -- JGT
	N xor '0'					when "1000001", -- JGE
	N and '1'					when "1000010", -- JLT
	(N and '1') or (Z and '1')	when "1000011", -- JLE
	C and '1'					when "1000100", -- JCR
	0							when others;

with Opcode select LA <=
	'1'	 						when "0000000", -- MOV A, B
	'1'	 						when "0000010", -- MOV A, Lit
	'1'	 						when "0000100", -- MOV A, Dir
	'1'	 						when "0001000", -- MOV A, DirB
	'1'	 						when "0001010", -- MOV DirB, A
	'1'	 						when "0001011", -- ADD A, B
	'1'	 						when "0001101", -- ADD A, Lit
	'1'	 						when "0001111", -- ADD A, Dir
	'1'	 						when "0010010", -- SUB A, B
	'1'	 						when "0010100", -- SUB A, Lit
	'1'	 						when "0010110", -- SUB A, Dir
	'1'	 						when "0011001", -- AND A, B
	'1'	 						when "0011011", -- AND A, Lit
	'1'	 						when "0011101", -- AND A, Dir
	'1'	 						when "0100000", -- OR A, B
	'1'	 						when "0100010", -- OR A, Lit
	'1'	 						when "0100100", -- OR A, Dir
	0							when others;
	
-- TODO: Andres debe revisar, falta el XOR B, Lit
--XOR
--A B        0100111
--B A        0101000
--A Lit      0101001
--A Dir      0101010
--B Dir      0101011
--Dir        0101100


end Behavioral;