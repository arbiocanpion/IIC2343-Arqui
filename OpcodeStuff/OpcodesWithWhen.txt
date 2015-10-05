library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ControlUnit is
	Port (
		Opcode	:	in	std_logic_vector(6 downto 0);	-- instruction to execute
		Z		:	in	std_logic;						-- zero
		N		:	in	std_logic;						-- negative
		C		:	in	std_logic;						-- carry
		LPC		:	out	std_logic;						-- load pc
		LA		:	out	std_logic;						-- load A
		LB		:	out	std_logic;						-- load B
		SA		:	out	std_logic_vector(1 downto 0);	-- mux A
		SB		:	out	std_logic_vector(1 downto 0);	-- mux B
		SL		:	out	std_logic_vector(2 downto 0);	-- ALU
		SAdd	:	out	std_logic_vector(1 downto 0);	-- mux address
		SDin	:	out	std_logic;						-- mux datain RAM
		SPC		:	out	std_logic;						-- mux PC
		W		:	out	std_logic;						-- write RAM
		IncSp	:	out	std_logic;						-- increment stack pointer
		DecSp	:	out	std_logic						-- decrement stack pointer
	);
end ControlUnit;

architecture Behavioral of ControlUnit is

begin

with Opcode select LPC <=
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
	'0'							when "0101010", -- XOR B, Lit
	'0'							when "0101011", -- XOR A, Dir
	'0'							when "0101100", -- XOR B, Dir
	'0'							when "0101101", -- XOR Dir
	'0'							when "0101110", -- NOT A
	'0'							when "0101111", -- NOT B, A
	'0'							when "0110000", -- NOT Dir, A
	'0'							when "0110001", -- SHL A
	'0'							when "0110010", -- SHL B, A
	'0'							when "0110011", -- SHL Dir, A
	'0'							when "0110100", -- SHR A
	'0'							when "0110101", -- SHR B, A
	'0'							when "0110110", -- SHR Dir, A
	'0'							when "0110111", -- INC A
	'0'							when "0111000", -- INC B
	'0'							when "0111001", -- INC Dir
	'0'							when "0111010", -- DEC A
	'0'							when "0111011", -- CMP A, B
	'0'							when "0111100", -- CMP A, Lit
	'0'							when "0111101", -- CMP A, Dir
	'0'							when "0111110", -- JMP Dir
	Z and '1'					when "0111111", -- JEQ Dir
	Z xor '1'					when "1000000", -- JNE Dir
	(N xor '1') and (Z xor '1')	when "1000001", -- JGT Dir
	N xor '0'					when "1000010", -- JGE Dir
	N and '1'					when "1000011", -- JLT Dir
	(N and '1') or (Z and '1')	when "1000100", -- JLE Dir
	C and '1'					when "1000101", -- JCR Dir
	'0'							when "1000110", -- NOP NOP
	'0'							when others;

