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

signal OutSignal : std_logic_vector(16 downto 0);

begin

LPC					<= OutSignal(16);
LA 					<= OutSignal(15);
LB 					<= OutSignal(14);
SA 					<= OutSignal(13 downto 12);
SB 					<= OutSignal(11 downto 10);
SL 					<= OutSignal(9 downto 7);
Sadd 				<= OutSignal(6 downto 5);
SDin 				<= OutSignal(4);
SPC 				<= OutSignal(3);
W 					<= OutSignal(2);
IncSp 				<= OutSignal(1);
DecSp 				<= OutSignal(0)



-- LPC LA LB SA SB SL  SAdd SDin SPC W IncSp DecSp
-- 0   0  0  00 00 000 00    0    0  0  0     0
with Opcode select OutSignal <=
	"01001000000000000"									when "0000000", -- MOV A, B
	"00100010000000000"									when "0000001", -- MOV B, A
	"01001100000000000"									when "0000010", -- MOV A, Lit
	"00101010000000000"									when "0000011", -- MOV B, Lit
	"01001110000000000"									when "0000100", -- MOV A, Dir
	"00101010000000000"									when "0000101", -- MOV B, Dir
	"00000010000000100"									when "0000110", -- MOV Dir, A
	"00001000000000100"									when "0000111", -- MOV Dir, B
	"01001110000100000"									when "0001000", -- MOV A, DirB
	"00101010000100000"									when "0001001", -- MOV B, DirB
	"00000010000100100"									when "0001010", -- MOV DirB, A
	"01000000000000000"									when "0001011", -- ADD A, B
	"00100000000000000"									when "0001100", -- ADD B, A
	"01000100000000000"									when "0001101", -- ADD A, Lit
	"00100100000000000"									when "0001110", -- ADD B, Lit
	"01000110000000000"									when "0001111", -- ADD A, Dir
	"00100110000000000"									when "0010000", -- ADD B, Dir
	"00000000000000100"									when "0010001", -- ADD Dir
	"01000000010000000"									when "0010010", -- SUB A, B
	"00100000010000000"									when "0010011", -- SUB B, A
	"01000100010000000"									when "0010100", -- SUB A, Lit
	"00100100010000000"									when "0010101", -- SUB B, Lit
	"01000110010000000"									when "0010110", -- SUB A, Dir
	"00100110010000000"									when "0010111", -- SUB B, Dir
	"00000000010000100"									when "0011000", -- SUB Dir
	"01000000100000000"									when "0011001", -- AND A, B
	"00100000100000000"									when "0011010", -- AND B, A
	"01000100100000000"									when "0011011", -- AND A, Lit
	"00100100100000000"									when "0011100", -- AND B, Lit
	"01000110100000000"									when "0011101", -- AND A, Dir
	"00100110100000000"									when "0011110", -- AND B, Dir
	"00000000100000100"									when "0011111", -- AND Dir
	"01000000110000000"									when "0100000", -- OR A, B
	"00100000110000000"									when "0100001", -- OR B, A
	"01000100110000000"									when "0100010", -- OR A, Lit
	"00100100110000000"									when "0100011", -- OR B, Lit
	"01000110110000000"									when "0100100", -- OR A, Dir
	"01100110110000000"									when "0100101", -- OR B, Dir
	"00000000110000100"									when "0100110", -- OR Dir
	"01000001000000000"									when "0100111", -- XOR A, B
	"00100001000000000"									when "0101000", -- XOR B, A
	"01000101000000000"									when "0101001", -- XOR A, Lit
	"00100101000000000"									when "0101010", -- XOR B, Lit
	"01000111000000000"									when "0101011", -- XOR A, Dir
	"00100111000000000"									when "0101100", -- XOR B, Dir
	"00000001000000100"									when "0101101", -- XOR Dir
	"01000001010000000"									when "0101110", -- NOT A
	"00100001010000000"									when "0101111", -- NOT B, A
	"00000001010000100"									when "0110000", -- NOT Dir, A
	"01000001110000000"									when "0110001", -- SHL A
	"00100001110000000"									when "0110010", -- SHL B, A
	"00000001110000100"									when "0110011", -- SHL Dir, A
	"01000001100000000"									when "0110100", -- SHR A
	"00100001100000000"									when "0110101", -- SHR B, A
	"00000001100000100"									when "0110110", -- SHR Dir, A
	"01000100000000000"									when "0110111", -- INC A
	"00110000000000000"									when "0111000", -- INC B
	"00010100000000100"									when "0111001", -- INC Dir
	"01000100010000000"									when "0111010", -- DEC A
	"01000000010000000"									when "0111011", -- CMP A, B
	"01000100010000000"									when "0111100", -- CMP A, Lit
	"01000110010000000"									when "0111101", -- CMP A, Dir
	"00000000000000100"									when "0111110", -- JMP Dir
	(Z and '1') &					"0000000000000000"	when "0111111", -- JEQ Dir
	(Z xor '1') &					"0000000000000000"	when "1000000", -- JNE Dir
	((N xor '1') and (Z xor '1')) &	"0000000000000000"	when "1000001", -- JGT Dir
	(N xor '0') &					"0000000000000000"	when "1000010", -- JGE Dir
	(N and '1') &					"0000000000000000"	when "1000011", -- JLT Dir
	((N and '1') or (Z and '1')) &	"0000000000000000"	when "1000100", -- JLE Dir
	(C and '1') &					"0000000000000100"	when "1000101", -- JCR Dir
	"00000000000000000"									when "1000110", -- NOP NOP
	"00000000000000000"									when others;


end Behavioral;