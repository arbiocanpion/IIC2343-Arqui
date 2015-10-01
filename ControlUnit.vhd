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

-- TODO: Esta parte depende de que Andres agregue el opcode que le falta
--with Opcode select LPC <=
--	'1'	 						when "0111101", -- JMP
--	Z and '1'					when "0111110", -- JEQ
--	Z xor '1'					when "0111111", -- JNE
--	(N xor '0') and (Z xor '0')	when "1000000", -- JGT
--	N xor '0'					when "1000001", -- JGE
--	N and '1'					when "1000010", -- JLT
--	(N and '1') or (Z and '1')	when "1000011", -- JLE
--	C and '1'					when "1000100", -- JCR
--	'0'							when others;

-- TODO: Falta de XOR en adelante
with Opcode select LA <=
	'0'							when "0000000", -- MOV A, B
	'0'							when "0000001", -- MOV B, A
	'0'							when "0000010", -- MOV A, Lit
	'0'							when "0000011", -- MOV B, Lit
	'0'							when "0000100", -- MOV A, Dir
	'0'							when "0000101", -- MOV B, Dir
	'0'							when "0000110", -- MOV Dir, A
	'0'							when "0000111", -- MOV Dir, B
	'0'							when "0001000", -- MOV A, DirB
	'0'							when "0001001", -- MOV B, DirB
	'0'							when "0001010", -- MOV DirB, A
	'0'							when "0001011", -- ADD A, B
	'0'							when "0001100", -- ADD B, A
	'0'							when "0001101", -- ADD A, Lit
	'0'							when "0001110", -- ADD B, Lit
	'0'							when "0001111", -- ADD A, Dir
	'0'							when "0010000", -- ADD B, Dir
	'0'							when "0010001", -- ADD Dir
	'0'							when "0010010", -- SUB A, B
	'0'							when "0010011", -- SUB B, A
	'0'							when "0010100", -- SUB A, Lit
	'0'							when "0010101", -- SUB B, Lit
	'0'							when "0010110", -- SUB A, Dir
	'0'							when "0010111", -- SUB B, Dir
	'0'							when "0011000", -- SUB Dir
	'0'							when "0011001", -- AND A, B
	'0'							when "0011010", -- AND B, A
	'0'							when "0011011", -- AND A, Lit
	'0'							when "0011100", -- AND B, Lit
	'0'							when "0011101", -- AND A, Dir
	'0'							when "0011110", -- AND B, Dir
	'0'							when "0011111", -- AND Dir
	'0'							when "0100000", -- OR A, B
	'0'							when "0100001", -- OR B, A
	'0'							when "0100010", -- OR A, Lit
	'0'							when "0100011", -- OR B, Lit
	'0'							when "0100100", -- OR A, Dir
	'0'							when "0100101", -- OR B, Dir
	'0'							when "0100110", -- OR Dir
	'0'							when "0100111", -- XOR A, B
	'0'							when "0101000", -- XOR B, A
	'0'							when "0101001", -- XOR A, Lit
	'0'							when "0101010", -- XOR A, Dir
	'0'							when "0101011", -- XOR B, Dir
	'0'							when "0101100", -- XOR Dir
	'0'							when "0101101", -- NOT A
	'0'							when "0101110", -- NOT B, A
	'0'							when "0101111", -- NOT Dir, A
	'0'							when "0110000", -- SHL A
	'0'							when "0110001", -- SHL B, A
	'0'							when "0110010", -- SHL Dir, A
	'0'							when "0110011", -- SHR A
	'0'							when "0110100", -- SHR B, A
	'0'							when "0110101", -- SHR Dir, A
	'0'							when "0110110", -- INC A
	'0'							when "0110111", -- INC B
	'0'							when "0111000", -- INC Dir
	'0'							when "0111001", -- DEC A
	'0'							when "0111010", -- CMP A, B
	'0'							when "0111011", -- CMP A, Lit
	'0'							when "0111100", -- CMP A, Dir
	'0'							when "0111101", -- JMP Dir
	'0'							when "0111110", -- JEQ Dir
	'0'							when "0111111", -- JNE Dir
	'0'							when "1000000", -- JGT Dir
	'0'							when "1000001", -- JGE Dir
	'0'							when "1000010", -- JLT Dir
	'0'							when "1000011", -- JLE Dir
	'0'							when "1000100", -- JCR Dir
	'0'							when "1000101", -- JCR NOP
	'0'							when others;


end Behavioral;