with Opcode select LA <=
	'1'							when "0000000", -- MOV A, B
	'0'							when "0000001", -- MOV B, A
	'1'							when "0000010", -- MOV A, Lit
	'0'							when "0000011", -- MOV B, Lit
	'1'							when "0000100", -- MOV A, Dir
	'0'							when "0000101", -- MOV B, Dir
	'0'							when "0000110", -- MOV Dir, A
	'0'							when "0000111", -- MOV Dir, B
	'1'							when "0001000", -- MOV A, DirB
	'0'							when "0001001", -- MOV B, DirB
	'0'							when "0001010", -- MOV DirB, A
	'1'							when "0001011", -- ADD A, B
	'0'							when "0001100", -- ADD B, A
	'1'							when "0001101", -- ADD A, Lit
	'0'							when "0001110", -- ADD B, Lit
	'1'							when "0001111", -- ADD A, Dir
	'0'							when "0010000", -- ADD B, Dir
	'0'							when "0010001", -- ADD Dir
	'1'							when "0010010", -- SUB A, B
	'0'							when "0010011", -- SUB B, A
	'1'							when "0010100", -- SUB A, Lit
	'0'							when "0010101", -- SUB B, Lit
	'1'							when "0010110", -- SUB A, Dir
	'0'							when "0010111", -- SUB B, Dir
	'0'							when "0011000", -- SUB Dir
	'1'							when "0011001", -- AND A, B
	'0'							when "0011010", -- AND B, A
	'1'							when "0011011", -- AND A, Lit
	'0'							when "0011100", -- AND B, Lit
	'1'							when "0011101", -- AND A, Dir
	'0'							when "0011110", -- AND B, Dir
	'0'							when "0011111", -- AND Dir
	'1'							when "0100000", -- OR A, B
	'0'							when "0100001", -- OR B, A
	'1'							when "0100010", -- OR A, Lit
	'0'							when "0100011", -- OR B, Lit
	'1'							when "0100100", -- OR A, Dir
	'0'							when "0100101", -- OR B, Dir
	'0'							when "0100110", -- OR Dir
	'1'							when "0100111", -- XOR A, B
	'0'							when "0101000", -- XOR B, A
	'1'							when "0101001", -- XOR A, Lit
	'0'							when "0101010", -- XOR B, Lit
	'1'							when "0101011", -- XOR A, Dir
	'0'							when "0101100", -- XOR B, Dir
	'0'							when "0101101", -- XOR Dir
	'1'							when "0101110", -- NOT A
	'0'							when "0101111", -- NOT B, A
	'0'							when "0110000", -- NOT Dir, A
	'1'							when "0110001", -- SHL A
	'0'							when "0110010", -- SHL B, A
	'0'							when "0110011", -- SHL Dir, A
	'1'							when "0110100", -- SHR A
	'0'							when "0110101", -- SHR B, A
	'0'							when "0110110", -- SHR Dir, A
	'1'							when "0110111", -- INC A
	'0'							when "0111000", -- INC B
	'0'							when "0111001", -- INC Dir
	'1'							when "0111010", -- DEC A
	'1'							when "0111011", -- CMP A, B
	'1'							when "0111100", -- CMP A, Lit
	'1'							when "0111101", -- CMP A, Dir
	'0'							when "0111110", -- JMP Dir
	'0'							when "0111111", -- JEQ Dir
	'0'							when "1000000", -- JNE Dir
	'0'							when "1000001", -- JGT Dir
	'0'							when "1000010", -- JGE Dir
	'0'							when "1000011", -- JLT Dir
	'0'							when "1000100", -- JLE Dir
	'0'							when "1000101", -- JCR Dir
	'0'							when "1000110", -- NOP NOP
	'0'							when others;

with Opcode select LB <=
	'0'							when "0000000", -- MOV A, B
	'1'							when "0000001", -- MOV B, A
	'0'							when "0000010", -- MOV A, Lit
	'1'							when "0000011", -- MOV B, Lit
	'0'							when "0000100", -- MOV A, Dir
	'1'							when "0000101", -- MOV B, Dir
	'0'							when "0000110", -- MOV Dir, A
	'0'							when "0000111", -- MOV Dir, B
	'0'							when "0001000", -- MOV A, DirB
	'1'							when "0001001", -- MOV B, DirB
	'0'							when "0001010", -- MOV DirB, A
	'0'							when "0001011", -- ADD A, B
	'1'							when "0001100", -- ADD B, A
	'0'							when "0001101", -- ADD A, Lit
	'1'							when "0001110", -- ADD B, Lit
	'0'							when "0001111", -- ADD A, Dir
	'1'							when "0010000", -- ADD B, Dir
	'0'							when "0010001", -- ADD Dir
	'0'							when "0010010", -- SUB A, B
	'1'							when "0010011", -- SUB B, A
	'0'							when "0010100", -- SUB A, Lit
	'1'							when "0010101", -- SUB B, Lit
	'0'							when "0010110", -- SUB A, Dir
	'1'							when "0010111", -- SUB B, Dir
	'0'							when "0011000", -- SUB Dir
	'0'							when "0011001", -- AND A, B
	'1'							when "0011010", -- AND B, A
	'0'							when "0011011", -- AND A, Lit
	'1'							when "0011100", -- AND B, Lit
	'0'							when "0011101", -- AND A, Dir
	'1'							when "0011110", -- AND B, Dir
	'0'							when "0011111", -- AND Dir
	'0'							when "0100000", -- OR A, B
	'1'							when "0100001", -- OR B, A
	'0'							when "0100010", -- OR A, Lit
	'1'							when "0100011", -- OR B, Lit
	'0'							when "0100100", -- OR A, Dir
	'1'							when "0100101", -- OR B, Dir
	'0'							when "0100110", -- OR Dir
	'0'							when "0100111", -- XOR A, B
	'1'							when "0101000", -- XOR B, A
	'0'							when "0101001", -- XOR A, Lit
	'1'							when "0101010", -- XOR B, Lit
	'0'							when "0101011", -- XOR A, Dir
	'1'							when "0101100", -- XOR B, Dir
	'0'							when "0101101", -- XOR Dir
	'0'							when "0101110", -- NOT A
	'1'							when "0101111", -- NOT B, A
	'0'							when "0110000", -- NOT Dir, A
	'0'							when "0110001", -- SHL A
	'1'							when "0110010", -- SHL B, A
	'0'							when "0110011", -- SHL Dir, A
	'0'							when "0110100", -- SHR A
	'1'							when "0110101", -- SHR B, A
	'0'							when "0110110", -- SHR Dir, A
	'0'							when "0110111", -- INC A
	'1'							when "0111000", -- INC B
	'0'							when "0111001", -- INC Dir
	'0'							when "0111010", -- DEC A
	'0'							when "0111011", -- CMP A, B
	'0'							when "0111100", -- CMP A, Lit
	'0'							when "0111101", -- CMP A, Dir
	'0'							when "0111110", -- JMP Dir
	'0'							when "0111111", -- JEQ Dir
	'0'							when "1000000", -- JNE Dir
	'0'							when "1000001", -- JGT Dir
	'0'							when "1000010", -- JGE Dir
	'0'							when "1000011", -- JLT Dir
	'0'							when "1000100", -- JLE Dir
	'0'							when "1000101", -- JCR Dir
	'0'							when "1000110", -- NOP NOP
	'0'							when others;

