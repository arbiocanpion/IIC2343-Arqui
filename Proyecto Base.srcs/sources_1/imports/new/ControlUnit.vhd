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
IncSp				<= OutSignal(1);
DecSp				<= OutSignal(0);			<= OutSignal(0);

-- LPC LA LB SA SB SL  SAdd SDin SPC W IncSp DecSp
--  0   0  0  00 00 000 00    0    0  0  0     0
with Opcode select OutSignal <=
	-- MOV
	"01001000000000000"							when "0000000", -- A, B
	"00100010000000000" 						when "0000001", -- B, A
	"01001100000000000" 						when "0000010", -- A, Lit
	"00101100000000000" 						when "0000011", -- B, Lit
	"01001110000000000" 						when "0000100", -- A, Dir
	"00101110000000000" 						when "0000101", -- B, Dir
	"00000010000000100" 						when "0000110", -- Dir, A
	"00001000000000100" 						when "0000111", -- Dir, B
	"01001110000100000" 						when "0001000", -- A, DirB
	"00101110000100000" 						when "0001001", -- B, DirB
	"00000010000100100" 						when "0001010", -- DirB, A
	"00001100000100100"	 						when "0001011", -- DirB, Lit

	-- ADD
	"01000000000000000" 						when "0001100", -- A, B
	"00100000000000000" 						when "0001101", -- B, A
	"01000100000000000" 						when "0001110", -- A,Lit
	"00100100000000000" 						when "0001111", -- B,Lit
	"01000110000000000" 						when "0010000", -- A,Dir
	"00100110000000000" 						when "0010001", -- B,Dir
	"00000000000000100"							when "0010010", -- Dir
	"01000110000100000" 						when "0010011", -- A,DirB
	"00100110000100000"		 					when "0010100", -- B,DirB 0010100
	
	-- SUB
	"01000000010000000" 						when "0010101", -- A,B
	"00100000010000000" 						when "0010110", -- B,A
	"01000100010000000" 						when "0010111", -- A,Lit
	"00100100010000000" 						when "0011000", -- B,Lit
	"01000110010000000" 						when "0011001", -- A,Dir 0011001
	"00100110010000000"							when "0011010", -- B,Dir 0011010
	"00000000010000100"							when "0011011", -- Dir 0011011
	"01000110010100000" 						when "0011100", -- A,DirB 0011100
	"00100110010100000" 						when "0011101", -- B,DirB 0011101

	-- AND
	"01000000100000000"							when "0011110", -- A, B
	"00100000100000000"							when "0011111", -- B, A
	"01000100100000000"							when "0100000", -- A, Lit
	"00100100100000000"							when "0100001", -- B, Lit
	"01000110100000000"							when "0100010", -- A, Dir
	"00100110100000000"							when "0100011", -- B, Dir
	"00000000100000100"							when "0100100", -- Dir
	"01000110100100000"							when "0100101", -- A, DirB
	"00100110100100000"							when "0100110", -- B, DirB

	-- OR
	"01000000110000000"							when "0100111", -- A, B
	"00100000110000000"							when "0101000", -- B, A
	"01000100110000000"							when "0101001", -- A, Lit
	"00100100110000000"							when "0101010", -- B, Lit
	"01000110110000000"							when "0101011", -- A, Dir
	"00100110110000000"							when "0101100", -- B, Dir
	"00000000110000100"							when "0101101", -- Dir										
	"01000110110100000"							when "0101110", -- A, DirB
	"00100110110100000"							when "0101111", -- B, DirB
	
	-- XOR
	"01000001000000000"							when "0110000", -- A, B
	"00100001000000000"							when "0110001", -- B, A
	"01000101000000000"							when "0110010", -- A, Lit
	"00100101000000000"							when "0110011", -- B, Lit
	"01000111000000000"							when "0110100", -- A, Dir
	"00100111000000000"							when "0110101", -- B, Dir
	"00000001000000100"							when "0110110", -- Dir
	"01000111000100000"							when "0110111", -- A, DirB
	"00100111000100000"							when "0111000", -- B, DirB

	-- NOT
	"01000001010000000"							when "0111001", -- A
	"00100001010000000"							when "0111010", -- B, A
	"00000001010000100"							when "0111011", -- Dir, A
	"00000001010100100"							when "0111100", -- DirB, A

	-- SHL
	"01000011110000000"							when "0111101", -- A
	"00100011110000000"							when "0111110", -- B, A
	"00000011110000100"							when "0111111", -- Dir, A
	"00000011110100100"							when "1000000", -- DirB, A
	
	-- SHR
	"01000011100000000"							when "1000001", -- A
	"00100011100000000"							when "1000010", -- B, A
	"00000011100000100"							when "1000011", -- Dir, A
	"00000011100100100"							when "1000100", -- DirB, A
	
	-- INC	
	"01000100000000000"							when "1000101", -- A
	"00110000000000000"							when "1000110", -- B
	"00010110000000100"							when "1000111", -- Dir
	"00010110000100100"							when "1001000", -- DirB
	
	"01000100010000000"							when "1001001", -- DEC A

	-- CMP
	"00000000010000000"							when "1001010", -- A, B
	"00000100010000000"							when "1001011", -- A, Lit
	"00000110010000000"							when "1001100", -- A, Dir
	"00000110010100000"							when "1001101", -- A, DirB

	-- PUSH
	"00000010001000101" 						when "1001110", -- A
	"00001000001000101" 						when "1001111", -- B

	-- POP(1)
	"00000000000000010" 						when "1100000", -- 

	-- POP(2)
	"01001110001000000" 						when "1010000", -- A
	"00101110001000000" 						when "1010001", -- B

	-- CALL
	"10000000001010101" 						when "1010010", -- Dir

	-- RET
	"00000000000000010" 						when "1100001", -- (1)
	"10000000001001000" 						when "1010011", -- (2)


	-- IN
	"01011010000000000" 						when "1010100", -- A
	"00111010000000000" 						when "1010101", -- B
	"00011010000100100"		 					when "1010110",	-- DirB
	
	
	"10000000000000000"							when "1010111", -- JMP Dir
	(Z)	&					"0000000000000000"	when "1011000", -- JEQ Dir
	(not Z) &				"0000000000000000"	when "1011001", -- JNE Dir
	((not N) and (not Z)) &	"0000000000000000"	when "1011010", -- JGT Dir
	(not N) &				"0000000000000000"	when "1011011", -- JGE Dir
	N &						"0000000000000000"	when "1011100", -- JLT Dir
	(N xor Z) &				"0000000000000000"	when "1011101", -- JLE Dir
	C &						"0000000000000000"	when "1011110", -- JCR Dir
	"00000000000000000"							when "1011111", -- NOP NOP
	"00000000000000000"							when others;

end Behavioral;