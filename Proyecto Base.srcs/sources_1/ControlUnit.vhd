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
		DecSp	:	out	std_logic;						-- decrement stack pointer
		Lout	:	out std_logic 						-- load out data
	);
end ControlUnit;

architecture Behavioral of ControlUnit is

signal OutSignal : std_logic_vector(17 downto 0);

begin

LPC					<= OutSignal(17);
LA 					<= OutSignal(16);
LB 					<= OutSignal(15);
SA 					<= OutSignal(14 downto 13);
SB 					<= OutSignal(12 downto 11);
SL 					<= OutSignal(10 downto 8);
Sadd 				<= OutSignal(7 downto 6);
SDin 				<= OutSignal(5);
SPC 				<= OutSignal(4);
W 					<= OutSignal(3);
IncSp				<= OutSignal(2);
DecSp				<= OutSignal(1);
Lout 				<= OutSignal(0);

-- LPC LA LB SA SB SL  SAdd SDin SPC W IncSp DecSp loadOut
--  0   0  0  00 00 000 00    0    0  0  0     0	  0
with Opcode select OutSignal <=
	-- MOV
	"010010000000000000"						when "0000000", -- A, B
	"001000100000000000" 						when "0000001", -- B, A
	"010011000000000000" 						when "0000010", -- A, Lit
	"001011000000000000" 						when "0000011", -- B, Lit
	"010011100000000000" 						when "0000100", -- A, Dir
	"001011100000000000" 						when "0000101", -- B, Dir
	"000000100000001000" 						when "0000110", -- Dir, A
	"000010000000001000" 						when "0000111", -- Dir, B
	"010011100001000000" 						when "0001000", -- A, DirB
	"001011100001000000" 						when "0001001", -- B, DirB
	"000000100001001000" 						when "0001010", -- DirB, A
	"000011000001001000"	 					when "0001011", -- DirB, Lit

	-- ADD
	"010000000000000000" 						when "0001100", -- A, B
	"001000000000000000" 						when "0001101", -- B, A
	"010001000000000000" 						when "0001110", -- A,Lit
	"001001000000000000" 						when "0001111", -- B,Lit
	"010001100000000000" 						when "0010000", -- A,Dir
	"001001100000000000" 						when "0010001", -- B,Dir
	"000000000000001000"						when "0010010", -- Dir
	"010001100001000000" 						when "0010011", -- A,DirB
	"001001100001000000"		 				when "0010100", -- B,DirB 0010100
	
	-- SUB
	"010000000100000000" 						when "0010101", -- A,B
	"001000000100000000" 						when "0010110", -- B,A
	"010001000100000000" 						when "0010111", -- A,Lit
	"001001000100000000" 						when "0011000", -- B,Lit
	"010001100100000000" 						when "0011001", -- A,Dir 0011001
	"001001100100000000"						when "0011010", -- B,Dir 0011010
	"000000000100001000"						when "0011011", -- Dir 0011011
	"010001100101000000" 						when "0011100", -- A,DirB 0011100
	"001001100101000000" 						when "0011101", -- B,DirB 0011101

	-- AND
	"010000001000000000"						when "0011110", -- A, B
	"001000001000000000"						when "0011111", -- B, A
	"010001001000000000"						when "0100000", -- A, Lit
	"001001001000000000"						when "0100001", -- B, Lit
	"010001101000000000"						when "0100010", -- A, Dir
	"001001101000000000"						when "0100011", -- B, Dir
	"000000001000001000"						when "0100100", -- Dir
	"010001101001000000"						when "0100101", -- A, DirB
	"001001101001000000"						when "0100110", -- B, DirB

	-- OR
	"010000001100000000"						when "0100111", -- A, B
	"001000001100000000"						when "0101000", -- B, A
	"010001001100000000"						when "0101001", -- A, Lit
	"001001001100000000"						when "0101010", -- B, Lit
	"010001101100000000"						when "0101011", -- A, Dir
	"001001101100000000"						when "0101100", -- B, Dir
	"000000001100001000"						when "0101101", -- Dir										
	"010001101101000000"						when "0101110", -- A, DirB
	"001001101101000000"						when "0101111", -- B, DirB
	
	-- XOR
	"010000010000000000"						when "0110000", -- A, B
	"001000010000000000"						when "0110001", -- B, A
	"010001010000000000"						when "0110010", -- A, Lit
	"001001010000000000"						when "0110011", -- B, Lit
	"010001110000000000"						when "0110100", -- A, Dir
	"001001110000000000"						when "0110101", -- B, Dir
	"000000010000001000"						when "0110110", -- Dir
	"010001110001000000"						when "0110111", -- A, DirB
	"001001110001000000"						when "0111000", -- B, DirB

	-- NOT
	"010000010100000000"						when "0111001", -- A
	"001000010100000000"						when "0111010", -- B, A
	"000000010100001000"						when "0111011", -- Dir, A
	"000000010101001000"						when "0111100", -- DirB, A

	-- SHL
	"010000111100000000"						when "0111101", -- A
	"001000111100000000"						when "0111110", -- B, A
	"000000111100001000"						when "0111111", -- Dir, A
	"000000111101001000"						when "1000000", -- DirB, A
	
	-- SHR
	"010000111000000000"						when "1000001", -- A
	"001000111000000000"						when "1000010", -- B, A
	"000000111000001000"						when "1000011", -- Dir, A
	"000000111001001000"						when "1000100", -- DirB, A
	
	-- INC	
	"010001000000000000"						when "1000101", -- A
	"001100000000000000"						when "1000110", -- B
	"000101100000001000"						when "1000111", -- Dir
	"000101100001001000"						when "1001000", -- DirB
	
	"010001000100000000"						when "1001001", -- DEC A

	-- CMP
	"000000000100000000"						when "1001010", -- A, B
	"000001000100000000"						when "1001011", -- A, Lit
	"000001100100000000"						when "1001100", -- A, Dir
	"000001100101000000"						when "1001101", -- A, DirB

	-- PUSH
	"000000100010001010" 						when "1001110", -- A
	"000010000010001010" 						when "1001111", -- B

	-- POP(1)
	"000000000000000100" 						when "1100000", -- 

	-- POP(2)
	"010011100010000000" 						when "1010000", -- A
	"001011100010000000" 						when "1010001", -- B

	-- CALL
	"100000000010101010" 						when "1010010", -- Dir

	-- RET
	"000000000000000100" 						when "1100001", -- (1)
	"100000000010010000" 						when "1010011", -- (2)

	-- IN
	"010110100000000000" 						when "1010100", -- A
	"001110100000000000" 						when "1010101", -- B
	"000110100001001000"		 				when "1010110",	-- DirB

	-- OUT
	"000000000000000001"						when "1100010", -- A, B
	"000001100001000001"						when "1100011", -- A, DirB
	"000001100000000001"						when "1100100", -- A, Dir
	"000001000000000001"						when "1100101", -- A, Lit
	
	"100000000000000000"						when "1010111", -- JMP Dir
	(Z)	&					"00000000000000000"	when "1011000", -- JEQ Dir
	(not Z) &				"00000000000000000"	when "1011001", -- JNE Dir
	((not N) and (not Z)) &	"00000000000000000"	when "1011010", -- JGT Dir
	(not N) &				"00000000000000000"	when "1011011", -- JGE Dir
	N &						"00000000000000000"	when "1011100", -- JLT Dir
	(N xor Z) &				"00000000000000000"	when "1011101", -- JLE Dir
	C &						"00000000000000000"	when "1011110", -- JCR Dir
	"000000000000000000"						when "1011111", -- NOP NOP
	"000000000000000000"						when others;

end Behavioral;