with Opcode select SA <=
	"01"						when "0000000", -- MOV A, B
	"00"						when "0000001", -- MOV B, A
	"01"						when "0000010", -- MOV A, Lit
	"01"						when "0000011", -- MOV B, Lit
	"01"						when "0000100", -- MOV A, Dir
	"01"						when "0000101", -- MOV B, Dir
	"00"						when "0000110", -- MOV Dir, A
	"01"						when "0000111", -- MOV Dir, B
	"01"						when "0001000", -- MOV A, DirB
	"01"						when "0001001", -- MOV B, DirB
	"00"						when "0001010", -- MOV DirB, A
	"00"						when "0001011", -- ADD A, B
	"00"						when "0001100", -- ADD B, A
	"00"						when "0001101", -- ADD A, Lit
	"00"						when "0001110", -- ADD B, Lit
	"00"						when "0001111", -- ADD A, Dir
	"00"						when "0010000", -- ADD B, Dir
	"00"						when "0010001", -- ADD Dir
	"00"						when "0010010", -- SUB A, B
	"00"						when "0010011", -- SUB B, A
	"00"						when "0010100", -- SUB A, Lit
	"00"						when "0010101", -- SUB B, Lit
	"00"						when "0010110", -- SUB A, Dir
	"00"						when "0010111", -- SUB B, Dir
	"00"						when "0011000", -- SUB Dir
	"00"						when "0011001", -- AND A, B
	"00"						when "0011010", -- AND B, A
	"00"						when "0011011", -- AND A, Lit
	"00"						when "0011100", -- AND B, Lit
	"00"						when "0011101", -- AND A, Dir
	"00"						when "0011110", -- AND B, Dir
	"00"						when "0011111", -- AND Dir
	"00"						when "0100000", -- OR A, B
	"00"						when "0100001", -- OR B, A
	"00"						when "0100010", -- OR A, Lit
	"00"						when "0100011", -- OR B, Lit
	"00"						when "0100100", -- OR A, Dir
	"00"						when "0100101", -- OR B, Dir
	"00"						when "0100110", -- OR Dir
	"00"						when "0100111", -- XOR A, B
	"00"						when "0101000", -- XOR B, A
	"00"						when "0101001", -- XOR A, Lit
	"00"						when "0101010", -- XOR B, Lit
	"00"						when "0101011", -- XOR A, Dir
	"00"						when "0101100", -- XOR B, Dir
	"00"						when "0101101", -- XOR Dir
	"00"						when "0101110", -- NOT A
	"00"						when "0101111", -- NOT B, A
	"00"						when "0110000", -- NOT Dir, A
	"00"						when "0110001", -- SHL A
	"00"						when "0110010", -- SHL B, A
	"00"						when "0110011", -- SHL Dir, A
	"00"						when "0110100", -- SHR A
	"00"						when "0110101", -- SHR B, A
	"00"						when "0110110", -- SHR Dir, A
	"00"						when "0110111", -- INC A
	"10"						when "0111000", -- INC B
	"10"						when "0111001", -- INC Dir
	"00"						when "0111010", -- DEC A
	"00"						when "0111011", -- CMP A, B
	"00"						when "0111100", -- CMP A, Lit
	"00"						when "0111101", -- CMP A, Dir
	"00"						when "0111110", -- JMP Dir
	"00"						when "0111111", -- JEQ Dir
	"00"						when "1000000", -- JNE Dir
	"00"						when "1000001", -- JGT Dir
	"00"						when "1000010", -- JGE Dir
	"00"						when "1000011", -- JLT Dir
	"00"						when "1000100", -- JLE Dir
	"00"						when "1000101", -- JCR Dir
	"00"						when "1000110", -- NOP NOP
	"00"						when others;

with Opcode select SB <=
	"00"						when "0000000", -- MOV A, B
	"01"						when "0000001", -- MOV B, A
	"10"						when "0000010", -- MOV A, Lit
	"01"						when "0000011", -- MOV B, Lit
	"11"						when "0000100", -- MOV A, Dir
	"01"						when "0000101", -- MOV B, Dir
	"01"						when "0000110", -- MOV Dir, A
	"00"						when "0000111", -- MOV Dir, B
	"11"						when "0001000", -- MOV A, DirB
	"01"						when "0001001", -- MOV B, DirB
	"01"						when "0001010", -- MOV DirB, A
	"00"						when "0001011", -- ADD A, B
	"00"						when "0001100", -- ADD B, A
	"10"						when "0001101", -- ADD A, Lit
	"10"						when "0001110", -- ADD B, Lit
	"11"						when "0001111", -- ADD A, Dir
	"11"						when "0010000", -- ADD B, Dir
	"00"						when "0010001", -- ADD Dir
	"00"						when "0010010", -- SUB A, B
	"00"						when "0010011", -- SUB B, A
	"10"						when "0010100", -- SUB A, Lit
	"10"						when "0010101", -- SUB B, Lit
	"11"						when "0010110", -- SUB A, Dir
	"11"						when "0010111", -- SUB B, Dir
	"00"						when "0011000", -- SUB Dir
	"00"						when "0011001", -- AND A, B
	"00"						when "0011010", -- AND B, A
	"10"						when "0011011", -- AND A, Lit
	"10"						when "0011100", -- AND B, Lit
	"11"						when "0011101", -- AND A, Dir
	"11"						when "0011110", -- AND B, Dir
	"00"						when "0011111", -- AND Dir
	"00"						when "0100000", -- OR A, B
	"00"						when "0100001", -- OR B, A
	"10"						when "0100010", -- OR A, Lit
	"10"						when "0100011", -- OR B, Lit
	"11"						when "0100100", -- OR A, Dir
	"11"						when "0100101", -- OR B, Dir
	"00"						when "0100110", -- OR Dir
	"00"						when "0100111", -- XOR A, B
	"00"						when "0101000", -- XOR B, A
	"10"						when "0101001", -- XOR A, Lit
	"10"						when "0101010", -- XOR B, Lit
	"11"						when "0101011", -- XOR A, Dir
	"11"						when "0101100", -- XOR B, Dir
	"00"						when "0101101", -- XOR Dir
	"00"						when "0101110", -- NOT A
	"00"						when "0101111", -- NOT B, A
	"00"						when "0110000", -- NOT Dir, A
	"00"						when "0110001", -- SHL A
	"00"						when "0110010", -- SHL B, A
	"00"						when "0110011", -- SHL Dir, A
	"00"						when "0110100", -- SHR A
	"00"						when "0110101", -- SHR B, A
	"00"						when "0110110", -- SHR Dir, A
	"10"						when "0110111", -- INC A
	"00"						when "0111000", -- INC B
	"10"						when "0111001", -- INC Dir
	"10"						when "0111010", -- DEC A
	"00"						when "0111011", -- CMP A, B
	"10"						when "0111100", -- CMP A, Lit
	"11"						when "0111101", -- CMP A, Dir
	"00"						when "0111110", -- JMP Dir
	"00"						when "0111111", -- JEQ Dir
	"00"						when "1000000", -- JNE Dir
	"00"						when "1000001", -- JGT Dir
	"00"						when "1000010", -- JGE Dir
	"00"						when "1000011", -- JLT Dir
	"00"						when "1000100", -- JLE Dir
	"00"						when "1000101", -- JCR Dir
	"00"						when "1000110", -- NOP NOP
	"00"						when others;

with Opcode select SL <=
	"000"						when "0000000", -- MOV A, B
	"000"						when "0000001", -- MOV B, A
	"000"						when "0000010", -- MOV A, Lit
	"000"						when "0000011", -- MOV B, Lit
	"000"						when "0000100", -- MOV A, Dir
	"000"						when "0000101", -- MOV B, Dir
	"000"						when "0000110", -- MOV Dir, A
	"000"						when "0000111", -- MOV Dir, B
	"000"						when "0001000", -- MOV A, DirB
	"000"						when "0001001", -- MOV B, DirB
	"000"						when "0001010", -- MOV DirB, A
	"000"						when "0001011", -- ADD A, B
	"000"						when "0001100", -- ADD B, A
	"000"						when "0001101", -- ADD A, Lit
	"000"						when "0001110", -- ADD B, Lit
	"000"						when "0001111", -- ADD A, Dir
	"000"						when "0010000", -- ADD B, Dir
	"000"						when "0010001", -- ADD Dir
	"001"						when "0010010", -- SUB A, B
	"001"						when "0010011", -- SUB B, A
	"001"						when "0010100", -- SUB A, Lit
	"001"						when "0010101", -- SUB B, Lit
	"001"						when "0010110", -- SUB A, Dir
	"001"						when "0010111", -- SUB B, Dir
	"001"						when "0011000", -- SUB Dir
	"010"						when "0011001", -- AND A, B
	"010"						when "0011010", -- AND B, A
	"010"						when "0011011", -- AND A, Lit
	"010"						when "0011100", -- AND B, Lit
	"010"						when "0011101", -- AND A, Dir
	"010"						when "0011110", -- AND B, Dir
	"010"						when "0011111", -- AND Dir
	"011"						when "0100000", -- OR A, B
	"011"						when "0100001", -- OR B, A
	"011"						when "0100010", -- OR A, Lit
	"011"						when "0100011", -- OR B, Lit
	"011"						when "0100100", -- OR A, Dir
	"011"						when "0100101", -- OR B, Dir
	"011"						when "0100110", -- OR Dir
	"100"						when "0100111", -- XOR A, B
	"100"						when "0101000", -- XOR B, A
	"100"						when "0101001", -- XOR A, Lit
	"100"						when "0101010", -- XOR B, Lit
	"100"						when "0101011", -- XOR A, Dir
	"100"						when "0101100", -- XOR B, Dir
	"100"						when "0101101", -- XOR Dir
	"101"						when "0101110", -- NOT A
	"101"						when "0101111", -- NOT B, A
	"101"						when "0110000", -- NOT Dir, A
	"111"						when "0110001", -- SHL A
	"111"						when "0110010", -- SHL B, A
	"111"						when "0110011", -- SHL Dir, A
	"110"						when "0110100", -- SHR A
	"110"						when "0110101", -- SHR B, A
	"110"						when "0110110", -- SHR Dir, A
	"000"						when "0110111", -- INC A
	"000"						when "0111000", -- INC B
	"000"						when "0111001", -- INC Dir
	"001"						when "0111010", -- DEC A
	"001"						when "0111011", -- CMP A, B
	"001"						when "0111100", -- CMP A, Lit
	"001"						when "0111101", -- CMP A, Dir
	"000"						when "0111110", -- JMP Dir
	"000"						when "0111111", -- JEQ Dir
	"000"						when "1000000", -- JNE Dir
	"000"						when "1000001", -- JGT Dir
	"000"						when "1000010", -- JGE Dir
	"000"						when "1000011", -- JLT Dir
	"000"						when "1000100", -- JLE Dir
	"000"						when "1000101", -- JCR Dir
	"000"						when "1000110", -- NOP NOP
	"000"						when others;

with Opcode select SAdd <=
	"00"						when "0000000", -- MOV A, B
	"00"						when "0000001", -- MOV B, A
	"00"						when "0000010", -- MOV A, Lit
	"00"						when "0000011", -- MOV B, Lit
	"00"						when "0000100", -- MOV A, Dir
	"00"						when "0000101", -- MOV B, Dir
	"00"						when "0000110", -- MOV Dir, A
	"00"						when "0000111", -- MOV Dir, B
	"01"						when "0001000", -- MOV A, DirB
	"01"						when "0001001", -- MOV B, DirB
	"01"						when "0001010", -- MOV DirB, A
	"00"						when "0001011", -- ADD A, B
	"00"						when "0001100", -- ADD B, A
	"00"						when "0001101", -- ADD A, Lit
	"00"						when "0001110", -- ADD B, Lit
	"00"						when "0001111", -- ADD A, Dir
	"00"						when "0010000", -- ADD B, Dir
	"00"						when "0010001", -- ADD Dir
	"00"						when "0010010", -- SUB A, B
	"00"						when "0010011", -- SUB B, A
	"00"						when "0010100", -- SUB A, Lit
	"00"						when "0010101", -- SUB B, Lit
	"00"						when "0010110", -- SUB A, Dir
	"00"						when "0010111", -- SUB B, Dir
	"00"						when "0011000", -- SUB Dir
	"00"						when "0011001", -- AND A, B
	"00"						when "0011010", -- AND B, A
	"00"						when "0011011", -- AND A, Lit
	"00"						when "0011100", -- AND B, Lit
	"00"						when "0011101", -- AND A, Dir
	"00"						when "0011110", -- AND B, Dir
	"00"						when "0011111", -- AND Dir
	"00"						when "0100000", -- OR A, B
	"00"						when "0100001", -- OR B, A
	"00"						when "0100010", -- OR A, Lit
	"00"						when "0100011", -- OR B, Lit
	"00"						when "0100100", -- OR A, Dir
	"00"						when "0100101", -- OR B, Dir
	"00"						when "0100110", -- OR Dir
	"00"						when "0100111", -- XOR A, B
	"00"						when "0101000", -- XOR B, A
	"00"						when "0101001", -- XOR A, Lit
	"00"						when "0101010", -- XOR B, Lit
	"00"						when "0101011", -- XOR A, Dir
	"00"						when "0101100", -- XOR B, Dir
	"00"						when "0101101", -- XOR Dir
	"00"						when "0101110", -- NOT A
	"00"						when "0101111", -- NOT B, A
	"00"						when "0110000", -- NOT Dir, A
	"00"						when "0110001", -- SHL A
	"00"						when "0110010", -- SHL B, A
	"00"						when "0110011", -- SHL Dir, A
	"00"						when "0110100", -- SHR A
	"00"						when "0110101", -- SHR B, A
	"00"						when "0110110", -- SHR Dir, A
	"00"						when "0110111", -- INC A
	"00"						when "0111000", -- INC B
	"00"						when "0111001", -- INC Dir
	"00"						when "0111010", -- DEC A
	"00"						when "0111011", -- CMP A, B
	"00"						when "0111100", -- CMP A, Lit
	"00"						when "0111101", -- CMP A, Dir
	"00"						when "0111110", -- JMP Dir
	"00"						when "0111111", -- JEQ Dir
	"00"						when "1000000", -- JNE Dir
	"00"						when "1000001", -- JGT Dir
	"00"						when "1000010", -- JGE Dir
	"00"						when "1000011", -- JLT Dir
	"00"						when "1000100", -- JLE Dir
	"00"						when "1000101", -- JCR Dir
	"00"						when "1000110", -- NOP NOP
	"00"						when others;

with Opcode select SDin <=
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
	'0'							when "0101010", -- XOR B, Lit
	'0'							when "0101011", -- XOR A, Dir
	'0'							when "0101100", -- XOR B, Dir
	'0'							when "0101101", -- XOR Dir
	'0'							when "0101110", -- NOT A
	'0'							when "0101111", -- NOT B, A
	'0'							when "0110000", -- NOT Dir, A
	'0'							when "0110001", -- SHL A
	'0'							when "0110010", -- SHL B, A
	'0'							when "0110011", -- SHL Dir, A
	'0'							when "0110100", -- SHR A
	'0'							when "0110101", -- SHR B, A
	'0'							when "0110110", -- SHR Dir, A
	'0'							when "0110111", -- INC A
	'0'							when "0111000", -- INC B
	'0'							when "0111001", -- INC Dir
	'0'							when "0111010", -- DEC A
	'0'							when "0111011", -- CMP A, B
	'0'							when "0111100", -- CMP A, Lit
	'0'							when "0111101", -- CMP A, Dir
	'0'							when "0111110", -- JMP Dir
	'0'							when "0111111", -- JEQ Dir
	'0'							when "1000000", -- JNE Dir
	'0'							when "1000001", -- JGT Dir
	'0'							when "1000010", -- JGE Dir
	'0'							when "1000011", -- JLT Dir
	'0'							when "1000100", -- JLE Dir
	'0'							when "1000101", -- JCR Dir
	'0'							when "1000110", -- NOP NOP
	'0'							when others;

with Opcode select SPC <=
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
	'0'							when "0101010", -- XOR B, Lit
	'0'							when "0101011", -- XOR A, Dir
	'0'							when "0101100", -- XOR B, Dir
	'0'							when "0101101", -- XOR Dir
	'0'							when "0101110", -- NOT A
	'0'							when "0101111", -- NOT B, A
	'0'							when "0110000", -- NOT Dir, A
	'0'							when "0110001", -- SHL A
	'0'							when "0110010", -- SHL B, A
	'0'							when "0110011", -- SHL Dir, A
	'0'							when "0110100", -- SHR A
	'0'							when "0110101", -- SHR B, A
	'0'							when "0110110", -- SHR Dir, A
	'0'							when "0110111", -- INC A
	'0'							when "0111000", -- INC B
	'0'							when "0111001", -- INC Dir
	'0'							when "0111010", -- DEC A
	'0'							when "0111011", -- CMP A, B
	'0'							when "0111100", -- CMP A, Lit
	'0'							when "0111101", -- CMP A, Dir
	'0'							when "0111110", -- JMP Dir
	'0'							when "0111111", -- JEQ Dir
	'0'							when "1000000", -- JNE Dir
	'0'							when "1000001", -- JGT Dir
	'0'							when "1000010", -- JGE Dir
	'0'							when "1000011", -- JLT Dir
	'0'							when "1000100", -- JLE Dir
	'0'							when "1000101", -- JCR Dir
	'0'							when "1000110", -- NOP NOP
	'0'							when others;

with Opcode select W <=
	'0'							when "0000000", -- MOV A, B
	'0'							when "0000001", -- MOV B, A
	'0'							when "0000010", -- MOV A, Lit
	'0'							when "0000011", -- MOV B, Lit
	'0'							when "0000100", -- MOV A, Dir
	'0'							when "0000101", -- MOV B, Dir
	'1'							when "0000110", -- MOV Dir, A
	'1'							when "0000111", -- MOV Dir, B
	'0'							when "0001000", -- MOV A, DirB
	'0'							when "0001001", -- MOV B, DirB
	'1'							when "0001010", -- MOV DirB, A
	'0'							when "0001011", -- ADD A, B
	'0'							when "0001100", -- ADD B, A
	'0'							when "0001101", -- ADD A, Lit
	'0'							when "0001110", -- ADD B, Lit
	'0'							when "0001111", -- ADD A, Dir
	'0'							when "0010000", -- ADD B, Dir
	'1'							when "0010001", -- ADD Dir
	'0'							when "0010010", -- SUB A, B
	'0'							when "0010011", -- SUB B, A
	'0'							when "0010100", -- SUB A, Lit
	'0'							when "0010101", -- SUB B, Lit
	'0'							when "0010110", -- SUB A, Dir
	'0'							when "0010111", -- SUB B, Dir
	'1'							when "0011000", -- SUB Dir
	'0'							when "0011001", -- AND A, B
	'0'							when "0011010", -- AND B, A
	'0'							when "0011011", -- AND A, Lit
	'0'							when "0011100", -- AND B, Lit
	'0'							when "0011101", -- AND A, Dir
	'0'							when "0011110", -- AND B, Dir
	'1'							when "0011111", -- AND Dir
	'0'							when "0100000", -- OR A, B
	'0'							when "0100001", -- OR B, A
	'0'							when "0100010", -- OR A, Lit
	'0'							when "0100011", -- OR B, Lit
	'0'							when "0100100", -- OR A, Dir
	'0'							when "0100101", -- OR B, Dir
	'1'							when "0100110", -- OR Dir
	'0'							when "0100111", -- XOR A, B
	'0'							when "0101000", -- XOR B, A
	'0'							when "0101001", -- XOR A, Lit
	'0'							when "0101010", -- XOR B, Lit
	'0'							when "0101011", -- XOR A, Dir
	'0'							when "0101100", -- XOR B, Dir
	'1'							when "0101101", -- XOR Dir
	'0'							when "0101110", -- NOT A
	'0'							when "0101111", -- NOT B, A
	'1'							when "0110000", -- NOT Dir, A
	'0'							when "0110001", -- SHL A
	'0'							when "0110010", -- SHL B, A
	'1'							when "0110011", -- SHL Dir, A
	'0'							when "0110100", -- SHR A
	'0'							when "0110101", -- SHR B, A
	'1'							when "0110110", -- SHR Dir, A
	'0'							when "0110111", -- INC A
	'0'							when "0111000", -- INC B
	'1'							when "0111001", -- INC Dir
	'0'							when "0111010", -- DEC A
	'0'							when "0111011", -- CMP A, B
	'0'							when "0111100", -- CMP A, Lit
	'0'							when "0111101", -- CMP A, Dir
	'1'							when "0111110", -- JMP Dir
	'1'							when "0111111", -- JEQ Dir
	'1'							when "1000000", -- JNE Dir
	'1'							when "1000001", -- JGT Dir
	'1'							when "1000010", -- JGE Dir
	'1'							when "1000011", -- JLT Dir
	'1'							when "1000100", -- JLE Dir
	'1'							when "1000101", -- JCR Dir
	'0'							when "1000110", -- NOP NOP
	'0'							when others;

with Opcode select IncSp <=
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
	'0'							when "0101010", -- XOR B, Lit
	'0'							when "0101011", -- XOR A, Dir
	'0'							when "0101100", -- XOR B, Dir
	'0'							when "0101101", -- XOR Dir
	'0'							when "0101110", -- NOT A
	'0'							when "0101111", -- NOT B, A
	'0'							when "0110000", -- NOT Dir, A
	'0'							when "0110001", -- SHL A
	'0'							when "0110010", -- SHL B, A
	'0'							when "0110011", -- SHL Dir, A
	'0'							when "0110100", -- SHR A
	'0'							when "0110101", -- SHR B, A
	'0'							when "0110110", -- SHR Dir, A
	'0'							when "0110111", -- INC A
	'0'							when "0111000", -- INC B
	'0'							when "0111001", -- INC Dir
	'0'							when "0111010", -- DEC A
	'0'							when "0111011", -- CMP A, B
	'0'							when "0111100", -- CMP A, Lit
	'0'							when "0111101", -- CMP A, Dir
	'0'							when "0111110", -- JMP Dir
	'0'							when "0111111", -- JEQ Dir
	'0'							when "1000000", -- JNE Dir
	'0'							when "1000001", -- JGT Dir
	'0'							when "1000010", -- JGE Dir
	'0'							when "1000011", -- JLT Dir
	'0'							when "1000100", -- JLE Dir
	'0'							when "1000101", -- JCR Dir
	'0'							when "1000110", -- NOP NOP
	'0'							when others;

with Opcode select DecSp <=
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
	'0'							when "0101010", -- XOR B, Lit
	'0'							when "0101011", -- XOR A, Dir
	'0'							when "0101100", -- XOR B, Dir
	'0'							when "0101101", -- XOR Dir
	'0'							when "0101110", -- NOT A
	'0'							when "0101111", -- NOT B, A
	'0'							when "0110000", -- NOT Dir, A
	'0'							when "0110001", -- SHL A
	'0'							when "0110010", -- SHL B, A
	'0'							when "0110011", -- SHL Dir, A
	'0'							when "0110100", -- SHR A
	'0'							when "0110101", -- SHR B, A
	'0'							when "0110110", -- SHR Dir, A
	'0'							when "0110111", -- INC A
	'0'							when "0111000", -- INC B
	'0'							when "0111001", -- INC Dir
	'0'							when "0111010", -- DEC A
	'0'							when "0111011", -- CMP A, B
	'0'							when "0111100", -- CMP A, Lit
	'0'							when "0111101", -- CMP A, Dir
	'0'							when "0111110", -- JMP Dir
	'0'							when "0111111", -- JEQ Dir
	'0'							when "1000000", -- JNE Dir
	'0'							when "1000001", -- JGT Dir
	'0'							when "1000010", -- JGE Dir
	'0'							when "1000011", -- JLT Dir
	'0'							when "1000100", -- JLE Dir
	'0'							when "1000101", -- JCR Dir
	'0'							when "1000110", -- NOP NOP
	'0'							when others;


end Behavioral;