library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity ROM is

    Port (
        address : in std_logic_vector(11 downto 0);
        dataout : out std_logic_vector(32 downto 0)
    );

end ROM;

architecture Behavioral of ROM is

type memory_array is array (0 to ((2 ** 12) - 1) ) of std_logic_vector (32 downto 0);

signal memory : memory_array:= (
	"000000000100111000000000000000010",	-- instrucción 1 - Assembler.MovInstruction A, Lit
	"000000000000000000000000000000110",	-- instrucción 2 - Assembler.MovInstruction Dir, A
	"000000000110111100000000000000010",	-- instrucción 3 - Assembler.MovInstruction A, Lit
	"000000000000000100000000000000110",	-- instrucción 4 - Assembler.MovInstruction Dir, A
	"000000000110110100000000000000010",	-- instrucción 5 - Assembler.MovInstruction A, Lit
	"000000000000001000000000000000110",	-- instrucción 6 - Assembler.MovInstruction Dir, A
	"000000000110001000000000000000010",	-- instrucción 7 - Assembler.MovInstruction A, Lit
	"000000000000001100000000000000110",	-- instrucción 8 - Assembler.MovInstruction Dir, A
	"000000000111001000000000000000010",	-- instrucción 9 - Assembler.MovInstruction A, Lit
	"000000000000010000000000000000110",	-- instrucción 10 - Assembler.MovInstruction Dir, A
	"000000000110010100000000000000010",	-- instrucción 11 - Assembler.MovInstruction A, Lit
	"000000000000010100000000000000110",	-- instrucción 12 - Assembler.MovInstruction Dir, A
	"000000000101111100000000000000010",	-- instrucción 13 - Assembler.MovInstruction A, Lit
	"000000000000011000000000000000110",	-- instrucción 14 - Assembler.MovInstruction Dir, A
	"000000000100101000000000000000010",	-- instrucción 15 - Assembler.MovInstruction A, Lit
	"000000000000011100000000000000110",	-- instrucción 16 - Assembler.MovInstruction Dir, A
	"000000000111010100000000000000010",	-- instrucción 17 - Assembler.MovInstruction A, Lit
	"000000000000100000000000000000110",	-- instrucción 18 - Assembler.MovInstruction Dir, A
	"000000000110011100000000000000010",	-- instrucción 19 - Assembler.MovInstruction A, Lit
	"000000000000100100000000000000110",	-- instrucción 20 - Assembler.MovInstruction Dir, A
	"000000000110000100000000000000010",	-- instrucción 21 - Assembler.MovInstruction A, Lit
	"000000000000101000000000000000110",	-- instrucción 22 - Assembler.MovInstruction Dir, A
	"000000000110010000000000000000010",	-- instrucción 23 - Assembler.MovInstruction A, Lit
	"000000000000101100000000000000110",	-- instrucción 24 - Assembler.MovInstruction Dir, A
	"000000000110111100000000000000010",	-- instrucción 25 - Assembler.MovInstruction A, Lit
	"000000000000110000000000000000110",	-- instrucción 26 - Assembler.MovInstruction Dir, A
	"000000000111001000000000000000010",	-- instrucción 27 - Assembler.MovInstruction A, Lit
	"000000000000110100000000000000110",	-- instrucción 28 - Assembler.MovInstruction Dir, A
	"000000000101111100000000000000010",	-- instrucción 29 - Assembler.MovInstruction A, Lit
	"000000000000111000000000000000110",	-- instrucción 30 - Assembler.MovInstruction Dir, A
	"000000000011000100000000000000010",	-- instrucción 31 - Assembler.MovInstruction A, Lit
	"000000000000111100000000000000110",	-- instrucción 32 - Assembler.MovInstruction Dir, A
	"000000000100111000000000000000010",	-- instrucción 33 - Assembler.MovInstruction A, Lit
	"000000000001000000000000000000110",	-- instrucción 34 - Assembler.MovInstruction Dir, A
	"000000000110111100000000000000010",	-- instrucción 35 - Assembler.MovInstruction A, Lit
	"000000000001000100000000000000110",	-- instrucción 36 - Assembler.MovInstruction Dir, A
	"000000000110110100000000000000010",	-- instrucción 37 - Assembler.MovInstruction A, Lit
	"000000000001001000000000000000110",	-- instrucción 38 - Assembler.MovInstruction Dir, A
	"000000000110001000000000000000010",	-- instrucción 39 - Assembler.MovInstruction A, Lit
	"000000000001001100000000000000110",	-- instrucción 40 - Assembler.MovInstruction Dir, A
	"000000000111001000000000000000010",	-- instrucción 41 - Assembler.MovInstruction A, Lit
	"000000000001010000000000000000110",	-- instrucción 42 - Assembler.MovInstruction Dir, A
	"000000000110010100000000000000010",	-- instrucción 43 - Assembler.MovInstruction A, Lit
	"000000000001010100000000000000110",	-- instrucción 44 - Assembler.MovInstruction Dir, A
	"000000000101111100000000000000010",	-- instrucción 45 - Assembler.MovInstruction A, Lit
	"000000000001011000000000000000110",	-- instrucción 46 - Assembler.MovInstruction Dir, A
	"000000000100101000000000000000010",	-- instrucción 47 - Assembler.MovInstruction A, Lit
	"000000000001011100000000000000110",	-- instrucción 48 - Assembler.MovInstruction Dir, A
	"000000000111010100000000000000010",	-- instrucción 49 - Assembler.MovInstruction A, Lit
	"000000000001100000000000000000110",	-- instrucción 50 - Assembler.MovInstruction Dir, A
	"000000000110011100000000000000010",	-- instrucción 51 - Assembler.MovInstruction A, Lit
	"000000000001100100000000000000110",	-- instrucción 52 - Assembler.MovInstruction Dir, A
	"000000000110000100000000000000010",	-- instrucción 53 - Assembler.MovInstruction A, Lit
	"000000000001101000000000000000110",	-- instrucción 54 - Assembler.MovInstruction Dir, A
	"000000000110010000000000000000010",	-- instrucción 55 - Assembler.MovInstruction A, Lit
	"000000000001101100000000000000110",	-- instrucción 56 - Assembler.MovInstruction Dir, A
	"000000000110111100000000000000010",	-- instrucción 57 - Assembler.MovInstruction A, Lit
	"000000000001110000000000000000110",	-- instrucción 58 - Assembler.MovInstruction Dir, A
	"000000000111001000000000000000010",	-- instrucción 59 - Assembler.MovInstruction A, Lit
	"000000000001110100000000000000110",	-- instrucción 60 - Assembler.MovInstruction Dir, A
	"000000000101111100000000000000010",	-- instrucción 61 - Assembler.MovInstruction A, Lit
	"000000000001111000000000000000110",	-- instrucción 62 - Assembler.MovInstruction Dir, A
	"000000000011001000000000000000010",	-- instrucción 63 - Assembler.MovInstruction A, Lit
	"000000000001111100000000000000110",	-- instrucción 64 - Assembler.MovInstruction Dir, A
	"000000000000000000000000000000010",	-- instrucción 65 - Assembler.MovInstruction A, Lit
	"000000000010000000000000000000110",	-- instrucción 66 - Assembler.MovInstruction Dir, A
	"000000000000000000000000000000010",	-- instrucción 67 - Assembler.MovInstruction A, Lit
	"000000000010000100000000000000110",	-- instrucción 68 - Assembler.MovInstruction Dir, A
	"000000000100100100000000000000010",	-- instrucción 69 - Assembler.MovInstruction A, Lit
	"000000000010001000000000000000110",	-- instrucción 70 - Assembler.MovInstruction Dir, A
	"000000000110111000000000000000010",	-- instrucción 71 - Assembler.MovInstruction A, Lit
	"000000000010001100000000000000110",	-- instrucción 72 - Assembler.MovInstruction Dir, A
	"000000000110011100000000000000010",	-- instrucción 73 - Assembler.MovInstruction A, Lit
	"000000000010010000000000000000110",	-- instrucción 74 - Assembler.MovInstruction Dir, A
	"000000000111001000000000000000010",	-- instrucción 75 - Assembler.MovInstruction A, Lit
	"000000000010010100000000000000110",	-- instrucción 76 - Assembler.MovInstruction Dir, A
	"000000000110010100000000000000010",	-- instrucción 77 - Assembler.MovInstruction A, Lit
	"000000000010011000000000000000110",	-- instrucción 78 - Assembler.MovInstruction Dir, A
	"000000000111001100000000000000010",	-- instrucción 79 - Assembler.MovInstruction A, Lit
	"000000000010011100000000000000110",	-- instrucción 80 - Assembler.MovInstruction Dir, A
	"000000000110000100000000000000010",	-- instrucción 81 - Assembler.MovInstruction A, Lit
	"000000000010100000000000000000110",	-- instrucción 82 - Assembler.MovInstruction Dir, A
	"000000000100110000000000000000010",	-- instrucción 83 - Assembler.MovInstruction A, Lit
	"000000000010100100000000000000110",	-- instrucción 84 - Assembler.MovInstruction Dir, A
	"000000000110100100000000000000010",	-- instrucción 85 - Assembler.MovInstruction A, Lit
	"000000000010101000000000000000110",	-- instrucción 86 - Assembler.MovInstruction Dir, A
	"000000000110110100000000000000010",	-- instrucción 87 - Assembler.MovInstruction A, Lit
	"000000000010101100000000000000110",	-- instrucción 88 - Assembler.MovInstruction Dir, A
	"000000000111000000000000000000010",	-- instrucción 89 - Assembler.MovInstruction A, Lit
	"000000000010110000000000000000110",	-- instrucción 90 - Assembler.MovInstruction Dir, A
	"000000000110100100000000000000010",	-- instrucción 91 - Assembler.MovInstruction A, Lit
	"000000000010110100000000000000110",	-- instrucción 92 - Assembler.MovInstruction Dir, A
	"000000000110000100000000000000010",	-- instrucción 93 - Assembler.MovInstruction A, Lit
	"000000000010111000000000000000110",	-- instrucción 94 - Assembler.MovInstruction Dir, A
	"000000000100000100000000000000010",	-- instrucción 95 - Assembler.MovInstruction A, Lit
	"000000000010111100000000000000110",	-- instrucción 96 - Assembler.MovInstruction Dir, A
	"000000000110010000000000000000010",	-- instrucción 97 - Assembler.MovInstruction A, Lit
	"000000000011000000000000000000110",	-- instrucción 98 - Assembler.MovInstruction Dir, A
	"000000000110100100000000000000010",	-- instrucción 99 - Assembler.MovInstruction A, Lit
	"000000000011000100000000000000110",	-- instrucción 100 - Assembler.MovInstruction Dir, A
	"000000000111011000000000000000010",	-- instrucción 101 - Assembler.MovInstruction A, Lit
	"000000000011001000000000000000110",	-- instrucción 102 - Assembler.MovInstruction Dir, A
	"000000000110100100000000000000010",	-- instrucción 103 - Assembler.MovInstruction A, Lit
	"000000000011001100000000000000110",	-- instrucción 104 - Assembler.MovInstruction Dir, A
	"000000000110111000000000000000010",	-- instrucción 105 - Assembler.MovInstruction A, Lit
	"000000000011010000000000000000110",	-- instrucción 106 - Assembler.MovInstruction Dir, A
	"000000000110000100000000000000010",	-- instrucción 107 - Assembler.MovInstruction A, Lit
	"000000000011010100000000000000110",	-- instrucción 108 - Assembler.MovInstruction Dir, A
	"000000000100011100000000000000010",	-- instrucción 109 - Assembler.MovInstruction A, Lit
	"000000000011011000000000000000110",	-- instrucción 110 - Assembler.MovInstruction Dir, A
	"000000000110000100000000000000010",	-- instrucción 111 - Assembler.MovInstruction A, Lit
	"000000000011011100000000000000110",	-- instrucción 112 - Assembler.MovInstruction Dir, A
	"000000000110111000000000000000010",	-- instrucción 113 - Assembler.MovInstruction A, Lit
	"000000000011100000000000000000110",	-- instrucción 114 - Assembler.MovInstruction Dir, A
	"000000000110000100000000000000010",	-- instrucción 115 - Assembler.MovInstruction A, Lit
	"000000000011100100000000000000110",	-- instrucción 116 - Assembler.MovInstruction Dir, A
	"000000000101000000000000000000010",	-- instrucción 117 - Assembler.MovInstruction A, Lit
	"000000000011101000000000000000110",	-- instrucción 118 - Assembler.MovInstruction Dir, A
	"000000000110100100000000000000010",	-- instrucción 119 - Assembler.MovInstruction A, Lit
	"000000000011101100000000000000110",	-- instrucción 120 - Assembler.MovInstruction Dir, A
	"000000000110010100000000000000010",	-- instrucción 121 - Assembler.MovInstruction A, Lit
	"000000000011110000000000000000110",	-- instrucción 122 - Assembler.MovInstruction Dir, A
	"000000000111001000000000000000010",	-- instrucción 123 - Assembler.MovInstruction A, Lit
	"000000000011110100000000000000110",	-- instrucción 124 - Assembler.MovInstruction Dir, A
	"000000000110010000000000000000010",	-- instrucción 125 - Assembler.MovInstruction A, Lit
	"000000000011111000000000000000110",	-- instrucción 126 - Assembler.MovInstruction Dir, A
	"000000000110010100000000000000010",	-- instrucción 127 - Assembler.MovInstruction A, Lit
	"000000000011111100000000000000110",	-- instrucción 128 - Assembler.MovInstruction Dir, A
	"000000000110001100000000000000010",	-- instrucción 129 - Assembler.MovInstruction A, Lit
	"000000000100000000000000000000110",	-- instrucción 130 - Assembler.MovInstruction Dir, A
	"000000000110111100000000000000010",	-- instrucción 131 - Assembler.MovInstruction A, Lit
	"000000000100000100000000000000110",	-- instrucción 132 - Assembler.MovInstruction Dir, A
	"000000000110111000000000000000010",	-- instrucción 133 - Assembler.MovInstruction A, Lit
	"000000000100001000000000000000110",	-- instrucción 134 - Assembler.MovInstruction Dir, A
	"000000000111010000000000000000010",	-- instrucción 135 - Assembler.MovInstruction A, Lit
	"000000000100001100000000000000110",	-- instrucción 136 - Assembler.MovInstruction Dir, A
	"000000000110100100000000000000010",	-- instrucción 137 - Assembler.MovInstruction A, Lit
	"000000000100010000000000000000110",	-- instrucción 138 - Assembler.MovInstruction Dir, A
	"000000000110111000000000000000010",	-- instrucción 139 - Assembler.MovInstruction A, Lit
	"000000000100010100000000000000110",	-- instrucción 140 - Assembler.MovInstruction Dir, A
	"000000000111010100000000000000010",	-- instrucción 141 - Assembler.MovInstruction A, Lit
	"000000000100011000000000000000110",	-- instrucción 142 - Assembler.MovInstruction Dir, A
	"000000000110000100000000000000010",	-- instrucción 143 - Assembler.MovInstruction A, Lit
	"000000000100011100000000000000110",	-- instrucción 144 - Assembler.MovInstruction Dir, A
	"000000000111001000000000000000010",	-- instrucción 145 - Assembler.MovInstruction A, Lit
	"000000000100100000000000000000110",	-- instrucción 146 - Assembler.MovInstruction Dir, A
	"000000000010111000000000000000010",	-- instrucción 147 - Assembler.MovInstruction A, Lit
	"000000000100100100000000000000110",	-- instrucción 148 - Assembler.MovInstruction Dir, A
	"000000000010111000000000000000010",	-- instrucción 149 - Assembler.MovInstruction A, Lit
	"000000000100101000000000000000110",	-- instrucción 150 - Assembler.MovInstruction Dir, A
	"000000000010111000000000000000010",	-- instrucción 151 - Assembler.MovInstruction A, Lit
	"000000000100101100000000000000110",	-- instrucción 152 - Assembler.MovInstruction Dir, A
	"000000000011111100000000000000010",	-- instrucción 153 - Assembler.MovInstruction A, Lit
	"000000000100110000000000000000110",	-- instrucción 154 - Assembler.MovInstruction Dir, A
	"000000000011101000000000000000010",	-- instrucción 155 - Assembler.MovInstruction A, Lit
	"000000000100110100000000000000110",	-- instrucción 156 - Assembler.MovInstruction Dir, A
	"000000000101111100000000000000010",	-- instrucción 157 - Assembler.MovInstruction A, Lit
	"000000000100111000000000000000110",	-- instrucción 158 - Assembler.MovInstruction Dir, A
	"000000000000000000000000000000010",	-- instrucción 159 - Assembler.MovInstruction A, Lit
	"000000000100111100000000000000110",	-- instrucción 160 - Assembler.MovInstruction Dir, A
	"000000000100000100000000000000010",	-- instrucción 161 - Assembler.MovInstruction A, Lit
	"000000000101000000000000000000110",	-- instrucción 162 - Assembler.MovInstruction Dir, A
	"000000000100000100000000000000010",	-- instrucción 163 - Assembler.MovInstruction A, Lit
	"000000000101000100000000000000110",	-- instrucción 164 - Assembler.MovInstruction Dir, A
	"000000000100000100000000000000010",	-- instrucción 165 - Assembler.MovInstruction A, Lit
	"000000000101001000000000000000110",	-- instrucción 166 - Assembler.MovInstruction Dir, A
	"000000000100000100000000000000010",	-- instrucción 167 - Assembler.MovInstruction A, Lit
	"000000000101001100000000000000110",	-- instrucción 168 - Assembler.MovInstruction Dir, A
	"000000000100000100000000000000010",	-- instrucción 169 - Assembler.MovInstruction A, Lit
	"000000000101010000000000000000110",	-- instrucción 170 - Assembler.MovInstruction Dir, A
	"000000000100000100000000000000010",	-- instrucción 171 - Assembler.MovInstruction A, Lit
	"000000000101010100000000000000110",	-- instrucción 172 - Assembler.MovInstruction Dir, A
	"000000000100000100000000000000010",	-- instrucción 173 - Assembler.MovInstruction A, Lit
	"000000000101011000000000000000110",	-- instrucción 174 - Assembler.MovInstruction Dir, A
	"000000000100000100000000000000010",	-- instrucción 175 - Assembler.MovInstruction A, Lit
	"000000000101011100000000000000110",	-- instrucción 176 - Assembler.MovInstruction Dir, A
	"000000000000000000000000000000010",	-- instrucción 177 - Assembler.MovInstruction A, Lit
	"000000000101100000000000000000110",	-- instrucción 178 - Assembler.MovInstruction Dir, A
	"000000000011000000000000000000010",	-- instrucción 179 - Assembler.MovInstruction A, Lit
	"000000000101100100000000000000110",	-- instrucción 180 - Assembler.MovInstruction Dir, A
	"000000000011000000000000000000010",	-- instrucción 181 - Assembler.MovInstruction A, Lit
	"000000000101101000000000000000110",	-- instrucción 182 - Assembler.MovInstruction Dir, A
	"111111111111111100000000000000010",	-- instrucción 183 - Assembler.MovInstruction A, Lit
	"000000000101101100000000000000110",	-- instrucción 184 - Assembler.MovInstruction Dir, A
	"000000000000000100000000000000010",	-- instrucción 185 - Assembler.MovInstruction A, Lit
	"000000000101110000000000000000110",	-- instrucción 186 - Assembler.MovInstruction Dir, A
	"000000000000001000000000000000011",	-- instrucción 187 - Assembler.MovInstruction B, Lit
	"000000101110100100000000001010010",	-- instrucción 188 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000000000000001001110",	-- instrucción 189 - Assembler.Instructions.PushInstruction A, None
	"000000000000000000000000000000010",	-- instrucción 190 - Assembler.MovInstruction A, Lit
	"000000000101100100000000000000110",	-- instrucción 191 - Assembler.MovInstruction Dir, A
	"000000000101101000000000000000110",	-- instrucción 192 - Assembler.MovInstruction Dir, A
	"000000000101100000000000000000110",	-- instrucción 193 - Assembler.MovInstruction Dir, A
	"000000000000000100000000001100000",	-- instrucción 194 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 195 - Assembler.Instructions.Pop2Instruction A, None
	"000000001100110100000000001010010",	-- instrucción 196 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000000000000001001110",	-- instrucción 197 - Assembler.Instructions.PushInstruction A, None
	"000000000000000000000000000000010",	-- instrucción 198 - Assembler.MovInstruction A, Lit
	"000000000101100000000000000000110",	-- instrucción 199 - Assembler.MovInstruction Dir, A
	"000000000000000100000000001100000",	-- instrucción 200 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 201 - Assembler.Instructions.Pop2Instruction A, None
	"000000010000010000000000001010010",	-- instrucción 202 - Assembler.Instructions.CallInstruction Lit, None
	"000000010100111100000000001010010",	-- instrucción 203 - Assembler.Instructions.CallInstruction Lit, None
	"000000010110010100000000001010010",	-- instrucción 204 - Assembler.Instructions.CallInstruction Lit, None
	"000000011010000000000000001010111",	-- instrucción 205 - Assembler.Instructions.JmpInstruction Lit, None
	"000000101000110000000000001010010",	-- instrucción 206 - Assembler.Instructions.CallInstruction Lit, None
	"000000101001010100000000001010010",	-- instrucción 207 - Assembler.Instructions.CallInstruction Lit, None
	"000000011011100100000000001010010",	-- instrucción 208 - Assembler.Instructions.CallInstruction Lit, None
	"000000101001111000000000001010010",	-- instrucción 209 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000000000000000000010",	-- instrucción 210 - Assembler.MovInstruction A, Lit
	"000000101101100000000000001010010",	-- instrucción 211 - Assembler.Instructions.CallInstruction Lit, None
	"000000000101000000000000000000010",	-- instrucción 212 - Assembler.MovInstruction A, Lit
	"000000101010010100000000001010010",	-- instrucción 213 - Assembler.Instructions.CallInstruction Lit, None
	"000000101101100000000000001010010",	-- instrucción 214 - Assembler.Instructions.CallInstruction Lit, None
	"000000101010010100000000001010010",	-- instrucción 215 - Assembler.Instructions.CallInstruction Lit, None
	"000000011111111100000000001010010",	-- instrucción 216 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001001011",	-- instrucción 217 - Assembler.CmpInstruction A, Lit
	"000000010000001000000000001011000",	-- instrucción 218 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000000001000000000001001011",	-- instrucción 219 - Assembler.CmpInstruction A, Lit
	"000000001111000100000000001011000",	-- instrucción 220 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000000010000000000001001011",	-- instrucción 221 - Assembler.CmpInstruction A, Lit
	"000000001110011100000000001011000",	-- instrucción 222 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000000100000000000001001011",	-- instrucción 223 - Assembler.CmpInstruction A, Lit
	"000000001110001000000000001011000",	-- instrucción 224 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000001000000000000001001011",	-- instrucción 225 - Assembler.CmpInstruction A, Lit
	"000000001111011100000000001011000",	-- instrucción 226 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000101000000000000000000010",	-- instrucción 227 - Assembler.MovInstruction A, Lit
	"000000000101100000000000000010000",	-- instrucción 228 - Assembler.AddInstruction A, Dir
	"000000000000000000000000000000001",	-- instrucción 229 - Assembler.MovInstruction B, A
	"000000000000000000000000001001000",	-- instrucción 230 - Assembler.IncInstruction DirB, Lit
	"000000001100110100000000001010111",	-- instrucción 231 - Assembler.Instructions.JmpInstruction Lit, None
	"000000000101000000000000000000010",	-- instrucción 232 - Assembler.MovInstruction A, Lit
	"000000000101100000000000000010000",	-- instrucción 233 - Assembler.AddInstruction A, Dir
	"000000000000000000000000000000001",	-- instrucción 234 - Assembler.MovInstruction B, A
	"000000000000000000000000001001110",	-- instrucción 235 - Assembler.Instructions.PushInstruction A, None
	"000000000000000000000000000001000",	-- instrucción 236 - Assembler.MovInstruction A, DirB
	"000000000000000100000000001001001",	-- instrucción 237 - Assembler.Instructions.DecInstruction A, Lit
	"000000000000000000000000000001010",	-- instrucción 238 - Assembler.MovInstruction DirB, A
	"000000000000000100000000001100000",	-- instrucción 239 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 240 - Assembler.Instructions.Pop2Instruction A, None
	"000000001100110100000000001010111",	-- instrucción 241 - Assembler.Instructions.JmpInstruction Lit, None
	"000000000101100000000000000000100",	-- instrucción 242 - Assembler.MovInstruction A, Dir
	"000000000000001100000000001001011",	-- instrucción 243 - Assembler.CmpInstruction A, Lit
	"000000001111011000000000001011000",	-- instrucción 244 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000101100000000000001000111",	-- instrucción 245 - Assembler.IncInstruction Dir, Lit
	"000000101101000100000000001010010",	-- instrucción 246 - Assembler.Instructions.CallInstruction Lit, None
	"000000001100110100000000001010111",	-- instrucción 247 - Assembler.Instructions.JmpInstruction Lit, None
	"000000000101100000000000000000100",	-- instrucción 248 - Assembler.MovInstruction A, Dir
	"000000000000000000000000001001011",	-- instrucción 249 - Assembler.CmpInstruction A, Lit
	"000000010000000100000000001011000",	-- instrucción 250 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000000000000000000001001110",	-- instrucción 251 - Assembler.Instructions.PushInstruction A, None
	"000000000101100000000000000000100",	-- instrucción 252 - Assembler.MovInstruction A, Dir
	"000000000000000100000000001001001",	-- instrucción 253 - Assembler.Instructions.DecInstruction A, Lit
	"000000101100101000000000001010010",	-- instrucción 254 - Assembler.Instructions.CallInstruction Lit, None
	"000000000101100000000000000000110",	-- instrucción 255 - Assembler.MovInstruction Dir, A
	"000000000000000100000000001100000",	-- instrucción 256 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 257 - Assembler.Instructions.Pop2Instruction A, None
	"000000001100110100000000001010111",	-- instrucción 258 - Assembler.Instructions.JmpInstruction Lit, None
	"000000000000000100000000001100001",	-- instrucción 259 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 260 - Assembler.Instructions.Ret2Instruction None, None
	"000000101000110000000000001010010",	-- instrucción 261 - Assembler.Instructions.CallInstruction Lit, None
	"000000101001010100000000001010010",	-- instrucción 262 - Assembler.Instructions.CallInstruction Lit, None
	"000000011011100100000000001010010",	-- instrucción 263 - Assembler.Instructions.CallInstruction Lit, None
	"000000000001000000000000000000010",	-- instrucción 264 - Assembler.MovInstruction A, Lit
	"000000101001111000000000001010010",	-- instrucción 265 - Assembler.Instructions.CallInstruction Lit, None
	"000000101101100000000000001010010",	-- instrucción 266 - Assembler.Instructions.CallInstruction Lit, None
	"000000000101010000000000000000010",	-- instrucción 267 - Assembler.MovInstruction A, Lit
	"000000101010010100000000001010010",	-- instrucción 268 - Assembler.Instructions.CallInstruction Lit, None
	"000000101101100000000000001010010",	-- instrucción 269 - Assembler.Instructions.CallInstruction Lit, None
	"000000011111111100000000001010010",	-- instrucción 270 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001001011",	-- instrucción 271 - Assembler.CmpInstruction A, Lit
	"000000010011011000000000001011000",	-- instrucción 272 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000000001000000000001001011",	-- instrucción 273 - Assembler.CmpInstruction A, Lit
	"000000010010011100000000001011000",	-- instrucción 274 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000000010000000000001001011",	-- instrucción 275 - Assembler.CmpInstruction A, Lit
	"000000010001110100000000001011000",	-- instrucción 276 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000000100000000000001001011",	-- instrucción 277 - Assembler.CmpInstruction A, Lit
	"000000010001100000000000001011000",	-- instrucción 278 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000001000000000000001001011",	-- instrucción 279 - Assembler.CmpInstruction A, Lit
	"000000010010110000000000001011000",	-- instrucción 280 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000101010000000000000000010",	-- instrucción 281 - Assembler.MovInstruction A, Lit
	"000000000101100000000000000010000",	-- instrucción 282 - Assembler.AddInstruction A, Dir
	"000000000000000000000000000000001",	-- instrucción 283 - Assembler.MovInstruction B, A
	"000000000000000000000000001001000",	-- instrucción 284 - Assembler.IncInstruction DirB, Lit
	"000000010000010000000000001010111",	-- instrucción 285 - Assembler.Instructions.JmpInstruction Lit, None
	"000000000101010000000000000000010",	-- instrucción 286 - Assembler.MovInstruction A, Lit
	"000000000101100000000000000010000",	-- instrucción 287 - Assembler.AddInstruction A, Dir
	"000000000000000000000000000000001",	-- instrucción 288 - Assembler.MovInstruction B, A
	"000000000000000000000000001001110",	-- instrucción 289 - Assembler.Instructions.PushInstruction A, None
	"000000000000000000000000000001000",	-- instrucción 290 - Assembler.MovInstruction A, DirB
	"000000000000000100000000001001001",	-- instrucción 291 - Assembler.Instructions.DecInstruction A, Lit
	"000000000000000000000000000001010",	-- instrucción 292 - Assembler.MovInstruction DirB, A
	"000000000000000100000000001100000",	-- instrucción 293 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 294 - Assembler.Instructions.Pop2Instruction A, None
	"000000010000010000000000001010111",	-- instrucción 295 - Assembler.Instructions.JmpInstruction Lit, None
	"000000000101100000000000000000100",	-- instrucción 296 - Assembler.MovInstruction A, Dir
	"000000000000001100000000001001011",	-- instrucción 297 - Assembler.CmpInstruction A, Lit
	"000000010010101100000000001011000",	-- instrucción 298 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000101100000000000001000111",	-- instrucción 299 - Assembler.IncInstruction Dir, Lit
	"000000010000010000000000001010111",	-- instrucción 300 - Assembler.Instructions.JmpInstruction Lit, None
	"000000000101100000000000000000100",	-- instrucción 301 - Assembler.MovInstruction A, Dir
	"000000000000000000000000001001011",	-- instrucción 302 - Assembler.CmpInstruction A, Lit
	"000000010011010100000000001011000",	-- instrucción 303 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000000000000000000001001110",	-- instrucción 304 - Assembler.Instructions.PushInstruction A, None
	"000000000101100000000000000000100",	-- instrucción 305 - Assembler.MovInstruction A, Dir
	"000000000000000100000000001001001",	-- instrucción 306 - Assembler.Instructions.DecInstruction A, Lit
	"000000000101100000000000000000110",	-- instrucción 307 - Assembler.MovInstruction Dir, A
	"000000000000000100000000001100000",	-- instrucción 308 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 309 - Assembler.Instructions.Pop2Instruction A, None
	"000000010000010000000000001010111",	-- instrucción 310 - Assembler.Instructions.JmpInstruction Lit, None
	"000000000000000100000000001100001",	-- instrucción 311 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 312 - Assembler.Instructions.Ret2Instruction None, None
	"000000101000110000000000001010010",	-- instrucción 313 - Assembler.Instructions.CallInstruction Lit, None
	"000000101001010100000000001010010",	-- instrucción 314 - Assembler.Instructions.CallInstruction Lit, None
	"000000101001111000000000001010010",	-- instrucción 315 - Assembler.Instructions.CallInstruction Lit, None
	"000000000101000000000000000000010",	-- instrucción 316 - Assembler.MovInstruction A, Lit
	"000000101101100000000000001010010",	-- instrucción 317 - Assembler.Instructions.CallInstruction Lit, None
	"000000000100110100000000000000010",	-- instrucción 318 - Assembler.MovInstruction A, Lit
	"000000101101100000000000001010010",	-- instrucción 319 - Assembler.Instructions.CallInstruction Lit, None
	"000000000100111000000000000000010",	-- instrucción 320 - Assembler.MovInstruction A, Lit
	"000000101101100000000000001010010",	-- instrucción 321 - Assembler.Instructions.CallInstruction Lit, None
	"000000000101100100000000000000010",	-- instrucción 322 - Assembler.MovInstruction A, Lit
	"000000101101100000000000001010010",	-- instrucción 323 - Assembler.Instructions.CallInstruction Lit, None
	"000000000100111000000000000000010",	-- instrucción 324 - Assembler.MovInstruction A, Lit
	"000000101101100000000000001010010",	-- instrucción 325 - Assembler.Instructions.CallInstruction Lit, None
	"000000000101010000000000000000010",	-- instrucción 326 - Assembler.MovInstruction A, Lit
	"000000101101100000000000001010010",	-- instrucción 327 - Assembler.Instructions.CallInstruction Lit, None
	"000000000100110100000000000000010",	-- instrucción 328 - Assembler.MovInstruction A, Lit
	"000000101101100000000000001010010",	-- instrucción 329 - Assembler.Instructions.CallInstruction Lit, None
	"000000000100111000000000000000010",	-- instrucción 330 - Assembler.MovInstruction A, Lit
	"000000101101100000000000001010010",	-- instrucción 331 - Assembler.Instructions.CallInstruction Lit, None
	"000000000101101000000000000000010",	-- instrucción 332 - Assembler.MovInstruction A, Lit
	"000000101101100000000000001010010",	-- instrucción 333 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001100001",	-- instrucción 334 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 335 - Assembler.Instructions.Ret2Instruction None, None
	"000000000010000000000000000000100",	-- instrucción 336 - Assembler.MovInstruction A, Dir
	"000000000000000000000000001001011",	-- instrucción 337 - Assembler.CmpInstruction A, Lit
	"000000010101010000000000001011000",	-- instrucción 338 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000101010000000000000000100",	-- instrucción 339 - Assembler.MovInstruction A, Dir
	"000000010101010100000000001010111",	-- instrucción 340 - Assembler.Instructions.JmpInstruction Lit, None
	"000000000101000000000000000000100",	-- instrucción 341 - Assembler.MovInstruction A, Dir
	"000000101010010100000000001010010",	-- instrucción 342 - Assembler.Instructions.CallInstruction Lit, None
	"000000101101100000000000001010010",	-- instrucción 343 - Assembler.Instructions.CallInstruction Lit, None
	"000000000100110100000000000000010",	-- instrucción 344 - Assembler.MovInstruction A, Lit
	"000000101101100000000000001010010",	-- instrucción 345 - Assembler.Instructions.CallInstruction Lit, None
	"000000000100111000000000000000010",	-- instrucción 346 - Assembler.MovInstruction A, Lit
	"000000101101100000000000001010010",	-- instrucción 347 - Assembler.Instructions.CallInstruction Lit, None
	"000000000010001000000000000000010",	-- instrucción 348 - Assembler.MovInstruction A, Lit
	"000000101101100000000000001010010",	-- instrucción 349 - Assembler.Instructions.CallInstruction Lit, None
	"000000011111111100000000001010010",	-- instrucción 350 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001001011",	-- instrucción 351 - Assembler.CmpInstruction A, Lit
	"000000010110000100000000001011000",	-- instrucción 352 - Assembler.Instructions.JeqInstruction Lit, None
	"000000010101110100000000001010111",	-- instrucción 353 - Assembler.Instructions.JmpInstruction Lit, None
	"000000000000000000000000001010100",	-- instrucción 354 - Assembler.Instructions.InInstruction A, Lit
	"000000000100111100000000000000110",	-- instrucción 355 - Assembler.MovInstruction Dir, A
	"000000000000000100000000001100001",	-- instrucción 356 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 357 - Assembler.Instructions.Ret2Instruction None, None
	"000000000010000000000000000000100",	-- instrucción 358 - Assembler.MovInstruction A, Dir
	"000000000000000000000000001001011",	-- instrucción 359 - Assembler.CmpInstruction A, Lit
	"000000010110101000000000001011000",	-- instrucción 360 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000101010000000000000000100",	-- instrucción 361 - Assembler.MovInstruction A, Dir
	"000000010110101100000000001010111",	-- instrucción 362 - Assembler.Instructions.JmpInstruction Lit, None
	"000000000101000000000000000000100",	-- instrucción 363 - Assembler.MovInstruction A, Dir
	"000000101001010100000000001010010",	-- instrucción 364 - Assembler.Instructions.CallInstruction Lit, None
	"000000101010010100000000001010010",	-- instrucción 365 - Assembler.Instructions.CallInstruction Lit, None
	"000000101101100000000000001010010",	-- instrucción 366 - Assembler.Instructions.CallInstruction Lit, None
	"000000000100110100000000000000010",	-- instrucción 367 - Assembler.MovInstruction A, Lit
	"000000101101100000000000001010010",	-- instrucción 368 - Assembler.Instructions.CallInstruction Lit, None
	"000000000100111000000000000000010",	-- instrucción 369 - Assembler.MovInstruction A, Lit
	"000000101101100000000000001010010",	-- instrucción 370 - Assembler.Instructions.CallInstruction Lit, None
	"000000000010001000000000000000010",	-- instrucción 371 - Assembler.MovInstruction A, Lit
	"000000101101100000000000001010010",	-- instrucción 372 - Assembler.Instructions.CallInstruction Lit, None
	"000000011111111100000000001010010",	-- instrucción 373 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001100001",	-- instrucción 374 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 375 - Assembler.Instructions.Ret2Instruction None, None
	"000000101000110000000000001010010",	-- instrucción 376 - Assembler.Instructions.CallInstruction Lit, None
	"000000010011100000000000001010010",	-- instrucción 377 - Assembler.Instructions.CallInstruction Lit, None
	"000000101001010100000000001010010",	-- instrucción 378 - Assembler.Instructions.CallInstruction Lit, None
	"000000010111011100000000000000010",	-- instrucción 379 - Assembler.MovInstruction A, Lit
	"000000101010010100000000001010010",	-- instrucción 380 - Assembler.Instructions.CallInstruction Lit, None
	"000000011111111100000000001010010",	-- instrucción 381 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001001011",	-- instrucción 382 - Assembler.CmpInstruction A, Lit
	"000000011100001100000000001011000",	-- instrucción 383 - Assembler.Instructions.JeqInstruction Lit, None
	"000000001011110000000000001010111",	-- instrucción 384 - Assembler.Instructions.JmpInstruction Lit, None
	"000000000010000000000000000000100",	-- instrucción 385 - Assembler.MovInstruction A, Dir
	"000000000000000000000000001001011",	-- instrucción 386 - Assembler.CmpInstruction A, Lit
	"000000011000011000000000001011000",	-- instrucción 387 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000101101000000000001000111",	-- instrucción 388 - Assembler.IncInstruction Dir, Lit
	"000000000101010000000000000000100",	-- instrucción 389 - Assembler.MovInstruction A, Dir
	"000000011000100000000000001010111",	-- instrucción 390 - Assembler.Instructions.JmpInstruction Lit, None
	"000000000101101000000000001000111",	-- instrucción 391 - Assembler.IncInstruction Dir, Lit
	"000000000101000000000000000000100",	-- instrucción 392 - Assembler.MovInstruction A, Dir
	"000000101001010100000000001010010",	-- instrucción 393 - Assembler.Instructions.CallInstruction Lit, None
	"000000101010010100000000001010010",	-- instrucción 394 - Assembler.Instructions.CallInstruction Lit, None
	"000000000100111000000000000000100",	-- instrucción 395 - Assembler.MovInstruction A, Dir
	"000000101101100000000000001010010",	-- instrucción 396 - Assembler.Instructions.CallInstruction Lit, None
	"000000000011011000000000000000100",	-- instrucción 397 - Assembler.MovInstruction A, Dir
	"000000101101100000000000001010010",	-- instrucción 398 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001100001",	-- instrucción 399 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 400 - Assembler.Instructions.Ret2Instruction None, None
	"000000000010000000000000000000100",	-- instrucción 401 - Assembler.MovInstruction A, Dir
	"000000000000000000000000001001011",	-- instrucción 402 - Assembler.CmpInstruction A, Lit
	"000000011001011000000000001011000",	-- instrucción 403 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000101100100000000001000111",	-- instrucción 404 - Assembler.IncInstruction Dir, Lit
	"000000000101010000000000000000100",	-- instrucción 405 - Assembler.MovInstruction A, Dir
	"000000011001100000000000001010111",	-- instrucción 406 - Assembler.Instructions.JmpInstruction Lit, None
	"000000000101101000000000001000111",	-- instrucción 407 - Assembler.IncInstruction Dir, Lit
	"000000000101000000000000000000100",	-- instrucción 408 - Assembler.MovInstruction A, Dir
	"000000101001010100000000001010010",	-- instrucción 409 - Assembler.Instructions.CallInstruction Lit, None
	"000000101010010100000000001010010",	-- instrucción 410 - Assembler.Instructions.CallInstruction Lit, None
	"000000000100111000000000000000100",	-- instrucción 411 - Assembler.MovInstruction A, Dir
	"000000101101100000000000001010010",	-- instrucción 412 - Assembler.Instructions.CallInstruction Lit, None
	"000000000011101000000000000000100",	-- instrucción 413 - Assembler.MovInstruction A, Dir
	"000000101101100000000000001010010",	-- instrucción 414 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001100001",	-- instrucción 415 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 416 - Assembler.Instructions.Ret2Instruction None, None
	"000000010011100000000000001010010",	-- instrucción 417 - Assembler.Instructions.CallInstruction Lit, None
	"000000101010010100000000001010010",	-- instrucción 418 - Assembler.Instructions.CallInstruction Lit, None
	"000000011010100000000000001010010",	-- instrucción 419 - Assembler.Instructions.CallInstruction Lit, None
	"000000000100111000000000000000010",	-- instrucción 420 - Assembler.MovInstruction A, Lit
	"000000101000010100000000001010010",	-- instrucción 421 - Assembler.Instructions.CallInstruction Lit, None
	"000000000010111100000000000000010",	-- instrucción 422 - Assembler.MovInstruction A, Lit
	"000000101101100000000000001010010",	-- instrucción 423 - Assembler.Instructions.CallInstruction Lit, None
	"000000011100001100000000001010111",	-- instrucción 424 - Assembler.Instructions.JmpInstruction Lit, None
	"000000000010000000000000000000010",	-- instrucción 425 - Assembler.MovInstruction A, Lit
	"000000000000000000000000001001011",	-- instrucción 426 - Assembler.CmpInstruction A, Lit
	"000000011010111100000000001011000",	-- instrucción 427 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000101010000000000000000010",	-- instrucción 428 - Assembler.MovInstruction A, Lit
	"000000101101100000000000001010010",	-- instrucción 429 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001100001",	-- instrucción 430 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 431 - Assembler.Instructions.Ret2Instruction None, None
	"000000000101000000000000000000010",	-- instrucción 432 - Assembler.MovInstruction A, Lit
	"000000101101100000000000001010010",	-- instrucción 433 - Assembler.Instructions.CallInstruction Lit, None
	"000000011011010000000000001010010",	-- instrucción 434 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001100001",	-- instrucción 435 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 436 - Assembler.Instructions.Ret2Instruction None, None
	"000000000010000000000000000000100",	-- instrucción 437 - Assembler.MovInstruction A, Dir
	"000000000000000000000000000111001",	-- instrucción 438 - Assembler.NotInstruction A, None
	"000000000010000000000000000000110",	-- instrucción 439 - Assembler.MovInstruction Dir, A
	"000000000000000100000000001100001",	-- instrucción 440 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 441 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000000000000000000010",	-- instrucción 442 - Assembler.MovInstruction A, Lit
	"000000000010000100000000000000110",	-- instrucción 443 - Assembler.MovInstruction Dir, A
	"000000000101100000000000000000100",	-- instrucción 444 - Assembler.MovInstruction A, Dir
	"000000000010000100000000001001011",	-- instrucción 445 - Assembler.CmpInstruction A, Lit
	"000000011100000000000000001011010",	-- instrucción 446 - Assembler.Instructions.JgtInstruction Lit, None
	"000000000000000100000000001100001",	-- instrucción 447 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 448 - Assembler.Instructions.Ret2Instruction None, None
	"000000101101000100000000001010010",	-- instrucción 449 - Assembler.Instructions.CallInstruction Lit, None
	"000000000010000100000000001000111",	-- instrucción 450 - Assembler.IncInstruction Dir, Lit
	"000000011011101100000000001010111",	-- instrucción 451 - Assembler.Instructions.JmpInstruction Lit, None
	"000000011110101100000000001010010",	-- instrucción 452 - Assembler.Instructions.CallInstruction Lit, None
	"000000000101101100000000000000100",	-- instrucción 453 - Assembler.MovInstruction A, Dir
	"000000000000000000000000001001011",	-- instrucción 454 - Assembler.CmpInstruction A, Lit
	"000000011001000000000000001011000",	-- instrucción 455 - Assembler.Instructions.JeqInstruction Lit, None
	"000000011111111100000000001010010",	-- instrucción 456 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000000000000000000001",	-- instrucción 457 - Assembler.MovInstruction B, A
	"000000000000000000000000001010100",	-- instrucción 458 - Assembler.Instructions.InInstruction A, Lit
	"000000000100111100000000001001100",	-- instrucción 459 - Assembler.CmpInstruction A, Dir
	"000000011000000000000000001011000",	-- instrucción 460 - Assembler.Instructions.JeqInstruction Lit, None
	"000000011111101000000000001010010",	-- instrucción 461 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001001011",	-- instrucción 462 - Assembler.CmpInstruction A, Lit
	"000000011101011100000000001011000",	-- instrucción 463 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000000001000000000001001011",	-- instrucción 464 - Assembler.CmpInstruction A, Lit
	"000000011101101100000000001011000",	-- instrucción 465 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000000010000000000001001011",	-- instrucción 466 - Assembler.CmpInstruction A, Lit
	"000000011101111100000000001011000",	-- instrucción 467 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000000100000000000001001011",	-- instrucción 468 - Assembler.CmpInstruction A, Lit
	"000000011110001100000000001011000",	-- instrucción 469 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000001000000000000001001011",	-- instrucción 470 - Assembler.CmpInstruction A, Lit
	"000000011110011100000000001011000",	-- instrucción 471 - Assembler.Instructions.JeqInstruction Lit, None
	"000000011111101000000000001010010",	-- instrucción 472 - Assembler.Instructions.CallInstruction Lit, None
	"000000000100111100000000000100010",	-- instrucción 473 - Assembler.AndInstruction A, Dir
	"000000011111001000000000001010010",	-- instrucción 474 - Assembler.Instructions.CallInstruction Lit, None
	"000000011100001100000000001010111",	-- instrucción 475 - Assembler.Instructions.JmpInstruction Lit, None
	"000000011111101000000000001010010",	-- instrucción 476 - Assembler.Instructions.CallInstruction Lit, None
	"000000000100111100000000000010000",	-- instrucción 477 - Assembler.AddInstruction A, Dir
	"000000011111001000000000001010010",	-- instrucción 478 - Assembler.Instructions.CallInstruction Lit, None
	"000000011100001100000000001010111",	-- instrucción 479 - Assembler.Instructions.JmpInstruction Lit, None
	"000000011111101000000000001010010",	-- instrucción 480 - Assembler.Instructions.CallInstruction Lit, None
	"000000000100111100000000000101011",	-- instrucción 481 - Assembler.OrInstruction A, Dir
	"000000011111001000000000001010010",	-- instrucción 482 - Assembler.Instructions.CallInstruction Lit, None
	"000000011100001100000000001010111",	-- instrucción 483 - Assembler.Instructions.JmpInstruction Lit, None
	"000000011111101000000000001010010",	-- instrucción 484 - Assembler.Instructions.CallInstruction Lit, None
	"000000000100111100000000000110100",	-- instrucción 485 - Assembler.XorInstruction A, Dir
	"000000011111001000000000001010010",	-- instrucción 486 - Assembler.Instructions.CallInstruction Lit, None
	"000000011100001100000000001010111",	-- instrucción 487 - Assembler.Instructions.JmpInstruction Lit, None
	"000000011111101000000000001010010",	-- instrucción 488 - Assembler.Instructions.CallInstruction Lit, None
	"000000000100111100000000000011001",	-- instrucción 489 - Assembler.SubInstruction A, Dir
	"000000011111001000000000001010010",	-- instrucción 490 - Assembler.Instructions.CallInstruction Lit, None
	"000000011100001100000000001010111",	-- instrucción 491 - Assembler.Instructions.JmpInstruction Lit, None
	"000000000000000000000000001001110",	-- instrucción 492 - Assembler.Instructions.PushInstruction A, None
	"000000000101101100000000000000100",	-- instrucción 493 - Assembler.MovInstruction A, Dir
	"000000000000000100000000001100101",	-- instrucción 494 - Assembler.Instructions.OutInstruction A, Lit
	"000000000000000100000000001100000",	-- instrucción 495 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 496 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000100000000001100001",	-- instrucción 497 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 498 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000000000000001001110",	-- instrucción 499 - Assembler.Instructions.PushInstruction A, None
	"000000000101101100000000000000100",	-- instrucción 500 - Assembler.MovInstruction A, Dir
	"000000000000000000000000000111101",	-- instrucción 501 - Assembler.ShlInstruction A, None
	"000000000101101100000000000000110",	-- instrucción 502 - Assembler.MovInstruction Dir, A
	"000000000000000100000000001100000",	-- instrucción 503 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 504 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000100000000001100001",	-- instrucción 505 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 506 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000000000000000110000",	-- instrucción 507 - Assembler.XorInstruction A, B
	"000000000000000000000000000110001",	-- instrucción 508 - Assembler.XorInstruction B, A
	"000000000000000000000000000110000",	-- instrucción 509 - Assembler.XorInstruction A, B
	"000000000000000100000000001100001",	-- instrucción 510 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 511 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000000000000001001111",	-- instrucción 512 - Assembler.Instructions.PushInstruction B, None
	"000000000000000100000000001010100",	-- instrucción 513 - Assembler.Instructions.InInstruction A, Lit
	"000000000000000100000000001010101",	-- instrucción 514 - Assembler.Instructions.InInstruction B, Lit
	"000000000000000000000000001001010",	-- instrucción 515 - Assembler.CmpInstruction A, B
	"000000100000000100000000001011000",	-- instrucción 516 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000000000000000000000110001",	-- instrucción 517 - Assembler.XorInstruction B, A
	"000000000000000100000000001010100",	-- instrucción 518 - Assembler.Instructions.InInstruction A, Lit
	"000000000000000000000000000011110",	-- instrucción 519 - Assembler.AndInstruction A, B
	"000000000000000000000000001001011",	-- instrucción 520 - Assembler.CmpInstruction A, Lit
	"000000100000010100000000001011001",	-- instrucción 521 - Assembler.Instructions.JneInstruction Lit, None
	"000000000000000000000000000000000",	-- instrucción 522 - Assembler.MovInstruction A, B
	"000000000000000100000000001100000",	-- instrucción 523 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010001",	-- instrucción 524 - Assembler.Instructions.Pop2Instruction B, None
	"000000000000000100000000001100001",	-- instrucción 525 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 526 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000000000000001001111",	-- instrucción 527 - Assembler.Instructions.PushInstruction B, None
	"000000000000001000000000001010101",	-- instrucción 528 - Assembler.Instructions.InInstruction B, Lit
	"000000000000000000000000001001010",	-- instrucción 529 - Assembler.CmpInstruction A, B
	"000000100000111100000000001011010",	-- instrucción 530 - Assembler.Instructions.JgtInstruction Lit, None
	"000000000000000100000000001100000",	-- instrucción 531 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010001",	-- instrucción 532 - Assembler.Instructions.Pop2Instruction B, None
	"000000100001100000000000001010111",	-- instrucción 533 - Assembler.Instructions.JmpInstruction Lit, None
	"000000000000000000000000000000001",	-- instrucción 534 - Assembler.MovInstruction B, A
	"000000000000000100000000001100000",	-- instrucción 535 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 536 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000000000000001001111",	-- instrucción 537 - Assembler.Instructions.PushInstruction B, None
	"000000000000001000000000001010101",	-- instrucción 538 - Assembler.Instructions.InInstruction B, Lit
	"000000000000000000000000001001010",	-- instrucción 539 - Assembler.CmpInstruction A, B
	"000000100010100000000000001011001",	-- instrucción 540 - Assembler.Instructions.JneInstruction Lit, None
	"000000000000000100000000001100000",	-- instrucción 541 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010001",	-- instrucción 542 - Assembler.Instructions.Pop2Instruction B, None
	"000000000000000000000000001001110",	-- instrucción 543 - Assembler.Instructions.PushInstruction A, None
	"000000000000000000000000000000000",	-- instrucción 544 - Assembler.MovInstruction A, B
	"000000000000001100000000001010101",	-- instrucción 545 - Assembler.Instructions.InInstruction B, Lit
	"000000000000000000000000001001010",	-- instrucción 546 - Assembler.CmpInstruction A, B
	"000000100001010100000000001011010",	-- instrucción 547 - Assembler.Instructions.JgtInstruction Lit, None
	"000000000000000000000000000000001",	-- instrucción 548 - Assembler.MovInstruction B, A
	"000000000000000100000000001100000",	-- instrucción 549 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 550 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000100000000001100001",	-- instrucción 551 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 552 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000100000000001100000",	-- instrucción 553 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010001",	-- instrucción 554 - Assembler.Instructions.Pop2Instruction B, None
	"000000000000000100000000001100001",	-- instrucción 555 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 556 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000000000000001001110",	-- instrucción 557 - Assembler.Instructions.PushInstruction A, None
	"000000100011000100000000001010111",	-- instrucción 558 - Assembler.Instructions.JmpInstruction Lit, None
	"000000000000000000000000000000001",	-- instrucción 559 - Assembler.MovInstruction B, A
	"000000000000000100000000001100000",	-- instrucción 560 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 561 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000000000000001001111",	-- instrucción 562 - Assembler.Instructions.PushInstruction B, None
	"000000000000001100000000001010101",	-- instrucción 563 - Assembler.Instructions.InInstruction B, Lit
	"000000000000000000000000001001010",	-- instrucción 564 - Assembler.CmpInstruction A, B
	"000000100100001100000000001011001",	-- instrucción 565 - Assembler.Instructions.JneInstruction Lit, None
	"000000000000000100000000001100000",	-- instrucción 566 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010001",	-- instrucción 567 - Assembler.Instructions.Pop2Instruction B, None
	"000000000000000000000000001001110",	-- instrucción 568 - Assembler.Instructions.PushInstruction A, None
	"000000000000000000000000000000000",	-- instrucción 569 - Assembler.MovInstruction A, B
	"000000000000010000000000001010101",	-- instrucción 570 - Assembler.Instructions.InInstruction B, Lit
	"000000000000000000000000001001010",	-- instrucción 571 - Assembler.CmpInstruction A, B
	"000000100010111000000000001011010",	-- instrucción 572 - Assembler.Instructions.JgtInstruction Lit, None
	"000000000000000000000000000000001",	-- instrucción 573 - Assembler.MovInstruction B, A
	"000000000000000100000000001100000",	-- instrucción 574 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 575 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000100000000001100000",	-- instrucción 576 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 577 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000100000000001100001",	-- instrucción 578 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 579 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000100000000001100000",	-- instrucción 580 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010001",	-- instrucción 581 - Assembler.Instructions.Pop2Instruction B, None
	"000000000000000100000000001100000",	-- instrucción 582 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 583 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000100000000001100001",	-- instrucción 584 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 585 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000000000000001001110",	-- instrucción 586 - Assembler.Instructions.PushInstruction A, None
	"000000000000000000000000001001111",	-- instrucción 587 - Assembler.Instructions.PushInstruction B, None
	"000000000000001100000000001010101",	-- instrucción 588 - Assembler.Instructions.InInstruction B, Lit
	"000000000000000000000000000001100",	-- instrucción 589 - Assembler.AddInstruction A, B
	"000000000000001000000000001010101",	-- instrucción 590 - Assembler.Instructions.InInstruction B, Lit
	"000000111110100000000000001001011",	-- instrucción 591 - Assembler.CmpInstruction A, Lit
	"000000100101001100000000001011100",	-- instrucción 592 - Assembler.Instructions.JltInstruction Lit, None
	"000000111110100000000000000010111",	-- instrucción 593 - Assembler.SubInstruction A, Lit
	"000000000000000000000000001000110",	-- instrucción 594 - Assembler.IncInstruction B, Lit
	"000000100100111000000000001010111",	-- instrucción 595 - Assembler.Instructions.JmpInstruction Lit, None
	"000000011111101000000000001010010",	-- instrucción 596 - Assembler.Instructions.CallInstruction Lit, None
	"000000100000111000000000001010010",	-- instrucción 597 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001100000",	-- instrucción 598 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010001",	-- instrucción 599 - Assembler.Instructions.Pop2Instruction B, None
	"000000000000000100000000001100000",	-- instrucción 600 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 601 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000100000000001100001",	-- instrucción 602 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 603 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000000000000001001110",	-- instrucción 604 - Assembler.Instructions.PushInstruction A, None
	"000000000000000000000000001001111",	-- instrucción 605 - Assembler.Instructions.PushInstruction B, None
	"000000000000010000000000001010101",	-- instrucción 606 - Assembler.Instructions.InInstruction B, Lit
	"000000000000000000000000000001100",	-- instrucción 607 - Assembler.AddInstruction A, B
	"000000000000000100000000001000101",	-- instrucción 608 - Assembler.IncInstruction A, Lit
	"000000000000000000000000000000011",	-- instrucción 609 - Assembler.MovInstruction B, Lit
	"000000111110100000000000001001011",	-- instrucción 610 - Assembler.CmpInstruction A, Lit
	"000000100110011000000000001011100",	-- instrucción 611 - Assembler.Instructions.JltInstruction Lit, None
	"000000111110100000000000000010111",	-- instrucción 612 - Assembler.SubInstruction A, Lit
	"000000000000000000000000001000110",	-- instrucción 613 - Assembler.IncInstruction B, Lit
	"000000100110000100000000001010111",	-- instrucción 614 - Assembler.Instructions.JmpInstruction Lit, None
	"000000000000000000000000001001011",	-- instrucción 615 - Assembler.CmpInstruction A, Lit
	"000000100110100100000000001011000",	-- instrucción 616 - Assembler.Instructions.JeqInstruction Lit, None
	"000000000000000100000000001001001",	-- instrucción 617 - Assembler.Instructions.DecInstruction A, Lit
	"000000000000000000000000001001110",	-- instrucción 618 - Assembler.Instructions.PushInstruction A, None
	"000000000000000000000000001001111",	-- instrucción 619 - Assembler.Instructions.PushInstruction B, None
	"000000000000001100000000001010100",	-- instrucción 620 - Assembler.Instructions.InInstruction A, Lit
	"000000000000000000000000000001101",	-- instrucción 621 - Assembler.AddInstruction B, A
	"000000000000000100000000001100000",	-- instrucción 622 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 623 - Assembler.Instructions.Pop2Instruction A, None
	"000000100100100100000000001010010",	-- instrucción 624 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000000000000000000000",	-- instrucción 625 - Assembler.MovInstruction A, B
	"000000111110100000000000001001011",	-- instrucción 626 - Assembler.CmpInstruction A, Lit
	"000000100111010000000000001011100",	-- instrucción 627 - Assembler.Instructions.JltInstruction Lit, None
	"000000111110100000000000000010111",	-- instrucción 628 - Assembler.SubInstruction A, Lit
	"000000000000000100000000001100000",	-- instrucción 629 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010001",	-- instrucción 630 - Assembler.Instructions.Pop2Instruction B, None
	"000000100010110000000000001010010",	-- instrucción 631 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001100000",	-- instrucción 632 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010001",	-- instrucción 633 - Assembler.Instructions.Pop2Instruction B, None
	"000000000000000100000000001100000",	-- instrucción 634 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 635 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000100000000001100001",	-- instrucción 636 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 637 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000000000000001001110",	-- instrucción 638 - Assembler.Instructions.PushInstruction A, None
	"000000000000000000000000001100010",	-- instrucción 639 - Assembler.Instructions.OutInstruction A, B
	"000000000010011100000000000000010",	-- instrucción 640 - Assembler.MovInstruction A, Lit
	"000000100101101100000000001010010",	-- instrucción 641 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001100000",	-- instrucción 642 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 643 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000100000000001100001",	-- instrucción 644 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 645 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000000000000001001110",	-- instrucción 646 - Assembler.Instructions.PushInstruction A, None
	"000000100000000000000000000101001",	-- instrucción 647 - Assembler.OrInstruction A, Lit
	"000000100111110100000000001010010",	-- instrucción 648 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001100000",	-- instrucción 649 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 650 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000100000000001100001",	-- instrucción 651 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 652 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000000000000001001110",	-- instrucción 653 - Assembler.Instructions.PushInstruction A, None
	"000000000000000100000000000000010",	-- instrucción 654 - Assembler.MovInstruction A, Lit
	"000000100111110100000000001010010",	-- instrucción 655 - Assembler.Instructions.CallInstruction Lit, None
	"000001011111101000000000000000010",	-- instrucción 656 - Assembler.MovInstruction A, Lit
	"000000100101101100000000001010010",	-- instrucción 657 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001100000",	-- instrucción 658 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 659 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000100000000001100001",	-- instrucción 660 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 661 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000000000000001001110",	-- instrucción 662 - Assembler.Instructions.PushInstruction A, None
	"000000000000001000000000000000010",	-- instrucción 663 - Assembler.MovInstruction A, Lit
	"000000100111110100000000001010010",	-- instrucción 664 - Assembler.Instructions.CallInstruction Lit, None
	"000001011111101000000000000000010",	-- instrucción 665 - Assembler.MovInstruction A, Lit
	"000000100101101100000000001010010",	-- instrucción 666 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001100000",	-- instrucción 667 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 668 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000100000000001100001",	-- instrucción 669 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 670 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000000000000001001110",	-- instrucción 671 - Assembler.Instructions.PushInstruction A, None
	"000000000000000000000000000000010",	-- instrucción 672 - Assembler.MovInstruction A, Lit
	"000000101010110000000000001010010",	-- instrucción 673 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001100000",	-- instrucción 674 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 675 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000100000000001100001",	-- instrucción 676 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 677 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000000000000001001110",	-- instrucción 678 - Assembler.Instructions.PushInstruction A, None
	"000000000000000000000000000000010",	-- instrucción 679 - Assembler.MovInstruction A, Lit
	"000000101011010000000000001010010",	-- instrucción 680 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001100000",	-- instrucción 681 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 682 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000100000000001100001",	-- instrucción 683 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 684 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000000000000001001110",	-- instrucción 685 - Assembler.Instructions.PushInstruction A, None
	"000000001000000000000000000101001",	-- instrucción 686 - Assembler.OrInstruction A, Lit
	"000000000101100000000000000000110",	-- instrucción 687 - Assembler.MovInstruction Dir, A
	"000000100111110100000000001010010",	-- instrucción 688 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001100000",	-- instrucción 689 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 690 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000100000000001100001",	-- instrucción 691 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 692 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000000000000001001110",	-- instrucción 693 - Assembler.Instructions.PushInstruction A, None
	"000000001100000000000000000101001",	-- instrucción 694 - Assembler.OrInstruction A, Lit
	"000000000101100000000000000000110",	-- instrucción 695 - Assembler.MovInstruction Dir, A
	"000000100111110100000000001010010",	-- instrucción 696 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001100000",	-- instrucción 697 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 698 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000100000000001100001",	-- instrucción 699 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 700 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000000000000001001110",	-- instrucción 701 - Assembler.Instructions.PushInstruction A, None
	"000000000001100000000000000000010",	-- instrucción 702 - Assembler.MovInstruction A, Lit
	"000000100111110100000000001010010",	-- instrucción 703 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001100000",	-- instrucción 704 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 705 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000100000000001100001",	-- instrucción 706 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 707 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000000000000001001110",	-- instrucción 708 - Assembler.Instructions.PushInstruction A, None
	"000000000001110000000000000000010",	-- instrucción 709 - Assembler.MovInstruction A, Lit
	"000000100111110100000000001010010",	-- instrucción 710 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001100000",	-- instrucción 711 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 712 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000100000000001100001",	-- instrucción 713 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 714 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000000000000001001110",	-- instrucción 715 - Assembler.Instructions.PushInstruction A, None
	"000000000001000000000000000000010",	-- instrucción 716 - Assembler.MovInstruction A, Lit
	"000000100111110100000000001010010",	-- instrucción 717 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001100000",	-- instrucción 718 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 719 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000100000000001100001",	-- instrucción 720 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 721 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000000000000001001110",	-- instrucción 722 - Assembler.Instructions.PushInstruction A, None
	"000000000001010000000000000000010",	-- instrucción 723 - Assembler.MovInstruction A, Lit
	"000000100111110100000000001010010",	-- instrucción 724 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001100000",	-- instrucción 725 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 726 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000100000000001100001",	-- instrucción 727 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 728 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000000000000001001110",	-- instrucción 729 - Assembler.Instructions.PushInstruction A, None
	"000000000000000000000000001001111",	-- instrucción 730 - Assembler.Instructions.PushInstruction B, None
	"000000000000000000000000000000001",	-- instrucción 731 - Assembler.MovInstruction B, A
	"000000000000000000000000000001000",	-- instrucción 732 - Assembler.MovInstruction A, DirB
	"000000000000000100000000001100000",	-- instrucción 733 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010001",	-- instrucción 734 - Assembler.Instructions.Pop2Instruction B, None
	"000000000000000000000000001001011",	-- instrucción 735 - Assembler.CmpInstruction A, Lit
	"000000101110010100000000001011000",	-- instrucción 736 - Assembler.Instructions.JeqInstruction Lit, None
	"000000101000010100000000001010010",	-- instrucción 737 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001100000",	-- instrucción 738 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 739 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000100000000001000101",	-- instrucción 740 - Assembler.IncInstruction A, Lit
	"000000101101100000000000001010111",	-- instrucción 741 - Assembler.Instructions.JmpInstruction Lit, None
	"000000000000000100000000001100000",	-- instrucción 742 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 743 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000100000000001100001",	-- instrucción 744 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 745 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000000000000001001110",	-- instrucción 746 - Assembler.Instructions.PushInstruction A, None
	"000000000001111000000000000000010",	-- instrucción 747 - Assembler.MovInstruction A, Lit
	"000000100100100100000000001010010",	-- instrucción 748 - Assembler.Instructions.CallInstruction Lit, None
	"000000000011110000000000000000010",	-- instrucción 749 - Assembler.MovInstruction A, Lit
	"000000100111110100000000001010010",	-- instrucción 750 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000111100000000000000010",	-- instrucción 751 - Assembler.MovInstruction A, Lit
	"000000100111110100000000001010010",	-- instrucción 752 - Assembler.Instructions.CallInstruction Lit, None
	"000000101000110000000000001010010",	-- instrucción 753 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000011000000000000000010",	-- instrucción 754 - Assembler.MovInstruction A, Lit
	"000000100111110100000000001010010",	-- instrucción 755 - Assembler.Instructions.CallInstruction Lit, None
	"000000101001010100000000001010010",	-- instrucción 756 - Assembler.Instructions.CallInstruction Lit, None
	"000000000000000100000000001100000",	-- instrucción 757 - Assembler.Instructions.Pop1Instruction Lit, None
	"000000000000000000000000001010000",	-- instrucción 758 - Assembler.Instructions.Pop2Instruction A, None
	"000000000000000100000000001100001",	-- instrucción 759 - Assembler.Instructions.Ret1Instruction Lit, None
	"000000000000000000000000001010011",	-- instrucción 760 - Assembler.Instructions.Ret2Instruction None, None
	"000000000000000000000000001011111",	-- instrucción 761
	"000000000000000000000000001011111",	-- instrucción 762
	"000000000000000000000000001011111",	-- instrucción 763
	"000000000000000000000000001011111",	-- instrucción 764
	"000000000000000000000000001011111",	-- instrucción 765
	"000000000000000000000000001011111",	-- instrucción 766
	"000000000000000000000000001011111",	-- instrucción 767
	"000000000000000000000000001011111",	-- instrucción 768
	"000000000000000000000000001011111",	-- instrucción 769
	"000000000000000000000000001011111",	-- instrucción 770
	"000000000000000000000000001011111",	-- instrucción 771
	"000000000000000000000000001011111",	-- instrucción 772
	"000000000000000000000000001011111",	-- instrucción 773
	"000000000000000000000000001011111",	-- instrucción 774
	"000000000000000000000000001011111",	-- instrucción 775
	"000000000000000000000000001011111",	-- instrucción 776
	"000000000000000000000000001011111",	-- instrucción 777
	"000000000000000000000000001011111",	-- instrucción 778
	"000000000000000000000000001011111",	-- instrucción 779
	"000000000000000000000000001011111",	-- instrucción 780
	"000000000000000000000000001011111",	-- instrucción 781
	"000000000000000000000000001011111",	-- instrucción 782
	"000000000000000000000000001011111",	-- instrucción 783
	"000000000000000000000000001011111",	-- instrucción 784
	"000000000000000000000000001011111",	-- instrucción 785
	"000000000000000000000000001011111",	-- instrucción 786
	"000000000000000000000000001011111",	-- instrucción 787
	"000000000000000000000000001011111",	-- instrucción 788
	"000000000000000000000000001011111",	-- instrucción 789
	"000000000000000000000000001011111",	-- instrucción 790
	"000000000000000000000000001011111",	-- instrucción 791
	"000000000000000000000000001011111",	-- instrucción 792
	"000000000000000000000000001011111",	-- instrucción 793
	"000000000000000000000000001011111",	-- instrucción 794
	"000000000000000000000000001011111",	-- instrucción 795
	"000000000000000000000000001011111",	-- instrucción 796
	"000000000000000000000000001011111",	-- instrucción 797
	"000000000000000000000000001011111",	-- instrucción 798
	"000000000000000000000000001011111",	-- instrucción 799
	"000000000000000000000000001011111",	-- instrucción 800
	"000000000000000000000000001011111",	-- instrucción 801
	"000000000000000000000000001011111",	-- instrucción 802
	"000000000000000000000000001011111",	-- instrucción 803
	"000000000000000000000000001011111",	-- instrucción 804
	"000000000000000000000000001011111",	-- instrucción 805
	"000000000000000000000000001011111",	-- instrucción 806
	"000000000000000000000000001011111",	-- instrucción 807
	"000000000000000000000000001011111",	-- instrucción 808
	"000000000000000000000000001011111",	-- instrucción 809
	"000000000000000000000000001011111",	-- instrucción 810
	"000000000000000000000000001011111",	-- instrucción 811
	"000000000000000000000000001011111",	-- instrucción 812
	"000000000000000000000000001011111",	-- instrucción 813
	"000000000000000000000000001011111",	-- instrucción 814
	"000000000000000000000000001011111",	-- instrucción 815
	"000000000000000000000000001011111",	-- instrucción 816
	"000000000000000000000000001011111",	-- instrucción 817
	"000000000000000000000000001011111",	-- instrucción 818
	"000000000000000000000000001011111",	-- instrucción 819
	"000000000000000000000000001011111",	-- instrucción 820
	"000000000000000000000000001011111",	-- instrucción 821
	"000000000000000000000000001011111",	-- instrucción 822
	"000000000000000000000000001011111",	-- instrucción 823
	"000000000000000000000000001011111",	-- instrucción 824
	"000000000000000000000000001011111",	-- instrucción 825
	"000000000000000000000000001011111",	-- instrucción 826
	"000000000000000000000000001011111",	-- instrucción 827
	"000000000000000000000000001011111",	-- instrucción 828
	"000000000000000000000000001011111",	-- instrucción 829
	"000000000000000000000000001011111",	-- instrucción 830
	"000000000000000000000000001011111",	-- instrucción 831
	"000000000000000000000000001011111",	-- instrucción 832
	"000000000000000000000000001011111",	-- instrucción 833
	"000000000000000000000000001011111",	-- instrucción 834
	"000000000000000000000000001011111",	-- instrucción 835
	"000000000000000000000000001011111",	-- instrucción 836
	"000000000000000000000000001011111",	-- instrucción 837
	"000000000000000000000000001011111",	-- instrucción 838
	"000000000000000000000000001011111",	-- instrucción 839
	"000000000000000000000000001011111",	-- instrucción 840
	"000000000000000000000000001011111",	-- instrucción 841
	"000000000000000000000000001011111",	-- instrucción 842
	"000000000000000000000000001011111",	-- instrucción 843
	"000000000000000000000000001011111",	-- instrucción 844
	"000000000000000000000000001011111",	-- instrucción 845
	"000000000000000000000000001011111",	-- instrucción 846
	"000000000000000000000000001011111",	-- instrucción 847
	"000000000000000000000000001011111",	-- instrucción 848
	"000000000000000000000000001011111",	-- instrucción 849
	"000000000000000000000000001011111",	-- instrucción 850
	"000000000000000000000000001011111",	-- instrucción 851
	"000000000000000000000000001011111",	-- instrucción 852
	"000000000000000000000000001011111",	-- instrucción 853
	"000000000000000000000000001011111",	-- instrucción 854
	"000000000000000000000000001011111",	-- instrucción 855
	"000000000000000000000000001011111",	-- instrucción 856
	"000000000000000000000000001011111",	-- instrucción 857
	"000000000000000000000000001011111",	-- instrucción 858
	"000000000000000000000000001011111",	-- instrucción 859
	"000000000000000000000000001011111",	-- instrucción 860
	"000000000000000000000000001011111",	-- instrucción 861
	"000000000000000000000000001011111",	-- instrucción 862
	"000000000000000000000000001011111",	-- instrucción 863
	"000000000000000000000000001011111",	-- instrucción 864
	"000000000000000000000000001011111",	-- instrucción 865
	"000000000000000000000000001011111",	-- instrucción 866
	"000000000000000000000000001011111",	-- instrucción 867
	"000000000000000000000000001011111",	-- instrucción 868
	"000000000000000000000000001011111",	-- instrucción 869
	"000000000000000000000000001011111",	-- instrucción 870
	"000000000000000000000000001011111",	-- instrucción 871
	"000000000000000000000000001011111",	-- instrucción 872
	"000000000000000000000000001011111",	-- instrucción 873
	"000000000000000000000000001011111",	-- instrucción 874
	"000000000000000000000000001011111",	-- instrucción 875
	"000000000000000000000000001011111",	-- instrucción 876
	"000000000000000000000000001011111",	-- instrucción 877
	"000000000000000000000000001011111",	-- instrucción 878
	"000000000000000000000000001011111",	-- instrucción 879
	"000000000000000000000000001011111",	-- instrucción 880
	"000000000000000000000000001011111",	-- instrucción 881
	"000000000000000000000000001011111",	-- instrucción 882
	"000000000000000000000000001011111",	-- instrucción 883
	"000000000000000000000000001011111",	-- instrucción 884
	"000000000000000000000000001011111",	-- instrucción 885
	"000000000000000000000000001011111",	-- instrucción 886
	"000000000000000000000000001011111",	-- instrucción 887
	"000000000000000000000000001011111",	-- instrucción 888
	"000000000000000000000000001011111",	-- instrucción 889
	"000000000000000000000000001011111",	-- instrucción 890
	"000000000000000000000000001011111",	-- instrucción 891
	"000000000000000000000000001011111",	-- instrucción 892
	"000000000000000000000000001011111",	-- instrucción 893
	"000000000000000000000000001011111",	-- instrucción 894
	"000000000000000000000000001011111",	-- instrucción 895
	"000000000000000000000000001011111",	-- instrucción 896
	"000000000000000000000000001011111",	-- instrucción 897
	"000000000000000000000000001011111",	-- instrucción 898
	"000000000000000000000000001011111",	-- instrucción 899
	"000000000000000000000000001011111",	-- instrucción 900
	"000000000000000000000000001011111",	-- instrucción 901
	"000000000000000000000000001011111",	-- instrucción 902
	"000000000000000000000000001011111",	-- instrucción 903
	"000000000000000000000000001011111",	-- instrucción 904
	"000000000000000000000000001011111",	-- instrucción 905
	"000000000000000000000000001011111",	-- instrucción 906
	"000000000000000000000000001011111",	-- instrucción 907
	"000000000000000000000000001011111",	-- instrucción 908
	"000000000000000000000000001011111",	-- instrucción 909
	"000000000000000000000000001011111",	-- instrucción 910
	"000000000000000000000000001011111",	-- instrucción 911
	"000000000000000000000000001011111",	-- instrucción 912
	"000000000000000000000000001011111",	-- instrucción 913
	"000000000000000000000000001011111",	-- instrucción 914
	"000000000000000000000000001011111",	-- instrucción 915
	"000000000000000000000000001011111",	-- instrucción 916
	"000000000000000000000000001011111",	-- instrucción 917
	"000000000000000000000000001011111",	-- instrucción 918
	"000000000000000000000000001011111",	-- instrucción 919
	"000000000000000000000000001011111",	-- instrucción 920
	"000000000000000000000000001011111",	-- instrucción 921
	"000000000000000000000000001011111",	-- instrucción 922
	"000000000000000000000000001011111",	-- instrucción 923
	"000000000000000000000000001011111",	-- instrucción 924
	"000000000000000000000000001011111",	-- instrucción 925
	"000000000000000000000000001011111",	-- instrucción 926
	"000000000000000000000000001011111",	-- instrucción 927
	"000000000000000000000000001011111",	-- instrucción 928
	"000000000000000000000000001011111",	-- instrucción 929
	"000000000000000000000000001011111",	-- instrucción 930
	"000000000000000000000000001011111",	-- instrucción 931
	"000000000000000000000000001011111",	-- instrucción 932
	"000000000000000000000000001011111",	-- instrucción 933
	"000000000000000000000000001011111",	-- instrucción 934
	"000000000000000000000000001011111",	-- instrucción 935
	"000000000000000000000000001011111",	-- instrucción 936
	"000000000000000000000000001011111",	-- instrucción 937
	"000000000000000000000000001011111",	-- instrucción 938
	"000000000000000000000000001011111",	-- instrucción 939
	"000000000000000000000000001011111",	-- instrucción 940
	"000000000000000000000000001011111",	-- instrucción 941
	"000000000000000000000000001011111",	-- instrucción 942
	"000000000000000000000000001011111",	-- instrucción 943
	"000000000000000000000000001011111",	-- instrucción 944
	"000000000000000000000000001011111",	-- instrucción 945
	"000000000000000000000000001011111",	-- instrucción 946
	"000000000000000000000000001011111",	-- instrucción 947
	"000000000000000000000000001011111",	-- instrucción 948
	"000000000000000000000000001011111",	-- instrucción 949
	"000000000000000000000000001011111",	-- instrucción 950
	"000000000000000000000000001011111",	-- instrucción 951
	"000000000000000000000000001011111",	-- instrucción 952
	"000000000000000000000000001011111",	-- instrucción 953
	"000000000000000000000000001011111",	-- instrucción 954
	"000000000000000000000000001011111",	-- instrucción 955
	"000000000000000000000000001011111",	-- instrucción 956
	"000000000000000000000000001011111",	-- instrucción 957
	"000000000000000000000000001011111",	-- instrucción 958
	"000000000000000000000000001011111",	-- instrucción 959
	"000000000000000000000000001011111",	-- instrucción 960
	"000000000000000000000000001011111",	-- instrucción 961
	"000000000000000000000000001011111",	-- instrucción 962
	"000000000000000000000000001011111",	-- instrucción 963
	"000000000000000000000000001011111",	-- instrucción 964
	"000000000000000000000000001011111",	-- instrucción 965
	"000000000000000000000000001011111",	-- instrucción 966
	"000000000000000000000000001011111",	-- instrucción 967
	"000000000000000000000000001011111",	-- instrucción 968
	"000000000000000000000000001011111",	-- instrucción 969
	"000000000000000000000000001011111",	-- instrucción 970
	"000000000000000000000000001011111",	-- instrucción 971
	"000000000000000000000000001011111",	-- instrucción 972
	"000000000000000000000000001011111",	-- instrucción 973
	"000000000000000000000000001011111",	-- instrucción 974
	"000000000000000000000000001011111",	-- instrucción 975
	"000000000000000000000000001011111",	-- instrucción 976
	"000000000000000000000000001011111",	-- instrucción 977
	"000000000000000000000000001011111",	-- instrucción 978
	"000000000000000000000000001011111",	-- instrucción 979
	"000000000000000000000000001011111",	-- instrucción 980
	"000000000000000000000000001011111",	-- instrucción 981
	"000000000000000000000000001011111",	-- instrucción 982
	"000000000000000000000000001011111",	-- instrucción 983
	"000000000000000000000000001011111",	-- instrucción 984
	"000000000000000000000000001011111",	-- instrucción 985
	"000000000000000000000000001011111",	-- instrucción 986
	"000000000000000000000000001011111",	-- instrucción 987
	"000000000000000000000000001011111",	-- instrucción 988
	"000000000000000000000000001011111",	-- instrucción 989
	"000000000000000000000000001011111",	-- instrucción 990
	"000000000000000000000000001011111",	-- instrucción 991
	"000000000000000000000000001011111",	-- instrucción 992
	"000000000000000000000000001011111",	-- instrucción 993
	"000000000000000000000000001011111",	-- instrucción 994
	"000000000000000000000000001011111",	-- instrucción 995
	"000000000000000000000000001011111",	-- instrucción 996
	"000000000000000000000000001011111",	-- instrucción 997
	"000000000000000000000000001011111",	-- instrucción 998
	"000000000000000000000000001011111",	-- instrucción 999
	"000000000000000000000000001011111",	-- instrucción 1000
	"000000000000000000000000001011111",	-- instrucción 1001
	"000000000000000000000000001011111",	-- instrucción 1002
	"000000000000000000000000001011111",	-- instrucción 1003
	"000000000000000000000000001011111",	-- instrucción 1004
	"000000000000000000000000001011111",	-- instrucción 1005
	"000000000000000000000000001011111",	-- instrucción 1006
	"000000000000000000000000001011111",	-- instrucción 1007
	"000000000000000000000000001011111",	-- instrucción 1008
	"000000000000000000000000001011111",	-- instrucción 1009
	"000000000000000000000000001011111",	-- instrucción 1010
	"000000000000000000000000001011111",	-- instrucción 1011
	"000000000000000000000000001011111",	-- instrucción 1012
	"000000000000000000000000001011111",	-- instrucción 1013
	"000000000000000000000000001011111",	-- instrucción 1014
	"000000000000000000000000001011111",	-- instrucción 1015
	"000000000000000000000000001011111",	-- instrucción 1016
	"000000000000000000000000001011111",	-- instrucción 1017
	"000000000000000000000000001011111",	-- instrucción 1018
	"000000000000000000000000001011111",	-- instrucción 1019
	"000000000000000000000000001011111",	-- instrucción 1020
	"000000000000000000000000001011111",	-- instrucción 1021
	"000000000000000000000000001011111",	-- instrucción 1022
	"000000000000000000000000001011111",	-- instrucción 1023
	"000000000000000000000000001011111",	-- instrucción 1024
	"000000000000000000000000001011111",	-- instrucción 1025
	"000000000000000000000000001011111",	-- instrucción 1026
	"000000000000000000000000001011111",	-- instrucción 1027
	"000000000000000000000000001011111",	-- instrucción 1028
	"000000000000000000000000001011111",	-- instrucción 1029
	"000000000000000000000000001011111",	-- instrucción 1030
	"000000000000000000000000001011111",	-- instrucción 1031
	"000000000000000000000000001011111",	-- instrucción 1032
	"000000000000000000000000001011111",	-- instrucción 1033
	"000000000000000000000000001011111",	-- instrucción 1034
	"000000000000000000000000001011111",	-- instrucción 1035
	"000000000000000000000000001011111",	-- instrucción 1036
	"000000000000000000000000001011111",	-- instrucción 1037
	"000000000000000000000000001011111",	-- instrucción 1038
	"000000000000000000000000001011111",	-- instrucción 1039
	"000000000000000000000000001011111",	-- instrucción 1040
	"000000000000000000000000001011111",	-- instrucción 1041
	"000000000000000000000000001011111",	-- instrucción 1042
	"000000000000000000000000001011111",	-- instrucción 1043
	"000000000000000000000000001011111",	-- instrucción 1044
	"000000000000000000000000001011111",	-- instrucción 1045
	"000000000000000000000000001011111",	-- instrucción 1046
	"000000000000000000000000001011111",	-- instrucción 1047
	"000000000000000000000000001011111",	-- instrucción 1048
	"000000000000000000000000001011111",	-- instrucción 1049
	"000000000000000000000000001011111",	-- instrucción 1050
	"000000000000000000000000001011111",	-- instrucción 1051
	"000000000000000000000000001011111",	-- instrucción 1052
	"000000000000000000000000001011111",	-- instrucción 1053
	"000000000000000000000000001011111",	-- instrucción 1054
	"000000000000000000000000001011111",	-- instrucción 1055
	"000000000000000000000000001011111",	-- instrucción 1056
	"000000000000000000000000001011111",	-- instrucción 1057
	"000000000000000000000000001011111",	-- instrucción 1058
	"000000000000000000000000001011111",	-- instrucción 1059
	"000000000000000000000000001011111",	-- instrucción 1060
	"000000000000000000000000001011111",	-- instrucción 1061
	"000000000000000000000000001011111",	-- instrucción 1062
	"000000000000000000000000001011111",	-- instrucción 1063
	"000000000000000000000000001011111",	-- instrucción 1064
	"000000000000000000000000001011111",	-- instrucción 1065
	"000000000000000000000000001011111",	-- instrucción 1066
	"000000000000000000000000001011111",	-- instrucción 1067
	"000000000000000000000000001011111",	-- instrucción 1068
	"000000000000000000000000001011111",	-- instrucción 1069
	"000000000000000000000000001011111",	-- instrucción 1070
	"000000000000000000000000001011111",	-- instrucción 1071
	"000000000000000000000000001011111",	-- instrucción 1072
	"000000000000000000000000001011111",	-- instrucción 1073
	"000000000000000000000000001011111",	-- instrucción 1074
	"000000000000000000000000001011111",	-- instrucción 1075
	"000000000000000000000000001011111",	-- instrucción 1076
	"000000000000000000000000001011111",	-- instrucción 1077
	"000000000000000000000000001011111",	-- instrucción 1078
	"000000000000000000000000001011111",	-- instrucción 1079
	"000000000000000000000000001011111",	-- instrucción 1080
	"000000000000000000000000001011111",	-- instrucción 1081
	"000000000000000000000000001011111",	-- instrucción 1082
	"000000000000000000000000001011111",	-- instrucción 1083
	"000000000000000000000000001011111",	-- instrucción 1084
	"000000000000000000000000001011111",	-- instrucción 1085
	"000000000000000000000000001011111",	-- instrucción 1086
	"000000000000000000000000001011111",	-- instrucción 1087
	"000000000000000000000000001011111",	-- instrucción 1088
	"000000000000000000000000001011111",	-- instrucción 1089
	"000000000000000000000000001011111",	-- instrucción 1090
	"000000000000000000000000001011111",	-- instrucción 1091
	"000000000000000000000000001011111",	-- instrucción 1092
	"000000000000000000000000001011111",	-- instrucción 1093
	"000000000000000000000000001011111",	-- instrucción 1094
	"000000000000000000000000001011111",	-- instrucción 1095
	"000000000000000000000000001011111",	-- instrucción 1096
	"000000000000000000000000001011111",	-- instrucción 1097
	"000000000000000000000000001011111",	-- instrucción 1098
	"000000000000000000000000001011111",	-- instrucción 1099
	"000000000000000000000000001011111",	-- instrucción 1100
	"000000000000000000000000001011111",	-- instrucción 1101
	"000000000000000000000000001011111",	-- instrucción 1102
	"000000000000000000000000001011111",	-- instrucción 1103
	"000000000000000000000000001011111",	-- instrucción 1104
	"000000000000000000000000001011111",	-- instrucción 1105
	"000000000000000000000000001011111",	-- instrucción 1106
	"000000000000000000000000001011111",	-- instrucción 1107
	"000000000000000000000000001011111",	-- instrucción 1108
	"000000000000000000000000001011111",	-- instrucción 1109
	"000000000000000000000000001011111",	-- instrucción 1110
	"000000000000000000000000001011111",	-- instrucción 1111
	"000000000000000000000000001011111",	-- instrucción 1112
	"000000000000000000000000001011111",	-- instrucción 1113
	"000000000000000000000000001011111",	-- instrucción 1114
	"000000000000000000000000001011111",	-- instrucción 1115
	"000000000000000000000000001011111",	-- instrucción 1116
	"000000000000000000000000001011111",	-- instrucción 1117
	"000000000000000000000000001011111",	-- instrucción 1118
	"000000000000000000000000001011111",	-- instrucción 1119
	"000000000000000000000000001011111",	-- instrucción 1120
	"000000000000000000000000001011111",	-- instrucción 1121
	"000000000000000000000000001011111",	-- instrucción 1122
	"000000000000000000000000001011111",	-- instrucción 1123
	"000000000000000000000000001011111",	-- instrucción 1124
	"000000000000000000000000001011111",	-- instrucción 1125
	"000000000000000000000000001011111",	-- instrucción 1126
	"000000000000000000000000001011111",	-- instrucción 1127
	"000000000000000000000000001011111",	-- instrucción 1128
	"000000000000000000000000001011111",	-- instrucción 1129
	"000000000000000000000000001011111",	-- instrucción 1130
	"000000000000000000000000001011111",	-- instrucción 1131
	"000000000000000000000000001011111",	-- instrucción 1132
	"000000000000000000000000001011111",	-- instrucción 1133
	"000000000000000000000000001011111",	-- instrucción 1134
	"000000000000000000000000001011111",	-- instrucción 1135
	"000000000000000000000000001011111",	-- instrucción 1136
	"000000000000000000000000001011111",	-- instrucción 1137
	"000000000000000000000000001011111",	-- instrucción 1138
	"000000000000000000000000001011111",	-- instrucción 1139
	"000000000000000000000000001011111",	-- instrucción 1140
	"000000000000000000000000001011111",	-- instrucción 1141
	"000000000000000000000000001011111",	-- instrucción 1142
	"000000000000000000000000001011111",	-- instrucción 1143
	"000000000000000000000000001011111",	-- instrucción 1144
	"000000000000000000000000001011111",	-- instrucción 1145
	"000000000000000000000000001011111",	-- instrucción 1146
	"000000000000000000000000001011111",	-- instrucción 1147
	"000000000000000000000000001011111",	-- instrucción 1148
	"000000000000000000000000001011111",	-- instrucción 1149
	"000000000000000000000000001011111",	-- instrucción 1150
	"000000000000000000000000001011111",	-- instrucción 1151
	"000000000000000000000000001011111",	-- instrucción 1152
	"000000000000000000000000001011111",	-- instrucción 1153
	"000000000000000000000000001011111",	-- instrucción 1154
	"000000000000000000000000001011111",	-- instrucción 1155
	"000000000000000000000000001011111",	-- instrucción 1156
	"000000000000000000000000001011111",	-- instrucción 1157
	"000000000000000000000000001011111",	-- instrucción 1158
	"000000000000000000000000001011111",	-- instrucción 1159
	"000000000000000000000000001011111",	-- instrucción 1160
	"000000000000000000000000001011111",	-- instrucción 1161
	"000000000000000000000000001011111",	-- instrucción 1162
	"000000000000000000000000001011111",	-- instrucción 1163
	"000000000000000000000000001011111",	-- instrucción 1164
	"000000000000000000000000001011111",	-- instrucción 1165
	"000000000000000000000000001011111",	-- instrucción 1166
	"000000000000000000000000001011111",	-- instrucción 1167
	"000000000000000000000000001011111",	-- instrucción 1168
	"000000000000000000000000001011111",	-- instrucción 1169
	"000000000000000000000000001011111",	-- instrucción 1170
	"000000000000000000000000001011111",	-- instrucción 1171
	"000000000000000000000000001011111",	-- instrucción 1172
	"000000000000000000000000001011111",	-- instrucción 1173
	"000000000000000000000000001011111",	-- instrucción 1174
	"000000000000000000000000001011111",	-- instrucción 1175
	"000000000000000000000000001011111",	-- instrucción 1176
	"000000000000000000000000001011111",	-- instrucción 1177
	"000000000000000000000000001011111",	-- instrucción 1178
	"000000000000000000000000001011111",	-- instrucción 1179
	"000000000000000000000000001011111",	-- instrucción 1180
	"000000000000000000000000001011111",	-- instrucción 1181
	"000000000000000000000000001011111",	-- instrucción 1182
	"000000000000000000000000001011111",	-- instrucción 1183
	"000000000000000000000000001011111",	-- instrucción 1184
	"000000000000000000000000001011111",	-- instrucción 1185
	"000000000000000000000000001011111",	-- instrucción 1186
	"000000000000000000000000001011111",	-- instrucción 1187
	"000000000000000000000000001011111",	-- instrucción 1188
	"000000000000000000000000001011111",	-- instrucción 1189
	"000000000000000000000000001011111",	-- instrucción 1190
	"000000000000000000000000001011111",	-- instrucción 1191
	"000000000000000000000000001011111",	-- instrucción 1192
	"000000000000000000000000001011111",	-- instrucción 1193
	"000000000000000000000000001011111",	-- instrucción 1194
	"000000000000000000000000001011111",	-- instrucción 1195
	"000000000000000000000000001011111",	-- instrucción 1196
	"000000000000000000000000001011111",	-- instrucción 1197
	"000000000000000000000000001011111",	-- instrucción 1198
	"000000000000000000000000001011111",	-- instrucción 1199
	"000000000000000000000000001011111",	-- instrucción 1200
	"000000000000000000000000001011111",	-- instrucción 1201
	"000000000000000000000000001011111",	-- instrucción 1202
	"000000000000000000000000001011111",	-- instrucción 1203
	"000000000000000000000000001011111",	-- instrucción 1204
	"000000000000000000000000001011111",	-- instrucción 1205
	"000000000000000000000000001011111",	-- instrucción 1206
	"000000000000000000000000001011111",	-- instrucción 1207
	"000000000000000000000000001011111",	-- instrucción 1208
	"000000000000000000000000001011111",	-- instrucción 1209
	"000000000000000000000000001011111",	-- instrucción 1210
	"000000000000000000000000001011111",	-- instrucción 1211
	"000000000000000000000000001011111",	-- instrucción 1212
	"000000000000000000000000001011111",	-- instrucción 1213
	"000000000000000000000000001011111",	-- instrucción 1214
	"000000000000000000000000001011111",	-- instrucción 1215
	"000000000000000000000000001011111",	-- instrucción 1216
	"000000000000000000000000001011111",	-- instrucción 1217
	"000000000000000000000000001011111",	-- instrucción 1218
	"000000000000000000000000001011111",	-- instrucción 1219
	"000000000000000000000000001011111",	-- instrucción 1220
	"000000000000000000000000001011111",	-- instrucción 1221
	"000000000000000000000000001011111",	-- instrucción 1222
	"000000000000000000000000001011111",	-- instrucción 1223
	"000000000000000000000000001011111",	-- instrucción 1224
	"000000000000000000000000001011111",	-- instrucción 1225
	"000000000000000000000000001011111",	-- instrucción 1226
	"000000000000000000000000001011111",	-- instrucción 1227
	"000000000000000000000000001011111",	-- instrucción 1228
	"000000000000000000000000001011111",	-- instrucción 1229
	"000000000000000000000000001011111",	-- instrucción 1230
	"000000000000000000000000001011111",	-- instrucción 1231
	"000000000000000000000000001011111",	-- instrucción 1232
	"000000000000000000000000001011111",	-- instrucción 1233
	"000000000000000000000000001011111",	-- instrucción 1234
	"000000000000000000000000001011111",	-- instrucción 1235
	"000000000000000000000000001011111",	-- instrucción 1236
	"000000000000000000000000001011111",	-- instrucción 1237
	"000000000000000000000000001011111",	-- instrucción 1238
	"000000000000000000000000001011111",	-- instrucción 1239
	"000000000000000000000000001011111",	-- instrucción 1240
	"000000000000000000000000001011111",	-- instrucción 1241
	"000000000000000000000000001011111",	-- instrucción 1242
	"000000000000000000000000001011111",	-- instrucción 1243
	"000000000000000000000000001011111",	-- instrucción 1244
	"000000000000000000000000001011111",	-- instrucción 1245
	"000000000000000000000000001011111",	-- instrucción 1246
	"000000000000000000000000001011111",	-- instrucción 1247
	"000000000000000000000000001011111",	-- instrucción 1248
	"000000000000000000000000001011111",	-- instrucción 1249
	"000000000000000000000000001011111",	-- instrucción 1250
	"000000000000000000000000001011111",	-- instrucción 1251
	"000000000000000000000000001011111",	-- instrucción 1252
	"000000000000000000000000001011111",	-- instrucción 1253
	"000000000000000000000000001011111",	-- instrucción 1254
	"000000000000000000000000001011111",	-- instrucción 1255
	"000000000000000000000000001011111",	-- instrucción 1256
	"000000000000000000000000001011111",	-- instrucción 1257
	"000000000000000000000000001011111",	-- instrucción 1258
	"000000000000000000000000001011111",	-- instrucción 1259
	"000000000000000000000000001011111",	-- instrucción 1260
	"000000000000000000000000001011111",	-- instrucción 1261
	"000000000000000000000000001011111",	-- instrucción 1262
	"000000000000000000000000001011111",	-- instrucción 1263
	"000000000000000000000000001011111",	-- instrucción 1264
	"000000000000000000000000001011111",	-- instrucción 1265
	"000000000000000000000000001011111",	-- instrucción 1266
	"000000000000000000000000001011111",	-- instrucción 1267
	"000000000000000000000000001011111",	-- instrucción 1268
	"000000000000000000000000001011111",	-- instrucción 1269
	"000000000000000000000000001011111",	-- instrucción 1270
	"000000000000000000000000001011111",	-- instrucción 1271
	"000000000000000000000000001011111",	-- instrucción 1272
	"000000000000000000000000001011111",	-- instrucción 1273
	"000000000000000000000000001011111",	-- instrucción 1274
	"000000000000000000000000001011111",	-- instrucción 1275
	"000000000000000000000000001011111",	-- instrucción 1276
	"000000000000000000000000001011111",	-- instrucción 1277
	"000000000000000000000000001011111",	-- instrucción 1278
	"000000000000000000000000001011111",	-- instrucción 1279
	"000000000000000000000000001011111",	-- instrucción 1280
	"000000000000000000000000001011111",	-- instrucción 1281
	"000000000000000000000000001011111",	-- instrucción 1282
	"000000000000000000000000001011111",	-- instrucción 1283
	"000000000000000000000000001011111",	-- instrucción 1284
	"000000000000000000000000001011111",	-- instrucción 1285
	"000000000000000000000000001011111",	-- instrucción 1286
	"000000000000000000000000001011111",	-- instrucción 1287
	"000000000000000000000000001011111",	-- instrucción 1288
	"000000000000000000000000001011111",	-- instrucción 1289
	"000000000000000000000000001011111",	-- instrucción 1290
	"000000000000000000000000001011111",	-- instrucción 1291
	"000000000000000000000000001011111",	-- instrucción 1292
	"000000000000000000000000001011111",	-- instrucción 1293
	"000000000000000000000000001011111",	-- instrucción 1294
	"000000000000000000000000001011111",	-- instrucción 1295
	"000000000000000000000000001011111",	-- instrucción 1296
	"000000000000000000000000001011111",	-- instrucción 1297
	"000000000000000000000000001011111",	-- instrucción 1298
	"000000000000000000000000001011111",	-- instrucción 1299
	"000000000000000000000000001011111",	-- instrucción 1300
	"000000000000000000000000001011111",	-- instrucción 1301
	"000000000000000000000000001011111",	-- instrucción 1302
	"000000000000000000000000001011111",	-- instrucción 1303
	"000000000000000000000000001011111",	-- instrucción 1304
	"000000000000000000000000001011111",	-- instrucción 1305
	"000000000000000000000000001011111",	-- instrucción 1306
	"000000000000000000000000001011111",	-- instrucción 1307
	"000000000000000000000000001011111",	-- instrucción 1308
	"000000000000000000000000001011111",	-- instrucción 1309
	"000000000000000000000000001011111",	-- instrucción 1310
	"000000000000000000000000001011111",	-- instrucción 1311
	"000000000000000000000000001011111",	-- instrucción 1312
	"000000000000000000000000001011111",	-- instrucción 1313
	"000000000000000000000000001011111",	-- instrucción 1314
	"000000000000000000000000001011111",	-- instrucción 1315
	"000000000000000000000000001011111",	-- instrucción 1316
	"000000000000000000000000001011111",	-- instrucción 1317
	"000000000000000000000000001011111",	-- instrucción 1318
	"000000000000000000000000001011111",	-- instrucción 1319
	"000000000000000000000000001011111",	-- instrucción 1320
	"000000000000000000000000001011111",	-- instrucción 1321
	"000000000000000000000000001011111",	-- instrucción 1322
	"000000000000000000000000001011111",	-- instrucción 1323
	"000000000000000000000000001011111",	-- instrucción 1324
	"000000000000000000000000001011111",	-- instrucción 1325
	"000000000000000000000000001011111",	-- instrucción 1326
	"000000000000000000000000001011111",	-- instrucción 1327
	"000000000000000000000000001011111",	-- instrucción 1328
	"000000000000000000000000001011111",	-- instrucción 1329
	"000000000000000000000000001011111",	-- instrucción 1330
	"000000000000000000000000001011111",	-- instrucción 1331
	"000000000000000000000000001011111",	-- instrucción 1332
	"000000000000000000000000001011111",	-- instrucción 1333
	"000000000000000000000000001011111",	-- instrucción 1334
	"000000000000000000000000001011111",	-- instrucción 1335
	"000000000000000000000000001011111",	-- instrucción 1336
	"000000000000000000000000001011111",	-- instrucción 1337
	"000000000000000000000000001011111",	-- instrucción 1338
	"000000000000000000000000001011111",	-- instrucción 1339
	"000000000000000000000000001011111",	-- instrucción 1340
	"000000000000000000000000001011111",	-- instrucción 1341
	"000000000000000000000000001011111",	-- instrucción 1342
	"000000000000000000000000001011111",	-- instrucción 1343
	"000000000000000000000000001011111",	-- instrucción 1344
	"000000000000000000000000001011111",	-- instrucción 1345
	"000000000000000000000000001011111",	-- instrucción 1346
	"000000000000000000000000001011111",	-- instrucción 1347
	"000000000000000000000000001011111",	-- instrucción 1348
	"000000000000000000000000001011111",	-- instrucción 1349
	"000000000000000000000000001011111",	-- instrucción 1350
	"000000000000000000000000001011111",	-- instrucción 1351
	"000000000000000000000000001011111",	-- instrucción 1352
	"000000000000000000000000001011111",	-- instrucción 1353
	"000000000000000000000000001011111",	-- instrucción 1354
	"000000000000000000000000001011111",	-- instrucción 1355
	"000000000000000000000000001011111",	-- instrucción 1356
	"000000000000000000000000001011111",	-- instrucción 1357
	"000000000000000000000000001011111",	-- instrucción 1358
	"000000000000000000000000001011111",	-- instrucción 1359
	"000000000000000000000000001011111",	-- instrucción 1360
	"000000000000000000000000001011111",	-- instrucción 1361
	"000000000000000000000000001011111",	-- instrucción 1362
	"000000000000000000000000001011111",	-- instrucción 1363
	"000000000000000000000000001011111",	-- instrucción 1364
	"000000000000000000000000001011111",	-- instrucción 1365
	"000000000000000000000000001011111",	-- instrucción 1366
	"000000000000000000000000001011111",	-- instrucción 1367
	"000000000000000000000000001011111",	-- instrucción 1368
	"000000000000000000000000001011111",	-- instrucción 1369
	"000000000000000000000000001011111",	-- instrucción 1370
	"000000000000000000000000001011111",	-- instrucción 1371
	"000000000000000000000000001011111",	-- instrucción 1372
	"000000000000000000000000001011111",	-- instrucción 1373
	"000000000000000000000000001011111",	-- instrucción 1374
	"000000000000000000000000001011111",	-- instrucción 1375
	"000000000000000000000000001011111",	-- instrucción 1376
	"000000000000000000000000001011111",	-- instrucción 1377
	"000000000000000000000000001011111",	-- instrucción 1378
	"000000000000000000000000001011111",	-- instrucción 1379
	"000000000000000000000000001011111",	-- instrucción 1380
	"000000000000000000000000001011111",	-- instrucción 1381
	"000000000000000000000000001011111",	-- instrucción 1382
	"000000000000000000000000001011111",	-- instrucción 1383
	"000000000000000000000000001011111",	-- instrucción 1384
	"000000000000000000000000001011111",	-- instrucción 1385
	"000000000000000000000000001011111",	-- instrucción 1386
	"000000000000000000000000001011111",	-- instrucción 1387
	"000000000000000000000000001011111",	-- instrucción 1388
	"000000000000000000000000001011111",	-- instrucción 1389
	"000000000000000000000000001011111",	-- instrucción 1390
	"000000000000000000000000001011111",	-- instrucción 1391
	"000000000000000000000000001011111",	-- instrucción 1392
	"000000000000000000000000001011111",	-- instrucción 1393
	"000000000000000000000000001011111",	-- instrucción 1394
	"000000000000000000000000001011111",	-- instrucción 1395
	"000000000000000000000000001011111",	-- instrucción 1396
	"000000000000000000000000001011111",	-- instrucción 1397
	"000000000000000000000000001011111",	-- instrucción 1398
	"000000000000000000000000001011111",	-- instrucción 1399
	"000000000000000000000000001011111",	-- instrucción 1400
	"000000000000000000000000001011111",	-- instrucción 1401
	"000000000000000000000000001011111",	-- instrucción 1402
	"000000000000000000000000001011111",	-- instrucción 1403
	"000000000000000000000000001011111",	-- instrucción 1404
	"000000000000000000000000001011111",	-- instrucción 1405
	"000000000000000000000000001011111",	-- instrucción 1406
	"000000000000000000000000001011111",	-- instrucción 1407
	"000000000000000000000000001011111",	-- instrucción 1408
	"000000000000000000000000001011111",	-- instrucción 1409
	"000000000000000000000000001011111",	-- instrucción 1410
	"000000000000000000000000001011111",	-- instrucción 1411
	"000000000000000000000000001011111",	-- instrucción 1412
	"000000000000000000000000001011111",	-- instrucción 1413
	"000000000000000000000000001011111",	-- instrucción 1414
	"000000000000000000000000001011111",	-- instrucción 1415
	"000000000000000000000000001011111",	-- instrucción 1416
	"000000000000000000000000001011111",	-- instrucción 1417
	"000000000000000000000000001011111",	-- instrucción 1418
	"000000000000000000000000001011111",	-- instrucción 1419
	"000000000000000000000000001011111",	-- instrucción 1420
	"000000000000000000000000001011111",	-- instrucción 1421
	"000000000000000000000000001011111",	-- instrucción 1422
	"000000000000000000000000001011111",	-- instrucción 1423
	"000000000000000000000000001011111",	-- instrucción 1424
	"000000000000000000000000001011111",	-- instrucción 1425
	"000000000000000000000000001011111",	-- instrucción 1426
	"000000000000000000000000001011111",	-- instrucción 1427
	"000000000000000000000000001011111",	-- instrucción 1428
	"000000000000000000000000001011111",	-- instrucción 1429
	"000000000000000000000000001011111",	-- instrucción 1430
	"000000000000000000000000001011111",	-- instrucción 1431
	"000000000000000000000000001011111",	-- instrucción 1432
	"000000000000000000000000001011111",	-- instrucción 1433
	"000000000000000000000000001011111",	-- instrucción 1434
	"000000000000000000000000001011111",	-- instrucción 1435
	"000000000000000000000000001011111",	-- instrucción 1436
	"000000000000000000000000001011111",	-- instrucción 1437
	"000000000000000000000000001011111",	-- instrucción 1438
	"000000000000000000000000001011111",	-- instrucción 1439
	"000000000000000000000000001011111",	-- instrucción 1440
	"000000000000000000000000001011111",	-- instrucción 1441
	"000000000000000000000000001011111",	-- instrucción 1442
	"000000000000000000000000001011111",	-- instrucción 1443
	"000000000000000000000000001011111",	-- instrucción 1444
	"000000000000000000000000001011111",	-- instrucción 1445
	"000000000000000000000000001011111",	-- instrucción 1446
	"000000000000000000000000001011111",	-- instrucción 1447
	"000000000000000000000000001011111",	-- instrucción 1448
	"000000000000000000000000001011111",	-- instrucción 1449
	"000000000000000000000000001011111",	-- instrucción 1450
	"000000000000000000000000001011111",	-- instrucción 1451
	"000000000000000000000000001011111",	-- instrucción 1452
	"000000000000000000000000001011111",	-- instrucción 1453
	"000000000000000000000000001011111",	-- instrucción 1454
	"000000000000000000000000001011111",	-- instrucción 1455
	"000000000000000000000000001011111",	-- instrucción 1456
	"000000000000000000000000001011111",	-- instrucción 1457
	"000000000000000000000000001011111",	-- instrucción 1458
	"000000000000000000000000001011111",	-- instrucción 1459
	"000000000000000000000000001011111",	-- instrucción 1460
	"000000000000000000000000001011111",	-- instrucción 1461
	"000000000000000000000000001011111",	-- instrucción 1462
	"000000000000000000000000001011111",	-- instrucción 1463
	"000000000000000000000000001011111",	-- instrucción 1464
	"000000000000000000000000001011111",	-- instrucción 1465
	"000000000000000000000000001011111",	-- instrucción 1466
	"000000000000000000000000001011111",	-- instrucción 1467
	"000000000000000000000000001011111",	-- instrucción 1468
	"000000000000000000000000001011111",	-- instrucción 1469
	"000000000000000000000000001011111",	-- instrucción 1470
	"000000000000000000000000001011111",	-- instrucción 1471
	"000000000000000000000000001011111",	-- instrucción 1472
	"000000000000000000000000001011111",	-- instrucción 1473
	"000000000000000000000000001011111",	-- instrucción 1474
	"000000000000000000000000001011111",	-- instrucción 1475
	"000000000000000000000000001011111",	-- instrucción 1476
	"000000000000000000000000001011111",	-- instrucción 1477
	"000000000000000000000000001011111",	-- instrucción 1478
	"000000000000000000000000001011111",	-- instrucción 1479
	"000000000000000000000000001011111",	-- instrucción 1480
	"000000000000000000000000001011111",	-- instrucción 1481
	"000000000000000000000000001011111",	-- instrucción 1482
	"000000000000000000000000001011111",	-- instrucción 1483
	"000000000000000000000000001011111",	-- instrucción 1484
	"000000000000000000000000001011111",	-- instrucción 1485
	"000000000000000000000000001011111",	-- instrucción 1486
	"000000000000000000000000001011111",	-- instrucción 1487
	"000000000000000000000000001011111",	-- instrucción 1488
	"000000000000000000000000001011111",	-- instrucción 1489
	"000000000000000000000000001011111",	-- instrucción 1490
	"000000000000000000000000001011111",	-- instrucción 1491
	"000000000000000000000000001011111",	-- instrucción 1492
	"000000000000000000000000001011111",	-- instrucción 1493
	"000000000000000000000000001011111",	-- instrucción 1494
	"000000000000000000000000001011111",	-- instrucción 1495
	"000000000000000000000000001011111",	-- instrucción 1496
	"000000000000000000000000001011111",	-- instrucción 1497
	"000000000000000000000000001011111",	-- instrucción 1498
	"000000000000000000000000001011111",	-- instrucción 1499
	"000000000000000000000000001011111",	-- instrucción 1500
	"000000000000000000000000001011111",	-- instrucción 1501
	"000000000000000000000000001011111",	-- instrucción 1502
	"000000000000000000000000001011111",	-- instrucción 1503
	"000000000000000000000000001011111",	-- instrucción 1504
	"000000000000000000000000001011111",	-- instrucción 1505
	"000000000000000000000000001011111",	-- instrucción 1506
	"000000000000000000000000001011111",	-- instrucción 1507
	"000000000000000000000000001011111",	-- instrucción 1508
	"000000000000000000000000001011111",	-- instrucción 1509
	"000000000000000000000000001011111",	-- instrucción 1510
	"000000000000000000000000001011111",	-- instrucción 1511
	"000000000000000000000000001011111",	-- instrucción 1512
	"000000000000000000000000001011111",	-- instrucción 1513
	"000000000000000000000000001011111",	-- instrucción 1514
	"000000000000000000000000001011111",	-- instrucción 1515
	"000000000000000000000000001011111",	-- instrucción 1516
	"000000000000000000000000001011111",	-- instrucción 1517
	"000000000000000000000000001011111",	-- instrucción 1518
	"000000000000000000000000001011111",	-- instrucción 1519
	"000000000000000000000000001011111",	-- instrucción 1520
	"000000000000000000000000001011111",	-- instrucción 1521
	"000000000000000000000000001011111",	-- instrucción 1522
	"000000000000000000000000001011111",	-- instrucción 1523
	"000000000000000000000000001011111",	-- instrucción 1524
	"000000000000000000000000001011111",	-- instrucción 1525
	"000000000000000000000000001011111",	-- instrucción 1526
	"000000000000000000000000001011111",	-- instrucción 1527
	"000000000000000000000000001011111",	-- instrucción 1528
	"000000000000000000000000001011111",	-- instrucción 1529
	"000000000000000000000000001011111",	-- instrucción 1530
	"000000000000000000000000001011111",	-- instrucción 1531
	"000000000000000000000000001011111",	-- instrucción 1532
	"000000000000000000000000001011111",	-- instrucción 1533
	"000000000000000000000000001011111",	-- instrucción 1534
	"000000000000000000000000001011111",	-- instrucción 1535
	"000000000000000000000000001011111",	-- instrucción 1536
	"000000000000000000000000001011111",	-- instrucción 1537
	"000000000000000000000000001011111",	-- instrucción 1538
	"000000000000000000000000001011111",	-- instrucción 1539
	"000000000000000000000000001011111",	-- instrucción 1540
	"000000000000000000000000001011111",	-- instrucción 1541
	"000000000000000000000000001011111",	-- instrucción 1542
	"000000000000000000000000001011111",	-- instrucción 1543
	"000000000000000000000000001011111",	-- instrucción 1544
	"000000000000000000000000001011111",	-- instrucción 1545
	"000000000000000000000000001011111",	-- instrucción 1546
	"000000000000000000000000001011111",	-- instrucción 1547
	"000000000000000000000000001011111",	-- instrucción 1548
	"000000000000000000000000001011111",	-- instrucción 1549
	"000000000000000000000000001011111",	-- instrucción 1550
	"000000000000000000000000001011111",	-- instrucción 1551
	"000000000000000000000000001011111",	-- instrucción 1552
	"000000000000000000000000001011111",	-- instrucción 1553
	"000000000000000000000000001011111",	-- instrucción 1554
	"000000000000000000000000001011111",	-- instrucción 1555
	"000000000000000000000000001011111",	-- instrucción 1556
	"000000000000000000000000001011111",	-- instrucción 1557
	"000000000000000000000000001011111",	-- instrucción 1558
	"000000000000000000000000001011111",	-- instrucción 1559
	"000000000000000000000000001011111",	-- instrucción 1560
	"000000000000000000000000001011111",	-- instrucción 1561
	"000000000000000000000000001011111",	-- instrucción 1562
	"000000000000000000000000001011111",	-- instrucción 1563
	"000000000000000000000000001011111",	-- instrucción 1564
	"000000000000000000000000001011111",	-- instrucción 1565
	"000000000000000000000000001011111",	-- instrucción 1566
	"000000000000000000000000001011111",	-- instrucción 1567
	"000000000000000000000000001011111",	-- instrucción 1568
	"000000000000000000000000001011111",	-- instrucción 1569
	"000000000000000000000000001011111",	-- instrucción 1570
	"000000000000000000000000001011111",	-- instrucción 1571
	"000000000000000000000000001011111",	-- instrucción 1572
	"000000000000000000000000001011111",	-- instrucción 1573
	"000000000000000000000000001011111",	-- instrucción 1574
	"000000000000000000000000001011111",	-- instrucción 1575
	"000000000000000000000000001011111",	-- instrucción 1576
	"000000000000000000000000001011111",	-- instrucción 1577
	"000000000000000000000000001011111",	-- instrucción 1578
	"000000000000000000000000001011111",	-- instrucción 1579
	"000000000000000000000000001011111",	-- instrucción 1580
	"000000000000000000000000001011111",	-- instrucción 1581
	"000000000000000000000000001011111",	-- instrucción 1582
	"000000000000000000000000001011111",	-- instrucción 1583
	"000000000000000000000000001011111",	-- instrucción 1584
	"000000000000000000000000001011111",	-- instrucción 1585
	"000000000000000000000000001011111",	-- instrucción 1586
	"000000000000000000000000001011111",	-- instrucción 1587
	"000000000000000000000000001011111",	-- instrucción 1588
	"000000000000000000000000001011111",	-- instrucción 1589
	"000000000000000000000000001011111",	-- instrucción 1590
	"000000000000000000000000001011111",	-- instrucción 1591
	"000000000000000000000000001011111",	-- instrucción 1592
	"000000000000000000000000001011111",	-- instrucción 1593
	"000000000000000000000000001011111",	-- instrucción 1594
	"000000000000000000000000001011111",	-- instrucción 1595
	"000000000000000000000000001011111",	-- instrucción 1596
	"000000000000000000000000001011111",	-- instrucción 1597
	"000000000000000000000000001011111",	-- instrucción 1598
	"000000000000000000000000001011111",	-- instrucción 1599
	"000000000000000000000000001011111",	-- instrucción 1600
	"000000000000000000000000001011111",	-- instrucción 1601
	"000000000000000000000000001011111",	-- instrucción 1602
	"000000000000000000000000001011111",	-- instrucción 1603
	"000000000000000000000000001011111",	-- instrucción 1604
	"000000000000000000000000001011111",	-- instrucción 1605
	"000000000000000000000000001011111",	-- instrucción 1606
	"000000000000000000000000001011111",	-- instrucción 1607
	"000000000000000000000000001011111",	-- instrucción 1608
	"000000000000000000000000001011111",	-- instrucción 1609
	"000000000000000000000000001011111",	-- instrucción 1610
	"000000000000000000000000001011111",	-- instrucción 1611
	"000000000000000000000000001011111",	-- instrucción 1612
	"000000000000000000000000001011111",	-- instrucción 1613
	"000000000000000000000000001011111",	-- instrucción 1614
	"000000000000000000000000001011111",	-- instrucción 1615
	"000000000000000000000000001011111",	-- instrucción 1616
	"000000000000000000000000001011111",	-- instrucción 1617
	"000000000000000000000000001011111",	-- instrucción 1618
	"000000000000000000000000001011111",	-- instrucción 1619
	"000000000000000000000000001011111",	-- instrucción 1620
	"000000000000000000000000001011111",	-- instrucción 1621
	"000000000000000000000000001011111",	-- instrucción 1622
	"000000000000000000000000001011111",	-- instrucción 1623
	"000000000000000000000000001011111",	-- instrucción 1624
	"000000000000000000000000001011111",	-- instrucción 1625
	"000000000000000000000000001011111",	-- instrucción 1626
	"000000000000000000000000001011111",	-- instrucción 1627
	"000000000000000000000000001011111",	-- instrucción 1628
	"000000000000000000000000001011111",	-- instrucción 1629
	"000000000000000000000000001011111",	-- instrucción 1630
	"000000000000000000000000001011111",	-- instrucción 1631
	"000000000000000000000000001011111",	-- instrucción 1632
	"000000000000000000000000001011111",	-- instrucción 1633
	"000000000000000000000000001011111",	-- instrucción 1634
	"000000000000000000000000001011111",	-- instrucción 1635
	"000000000000000000000000001011111",	-- instrucción 1636
	"000000000000000000000000001011111",	-- instrucción 1637
	"000000000000000000000000001011111",	-- instrucción 1638
	"000000000000000000000000001011111",	-- instrucción 1639
	"000000000000000000000000001011111",	-- instrucción 1640
	"000000000000000000000000001011111",	-- instrucción 1641
	"000000000000000000000000001011111",	-- instrucción 1642
	"000000000000000000000000001011111",	-- instrucción 1643
	"000000000000000000000000001011111",	-- instrucción 1644
	"000000000000000000000000001011111",	-- instrucción 1645
	"000000000000000000000000001011111",	-- instrucción 1646
	"000000000000000000000000001011111",	-- instrucción 1647
	"000000000000000000000000001011111",	-- instrucción 1648
	"000000000000000000000000001011111",	-- instrucción 1649
	"000000000000000000000000001011111",	-- instrucción 1650
	"000000000000000000000000001011111",	-- instrucción 1651
	"000000000000000000000000001011111",	-- instrucción 1652
	"000000000000000000000000001011111",	-- instrucción 1653
	"000000000000000000000000001011111",	-- instrucción 1654
	"000000000000000000000000001011111",	-- instrucción 1655
	"000000000000000000000000001011111",	-- instrucción 1656
	"000000000000000000000000001011111",	-- instrucción 1657
	"000000000000000000000000001011111",	-- instrucción 1658
	"000000000000000000000000001011111",	-- instrucción 1659
	"000000000000000000000000001011111",	-- instrucción 1660
	"000000000000000000000000001011111",	-- instrucción 1661
	"000000000000000000000000001011111",	-- instrucción 1662
	"000000000000000000000000001011111",	-- instrucción 1663
	"000000000000000000000000001011111",	-- instrucción 1664
	"000000000000000000000000001011111",	-- instrucción 1665
	"000000000000000000000000001011111",	-- instrucción 1666
	"000000000000000000000000001011111",	-- instrucción 1667
	"000000000000000000000000001011111",	-- instrucción 1668
	"000000000000000000000000001011111",	-- instrucción 1669
	"000000000000000000000000001011111",	-- instrucción 1670
	"000000000000000000000000001011111",	-- instrucción 1671
	"000000000000000000000000001011111",	-- instrucción 1672
	"000000000000000000000000001011111",	-- instrucción 1673
	"000000000000000000000000001011111",	-- instrucción 1674
	"000000000000000000000000001011111",	-- instrucción 1675
	"000000000000000000000000001011111",	-- instrucción 1676
	"000000000000000000000000001011111",	-- instrucción 1677
	"000000000000000000000000001011111",	-- instrucción 1678
	"000000000000000000000000001011111",	-- instrucción 1679
	"000000000000000000000000001011111",	-- instrucción 1680
	"000000000000000000000000001011111",	-- instrucción 1681
	"000000000000000000000000001011111",	-- instrucción 1682
	"000000000000000000000000001011111",	-- instrucción 1683
	"000000000000000000000000001011111",	-- instrucción 1684
	"000000000000000000000000001011111",	-- instrucción 1685
	"000000000000000000000000001011111",	-- instrucción 1686
	"000000000000000000000000001011111",	-- instrucción 1687
	"000000000000000000000000001011111",	-- instrucción 1688
	"000000000000000000000000001011111",	-- instrucción 1689
	"000000000000000000000000001011111",	-- instrucción 1690
	"000000000000000000000000001011111",	-- instrucción 1691
	"000000000000000000000000001011111",	-- instrucción 1692
	"000000000000000000000000001011111",	-- instrucción 1693
	"000000000000000000000000001011111",	-- instrucción 1694
	"000000000000000000000000001011111",	-- instrucción 1695
	"000000000000000000000000001011111",	-- instrucción 1696
	"000000000000000000000000001011111",	-- instrucción 1697
	"000000000000000000000000001011111",	-- instrucción 1698
	"000000000000000000000000001011111",	-- instrucción 1699
	"000000000000000000000000001011111",	-- instrucción 1700
	"000000000000000000000000001011111",	-- instrucción 1701
	"000000000000000000000000001011111",	-- instrucción 1702
	"000000000000000000000000001011111",	-- instrucción 1703
	"000000000000000000000000001011111",	-- instrucción 1704
	"000000000000000000000000001011111",	-- instrucción 1705
	"000000000000000000000000001011111",	-- instrucción 1706
	"000000000000000000000000001011111",	-- instrucción 1707
	"000000000000000000000000001011111",	-- instrucción 1708
	"000000000000000000000000001011111",	-- instrucción 1709
	"000000000000000000000000001011111",	-- instrucción 1710
	"000000000000000000000000001011111",	-- instrucción 1711
	"000000000000000000000000001011111",	-- instrucción 1712
	"000000000000000000000000001011111",	-- instrucción 1713
	"000000000000000000000000001011111",	-- instrucción 1714
	"000000000000000000000000001011111",	-- instrucción 1715
	"000000000000000000000000001011111",	-- instrucción 1716
	"000000000000000000000000001011111",	-- instrucción 1717
	"000000000000000000000000001011111",	-- instrucción 1718
	"000000000000000000000000001011111",	-- instrucción 1719
	"000000000000000000000000001011111",	-- instrucción 1720
	"000000000000000000000000001011111",	-- instrucción 1721
	"000000000000000000000000001011111",	-- instrucción 1722
	"000000000000000000000000001011111",	-- instrucción 1723
	"000000000000000000000000001011111",	-- instrucción 1724
	"000000000000000000000000001011111",	-- instrucción 1725
	"000000000000000000000000001011111",	-- instrucción 1726
	"000000000000000000000000001011111",	-- instrucción 1727
	"000000000000000000000000001011111",	-- instrucción 1728
	"000000000000000000000000001011111",	-- instrucción 1729
	"000000000000000000000000001011111",	-- instrucción 1730
	"000000000000000000000000001011111",	-- instrucción 1731
	"000000000000000000000000001011111",	-- instrucción 1732
	"000000000000000000000000001011111",	-- instrucción 1733
	"000000000000000000000000001011111",	-- instrucción 1734
	"000000000000000000000000001011111",	-- instrucción 1735
	"000000000000000000000000001011111",	-- instrucción 1736
	"000000000000000000000000001011111",	-- instrucción 1737
	"000000000000000000000000001011111",	-- instrucción 1738
	"000000000000000000000000001011111",	-- instrucción 1739
	"000000000000000000000000001011111",	-- instrucción 1740
	"000000000000000000000000001011111",	-- instrucción 1741
	"000000000000000000000000001011111",	-- instrucción 1742
	"000000000000000000000000001011111",	-- instrucción 1743
	"000000000000000000000000001011111",	-- instrucción 1744
	"000000000000000000000000001011111",	-- instrucción 1745
	"000000000000000000000000001011111",	-- instrucción 1746
	"000000000000000000000000001011111",	-- instrucción 1747
	"000000000000000000000000001011111",	-- instrucción 1748
	"000000000000000000000000001011111",	-- instrucción 1749
	"000000000000000000000000001011111",	-- instrucción 1750
	"000000000000000000000000001011111",	-- instrucción 1751
	"000000000000000000000000001011111",	-- instrucción 1752
	"000000000000000000000000001011111",	-- instrucción 1753
	"000000000000000000000000001011111",	-- instrucción 1754
	"000000000000000000000000001011111",	-- instrucción 1755
	"000000000000000000000000001011111",	-- instrucción 1756
	"000000000000000000000000001011111",	-- instrucción 1757
	"000000000000000000000000001011111",	-- instrucción 1758
	"000000000000000000000000001011111",	-- instrucción 1759
	"000000000000000000000000001011111",	-- instrucción 1760
	"000000000000000000000000001011111",	-- instrucción 1761
	"000000000000000000000000001011111",	-- instrucción 1762
	"000000000000000000000000001011111",	-- instrucción 1763
	"000000000000000000000000001011111",	-- instrucción 1764
	"000000000000000000000000001011111",	-- instrucción 1765
	"000000000000000000000000001011111",	-- instrucción 1766
	"000000000000000000000000001011111",	-- instrucción 1767
	"000000000000000000000000001011111",	-- instrucción 1768
	"000000000000000000000000001011111",	-- instrucción 1769
	"000000000000000000000000001011111",	-- instrucción 1770
	"000000000000000000000000001011111",	-- instrucción 1771
	"000000000000000000000000001011111",	-- instrucción 1772
	"000000000000000000000000001011111",	-- instrucción 1773
	"000000000000000000000000001011111",	-- instrucción 1774
	"000000000000000000000000001011111",	-- instrucción 1775
	"000000000000000000000000001011111",	-- instrucción 1776
	"000000000000000000000000001011111",	-- instrucción 1777
	"000000000000000000000000001011111",	-- instrucción 1778
	"000000000000000000000000001011111",	-- instrucción 1779
	"000000000000000000000000001011111",	-- instrucción 1780
	"000000000000000000000000001011111",	-- instrucción 1781
	"000000000000000000000000001011111",	-- instrucción 1782
	"000000000000000000000000001011111",	-- instrucción 1783
	"000000000000000000000000001011111",	-- instrucción 1784
	"000000000000000000000000001011111",	-- instrucción 1785
	"000000000000000000000000001011111",	-- instrucción 1786
	"000000000000000000000000001011111",	-- instrucción 1787
	"000000000000000000000000001011111",	-- instrucción 1788
	"000000000000000000000000001011111",	-- instrucción 1789
	"000000000000000000000000001011111",	-- instrucción 1790
	"000000000000000000000000001011111",	-- instrucción 1791
	"000000000000000000000000001011111",	-- instrucción 1792
	"000000000000000000000000001011111",	-- instrucción 1793
	"000000000000000000000000001011111",	-- instrucción 1794
	"000000000000000000000000001011111",	-- instrucción 1795
	"000000000000000000000000001011111",	-- instrucción 1796
	"000000000000000000000000001011111",	-- instrucción 1797
	"000000000000000000000000001011111",	-- instrucción 1798
	"000000000000000000000000001011111",	-- instrucción 1799
	"000000000000000000000000001011111",	-- instrucción 1800
	"000000000000000000000000001011111",	-- instrucción 1801
	"000000000000000000000000001011111",	-- instrucción 1802
	"000000000000000000000000001011111",	-- instrucción 1803
	"000000000000000000000000001011111",	-- instrucción 1804
	"000000000000000000000000001011111",	-- instrucción 1805
	"000000000000000000000000001011111",	-- instrucción 1806
	"000000000000000000000000001011111",	-- instrucción 1807
	"000000000000000000000000001011111",	-- instrucción 1808
	"000000000000000000000000001011111",	-- instrucción 1809
	"000000000000000000000000001011111",	-- instrucción 1810
	"000000000000000000000000001011111",	-- instrucción 1811
	"000000000000000000000000001011111",	-- instrucción 1812
	"000000000000000000000000001011111",	-- instrucción 1813
	"000000000000000000000000001011111",	-- instrucción 1814
	"000000000000000000000000001011111",	-- instrucción 1815
	"000000000000000000000000001011111",	-- instrucción 1816
	"000000000000000000000000001011111",	-- instrucción 1817
	"000000000000000000000000001011111",	-- instrucción 1818
	"000000000000000000000000001011111",	-- instrucción 1819
	"000000000000000000000000001011111",	-- instrucción 1820
	"000000000000000000000000001011111",	-- instrucción 1821
	"000000000000000000000000001011111",	-- instrucción 1822
	"000000000000000000000000001011111",	-- instrucción 1823
	"000000000000000000000000001011111",	-- instrucción 1824
	"000000000000000000000000001011111",	-- instrucción 1825
	"000000000000000000000000001011111",	-- instrucción 1826
	"000000000000000000000000001011111",	-- instrucción 1827
	"000000000000000000000000001011111",	-- instrucción 1828
	"000000000000000000000000001011111",	-- instrucción 1829
	"000000000000000000000000001011111",	-- instrucción 1830
	"000000000000000000000000001011111",	-- instrucción 1831
	"000000000000000000000000001011111",	-- instrucción 1832
	"000000000000000000000000001011111",	-- instrucción 1833
	"000000000000000000000000001011111",	-- instrucción 1834
	"000000000000000000000000001011111",	-- instrucción 1835
	"000000000000000000000000001011111",	-- instrucción 1836
	"000000000000000000000000001011111",	-- instrucción 1837
	"000000000000000000000000001011111",	-- instrucción 1838
	"000000000000000000000000001011111",	-- instrucción 1839
	"000000000000000000000000001011111",	-- instrucción 1840
	"000000000000000000000000001011111",	-- instrucción 1841
	"000000000000000000000000001011111",	-- instrucción 1842
	"000000000000000000000000001011111",	-- instrucción 1843
	"000000000000000000000000001011111",	-- instrucción 1844
	"000000000000000000000000001011111",	-- instrucción 1845
	"000000000000000000000000001011111",	-- instrucción 1846
	"000000000000000000000000001011111",	-- instrucción 1847
	"000000000000000000000000001011111",	-- instrucción 1848
	"000000000000000000000000001011111",	-- instrucción 1849
	"000000000000000000000000001011111",	-- instrucción 1850
	"000000000000000000000000001011111",	-- instrucción 1851
	"000000000000000000000000001011111",	-- instrucción 1852
	"000000000000000000000000001011111",	-- instrucción 1853
	"000000000000000000000000001011111",	-- instrucción 1854
	"000000000000000000000000001011111",	-- instrucción 1855
	"000000000000000000000000001011111",	-- instrucción 1856
	"000000000000000000000000001011111",	-- instrucción 1857
	"000000000000000000000000001011111",	-- instrucción 1858
	"000000000000000000000000001011111",	-- instrucción 1859
	"000000000000000000000000001011111",	-- instrucción 1860
	"000000000000000000000000001011111",	-- instrucción 1861
	"000000000000000000000000001011111",	-- instrucción 1862
	"000000000000000000000000001011111",	-- instrucción 1863
	"000000000000000000000000001011111",	-- instrucción 1864
	"000000000000000000000000001011111",	-- instrucción 1865
	"000000000000000000000000001011111",	-- instrucción 1866
	"000000000000000000000000001011111",	-- instrucción 1867
	"000000000000000000000000001011111",	-- instrucción 1868
	"000000000000000000000000001011111",	-- instrucción 1869
	"000000000000000000000000001011111",	-- instrucción 1870
	"000000000000000000000000001011111",	-- instrucción 1871
	"000000000000000000000000001011111",	-- instrucción 1872
	"000000000000000000000000001011111",	-- instrucción 1873
	"000000000000000000000000001011111",	-- instrucción 1874
	"000000000000000000000000001011111",	-- instrucción 1875
	"000000000000000000000000001011111",	-- instrucción 1876
	"000000000000000000000000001011111",	-- instrucción 1877
	"000000000000000000000000001011111",	-- instrucción 1878
	"000000000000000000000000001011111",	-- instrucción 1879
	"000000000000000000000000001011111",	-- instrucción 1880
	"000000000000000000000000001011111",	-- instrucción 1881
	"000000000000000000000000001011111",	-- instrucción 1882
	"000000000000000000000000001011111",	-- instrucción 1883
	"000000000000000000000000001011111",	-- instrucción 1884
	"000000000000000000000000001011111",	-- instrucción 1885
	"000000000000000000000000001011111",	-- instrucción 1886
	"000000000000000000000000001011111",	-- instrucción 1887
	"000000000000000000000000001011111",	-- instrucción 1888
	"000000000000000000000000001011111",	-- instrucción 1889
	"000000000000000000000000001011111",	-- instrucción 1890
	"000000000000000000000000001011111",	-- instrucción 1891
	"000000000000000000000000001011111",	-- instrucción 1892
	"000000000000000000000000001011111",	-- instrucción 1893
	"000000000000000000000000001011111",	-- instrucción 1894
	"000000000000000000000000001011111",	-- instrucción 1895
	"000000000000000000000000001011111",	-- instrucción 1896
	"000000000000000000000000001011111",	-- instrucción 1897
	"000000000000000000000000001011111",	-- instrucción 1898
	"000000000000000000000000001011111",	-- instrucción 1899
	"000000000000000000000000001011111",	-- instrucción 1900
	"000000000000000000000000001011111",	-- instrucción 1901
	"000000000000000000000000001011111",	-- instrucción 1902
	"000000000000000000000000001011111",	-- instrucción 1903
	"000000000000000000000000001011111",	-- instrucción 1904
	"000000000000000000000000001011111",	-- instrucción 1905
	"000000000000000000000000001011111",	-- instrucción 1906
	"000000000000000000000000001011111",	-- instrucción 1907
	"000000000000000000000000001011111",	-- instrucción 1908
	"000000000000000000000000001011111",	-- instrucción 1909
	"000000000000000000000000001011111",	-- instrucción 1910
	"000000000000000000000000001011111",	-- instrucción 1911
	"000000000000000000000000001011111",	-- instrucción 1912
	"000000000000000000000000001011111",	-- instrucción 1913
	"000000000000000000000000001011111",	-- instrucción 1914
	"000000000000000000000000001011111",	-- instrucción 1915
	"000000000000000000000000001011111",	-- instrucción 1916
	"000000000000000000000000001011111",	-- instrucción 1917
	"000000000000000000000000001011111",	-- instrucción 1918
	"000000000000000000000000001011111",	-- instrucción 1919
	"000000000000000000000000001011111",	-- instrucción 1920
	"000000000000000000000000001011111",	-- instrucción 1921
	"000000000000000000000000001011111",	-- instrucción 1922
	"000000000000000000000000001011111",	-- instrucción 1923
	"000000000000000000000000001011111",	-- instrucción 1924
	"000000000000000000000000001011111",	-- instrucción 1925
	"000000000000000000000000001011111",	-- instrucción 1926
	"000000000000000000000000001011111",	-- instrucción 1927
	"000000000000000000000000001011111",	-- instrucción 1928
	"000000000000000000000000001011111",	-- instrucción 1929
	"000000000000000000000000001011111",	-- instrucción 1930
	"000000000000000000000000001011111",	-- instrucción 1931
	"000000000000000000000000001011111",	-- instrucción 1932
	"000000000000000000000000001011111",	-- instrucción 1933
	"000000000000000000000000001011111",	-- instrucción 1934
	"000000000000000000000000001011111",	-- instrucción 1935
	"000000000000000000000000001011111",	-- instrucción 1936
	"000000000000000000000000001011111",	-- instrucción 1937
	"000000000000000000000000001011111",	-- instrucción 1938
	"000000000000000000000000001011111",	-- instrucción 1939
	"000000000000000000000000001011111",	-- instrucción 1940
	"000000000000000000000000001011111",	-- instrucción 1941
	"000000000000000000000000001011111",	-- instrucción 1942
	"000000000000000000000000001011111",	-- instrucción 1943
	"000000000000000000000000001011111",	-- instrucción 1944
	"000000000000000000000000001011111",	-- instrucción 1945
	"000000000000000000000000001011111",	-- instrucción 1946
	"000000000000000000000000001011111",	-- instrucción 1947
	"000000000000000000000000001011111",	-- instrucción 1948
	"000000000000000000000000001011111",	-- instrucción 1949
	"000000000000000000000000001011111",	-- instrucción 1950
	"000000000000000000000000001011111",	-- instrucción 1951
	"000000000000000000000000001011111",	-- instrucción 1952
	"000000000000000000000000001011111",	-- instrucción 1953
	"000000000000000000000000001011111",	-- instrucción 1954
	"000000000000000000000000001011111",	-- instrucción 1955
	"000000000000000000000000001011111",	-- instrucción 1956
	"000000000000000000000000001011111",	-- instrucción 1957
	"000000000000000000000000001011111",	-- instrucción 1958
	"000000000000000000000000001011111",	-- instrucción 1959
	"000000000000000000000000001011111",	-- instrucción 1960
	"000000000000000000000000001011111",	-- instrucción 1961
	"000000000000000000000000001011111",	-- instrucción 1962
	"000000000000000000000000001011111",	-- instrucción 1963
	"000000000000000000000000001011111",	-- instrucción 1964
	"000000000000000000000000001011111",	-- instrucción 1965
	"000000000000000000000000001011111",	-- instrucción 1966
	"000000000000000000000000001011111",	-- instrucción 1967
	"000000000000000000000000001011111",	-- instrucción 1968
	"000000000000000000000000001011111",	-- instrucción 1969
	"000000000000000000000000001011111",	-- instrucción 1970
	"000000000000000000000000001011111",	-- instrucción 1971
	"000000000000000000000000001011111",	-- instrucción 1972
	"000000000000000000000000001011111",	-- instrucción 1973
	"000000000000000000000000001011111",	-- instrucción 1974
	"000000000000000000000000001011111",	-- instrucción 1975
	"000000000000000000000000001011111",	-- instrucción 1976
	"000000000000000000000000001011111",	-- instrucción 1977
	"000000000000000000000000001011111",	-- instrucción 1978
	"000000000000000000000000001011111",	-- instrucción 1979
	"000000000000000000000000001011111",	-- instrucción 1980
	"000000000000000000000000001011111",	-- instrucción 1981
	"000000000000000000000000001011111",	-- instrucción 1982
	"000000000000000000000000001011111",	-- instrucción 1983
	"000000000000000000000000001011111",	-- instrucción 1984
	"000000000000000000000000001011111",	-- instrucción 1985
	"000000000000000000000000001011111",	-- instrucción 1986
	"000000000000000000000000001011111",	-- instrucción 1987
	"000000000000000000000000001011111",	-- instrucción 1988
	"000000000000000000000000001011111",	-- instrucción 1989
	"000000000000000000000000001011111",	-- instrucción 1990
	"000000000000000000000000001011111",	-- instrucción 1991
	"000000000000000000000000001011111",	-- instrucción 1992
	"000000000000000000000000001011111",	-- instrucción 1993
	"000000000000000000000000001011111",	-- instrucción 1994
	"000000000000000000000000001011111",	-- instrucción 1995
	"000000000000000000000000001011111",	-- instrucción 1996
	"000000000000000000000000001011111",	-- instrucción 1997
	"000000000000000000000000001011111",	-- instrucción 1998
	"000000000000000000000000001011111",	-- instrucción 1999
	"000000000000000000000000001011111",	-- instrucción 2000
	"000000000000000000000000001011111",	-- instrucción 2001
	"000000000000000000000000001011111",	-- instrucción 2002
	"000000000000000000000000001011111",	-- instrucción 2003
	"000000000000000000000000001011111",	-- instrucción 2004
	"000000000000000000000000001011111",	-- instrucción 2005
	"000000000000000000000000001011111",	-- instrucción 2006
	"000000000000000000000000001011111",	-- instrucción 2007
	"000000000000000000000000001011111",	-- instrucción 2008
	"000000000000000000000000001011111",	-- instrucción 2009
	"000000000000000000000000001011111",	-- instrucción 2010
	"000000000000000000000000001011111",	-- instrucción 2011
	"000000000000000000000000001011111",	-- instrucción 2012
	"000000000000000000000000001011111",	-- instrucción 2013
	"000000000000000000000000001011111",	-- instrucción 2014
	"000000000000000000000000001011111",	-- instrucción 2015
	"000000000000000000000000001011111",	-- instrucción 2016
	"000000000000000000000000001011111",	-- instrucción 2017
	"000000000000000000000000001011111",	-- instrucción 2018
	"000000000000000000000000001011111",	-- instrucción 2019
	"000000000000000000000000001011111",	-- instrucción 2020
	"000000000000000000000000001011111",	-- instrucción 2021
	"000000000000000000000000001011111",	-- instrucción 2022
	"000000000000000000000000001011111",	-- instrucción 2023
	"000000000000000000000000001011111",	-- instrucción 2024
	"000000000000000000000000001011111",	-- instrucción 2025
	"000000000000000000000000001011111",	-- instrucción 2026
	"000000000000000000000000001011111",	-- instrucción 2027
	"000000000000000000000000001011111",	-- instrucción 2028
	"000000000000000000000000001011111",	-- instrucción 2029
	"000000000000000000000000001011111",	-- instrucción 2030
	"000000000000000000000000001011111",	-- instrucción 2031
	"000000000000000000000000001011111",	-- instrucción 2032
	"000000000000000000000000001011111",	-- instrucción 2033
	"000000000000000000000000001011111",	-- instrucción 2034
	"000000000000000000000000001011111",	-- instrucción 2035
	"000000000000000000000000001011111",	-- instrucción 2036
	"000000000000000000000000001011111",	-- instrucción 2037
	"000000000000000000000000001011111",	-- instrucción 2038
	"000000000000000000000000001011111",	-- instrucción 2039
	"000000000000000000000000001011111",	-- instrucción 2040
	"000000000000000000000000001011111",	-- instrucción 2041
	"000000000000000000000000001011111",	-- instrucción 2042
	"000000000000000000000000001011111",	-- instrucción 2043
	"000000000000000000000000001011111",	-- instrucción 2044
	"000000000000000000000000001011111",	-- instrucción 2045
	"000000000000000000000000001011111",	-- instrucción 2046
	"000000000000000000000000001011111",	-- instrucción 2047
	"000000000000000000000000001011111",	-- instrucción 2048
	"000000000000000000000000001011111",	-- instrucción 2049
	"000000000000000000000000001011111",	-- instrucción 2050
	"000000000000000000000000001011111",	-- instrucción 2051
	"000000000000000000000000001011111",	-- instrucción 2052
	"000000000000000000000000001011111",	-- instrucción 2053
	"000000000000000000000000001011111",	-- instrucción 2054
	"000000000000000000000000001011111",	-- instrucción 2055
	"000000000000000000000000001011111",	-- instrucción 2056
	"000000000000000000000000001011111",	-- instrucción 2057
	"000000000000000000000000001011111",	-- instrucción 2058
	"000000000000000000000000001011111",	-- instrucción 2059
	"000000000000000000000000001011111",	-- instrucción 2060
	"000000000000000000000000001011111",	-- instrucción 2061
	"000000000000000000000000001011111",	-- instrucción 2062
	"000000000000000000000000001011111",	-- instrucción 2063
	"000000000000000000000000001011111",	-- instrucción 2064
	"000000000000000000000000001011111",	-- instrucción 2065
	"000000000000000000000000001011111",	-- instrucción 2066
	"000000000000000000000000001011111",	-- instrucción 2067
	"000000000000000000000000001011111",	-- instrucción 2068
	"000000000000000000000000001011111",	-- instrucción 2069
	"000000000000000000000000001011111",	-- instrucción 2070
	"000000000000000000000000001011111",	-- instrucción 2071
	"000000000000000000000000001011111",	-- instrucción 2072
	"000000000000000000000000001011111",	-- instrucción 2073
	"000000000000000000000000001011111",	-- instrucción 2074
	"000000000000000000000000001011111",	-- instrucción 2075
	"000000000000000000000000001011111",	-- instrucción 2076
	"000000000000000000000000001011111",	-- instrucción 2077
	"000000000000000000000000001011111",	-- instrucción 2078
	"000000000000000000000000001011111",	-- instrucción 2079
	"000000000000000000000000001011111",	-- instrucción 2080
	"000000000000000000000000001011111",	-- instrucción 2081
	"000000000000000000000000001011111",	-- instrucción 2082
	"000000000000000000000000001011111",	-- instrucción 2083
	"000000000000000000000000001011111",	-- instrucción 2084
	"000000000000000000000000001011111",	-- instrucción 2085
	"000000000000000000000000001011111",	-- instrucción 2086
	"000000000000000000000000001011111",	-- instrucción 2087
	"000000000000000000000000001011111",	-- instrucción 2088
	"000000000000000000000000001011111",	-- instrucción 2089
	"000000000000000000000000001011111",	-- instrucción 2090
	"000000000000000000000000001011111",	-- instrucción 2091
	"000000000000000000000000001011111",	-- instrucción 2092
	"000000000000000000000000001011111",	-- instrucción 2093
	"000000000000000000000000001011111",	-- instrucción 2094
	"000000000000000000000000001011111",	-- instrucción 2095
	"000000000000000000000000001011111",	-- instrucción 2096
	"000000000000000000000000001011111",	-- instrucción 2097
	"000000000000000000000000001011111",	-- instrucción 2098
	"000000000000000000000000001011111",	-- instrucción 2099
	"000000000000000000000000001011111",	-- instrucción 2100
	"000000000000000000000000001011111",	-- instrucción 2101
	"000000000000000000000000001011111",	-- instrucción 2102
	"000000000000000000000000001011111",	-- instrucción 2103
	"000000000000000000000000001011111",	-- instrucción 2104
	"000000000000000000000000001011111",	-- instrucción 2105
	"000000000000000000000000001011111",	-- instrucción 2106
	"000000000000000000000000001011111",	-- instrucción 2107
	"000000000000000000000000001011111",	-- instrucción 2108
	"000000000000000000000000001011111",	-- instrucción 2109
	"000000000000000000000000001011111",	-- instrucción 2110
	"000000000000000000000000001011111",	-- instrucción 2111
	"000000000000000000000000001011111",	-- instrucción 2112
	"000000000000000000000000001011111",	-- instrucción 2113
	"000000000000000000000000001011111",	-- instrucción 2114
	"000000000000000000000000001011111",	-- instrucción 2115
	"000000000000000000000000001011111",	-- instrucción 2116
	"000000000000000000000000001011111",	-- instrucción 2117
	"000000000000000000000000001011111",	-- instrucción 2118
	"000000000000000000000000001011111",	-- instrucción 2119
	"000000000000000000000000001011111",	-- instrucción 2120
	"000000000000000000000000001011111",	-- instrucción 2121
	"000000000000000000000000001011111",	-- instrucción 2122
	"000000000000000000000000001011111",	-- instrucción 2123
	"000000000000000000000000001011111",	-- instrucción 2124
	"000000000000000000000000001011111",	-- instrucción 2125
	"000000000000000000000000001011111",	-- instrucción 2126
	"000000000000000000000000001011111",	-- instrucción 2127
	"000000000000000000000000001011111",	-- instrucción 2128
	"000000000000000000000000001011111",	-- instrucción 2129
	"000000000000000000000000001011111",	-- instrucción 2130
	"000000000000000000000000001011111",	-- instrucción 2131
	"000000000000000000000000001011111",	-- instrucción 2132
	"000000000000000000000000001011111",	-- instrucción 2133
	"000000000000000000000000001011111",	-- instrucción 2134
	"000000000000000000000000001011111",	-- instrucción 2135
	"000000000000000000000000001011111",	-- instrucción 2136
	"000000000000000000000000001011111",	-- instrucción 2137
	"000000000000000000000000001011111",	-- instrucción 2138
	"000000000000000000000000001011111",	-- instrucción 2139
	"000000000000000000000000001011111",	-- instrucción 2140
	"000000000000000000000000001011111",	-- instrucción 2141
	"000000000000000000000000001011111",	-- instrucción 2142
	"000000000000000000000000001011111",	-- instrucción 2143
	"000000000000000000000000001011111",	-- instrucción 2144
	"000000000000000000000000001011111",	-- instrucción 2145
	"000000000000000000000000001011111",	-- instrucción 2146
	"000000000000000000000000001011111",	-- instrucción 2147
	"000000000000000000000000001011111",	-- instrucción 2148
	"000000000000000000000000001011111",	-- instrucción 2149
	"000000000000000000000000001011111",	-- instrucción 2150
	"000000000000000000000000001011111",	-- instrucción 2151
	"000000000000000000000000001011111",	-- instrucción 2152
	"000000000000000000000000001011111",	-- instrucción 2153
	"000000000000000000000000001011111",	-- instrucción 2154
	"000000000000000000000000001011111",	-- instrucción 2155
	"000000000000000000000000001011111",	-- instrucción 2156
	"000000000000000000000000001011111",	-- instrucción 2157
	"000000000000000000000000001011111",	-- instrucción 2158
	"000000000000000000000000001011111",	-- instrucción 2159
	"000000000000000000000000001011111",	-- instrucción 2160
	"000000000000000000000000001011111",	-- instrucción 2161
	"000000000000000000000000001011111",	-- instrucción 2162
	"000000000000000000000000001011111",	-- instrucción 2163
	"000000000000000000000000001011111",	-- instrucción 2164
	"000000000000000000000000001011111",	-- instrucción 2165
	"000000000000000000000000001011111",	-- instrucción 2166
	"000000000000000000000000001011111",	-- instrucción 2167
	"000000000000000000000000001011111",	-- instrucción 2168
	"000000000000000000000000001011111",	-- instrucción 2169
	"000000000000000000000000001011111",	-- instrucción 2170
	"000000000000000000000000001011111",	-- instrucción 2171
	"000000000000000000000000001011111",	-- instrucción 2172
	"000000000000000000000000001011111",	-- instrucción 2173
	"000000000000000000000000001011111",	-- instrucción 2174
	"000000000000000000000000001011111",	-- instrucción 2175
	"000000000000000000000000001011111",	-- instrucción 2176
	"000000000000000000000000001011111",	-- instrucción 2177
	"000000000000000000000000001011111",	-- instrucción 2178
	"000000000000000000000000001011111",	-- instrucción 2179
	"000000000000000000000000001011111",	-- instrucción 2180
	"000000000000000000000000001011111",	-- instrucción 2181
	"000000000000000000000000001011111",	-- instrucción 2182
	"000000000000000000000000001011111",	-- instrucción 2183
	"000000000000000000000000001011111",	-- instrucción 2184
	"000000000000000000000000001011111",	-- instrucción 2185
	"000000000000000000000000001011111",	-- instrucción 2186
	"000000000000000000000000001011111",	-- instrucción 2187
	"000000000000000000000000001011111",	-- instrucción 2188
	"000000000000000000000000001011111",	-- instrucción 2189
	"000000000000000000000000001011111",	-- instrucción 2190
	"000000000000000000000000001011111",	-- instrucción 2191
	"000000000000000000000000001011111",	-- instrucción 2192
	"000000000000000000000000001011111",	-- instrucción 2193
	"000000000000000000000000001011111",	-- instrucción 2194
	"000000000000000000000000001011111",	-- instrucción 2195
	"000000000000000000000000001011111",	-- instrucción 2196
	"000000000000000000000000001011111",	-- instrucción 2197
	"000000000000000000000000001011111",	-- instrucción 2198
	"000000000000000000000000001011111",	-- instrucción 2199
	"000000000000000000000000001011111",	-- instrucción 2200
	"000000000000000000000000001011111",	-- instrucción 2201
	"000000000000000000000000001011111",	-- instrucción 2202
	"000000000000000000000000001011111",	-- instrucción 2203
	"000000000000000000000000001011111",	-- instrucción 2204
	"000000000000000000000000001011111",	-- instrucción 2205
	"000000000000000000000000001011111",	-- instrucción 2206
	"000000000000000000000000001011111",	-- instrucción 2207
	"000000000000000000000000001011111",	-- instrucción 2208
	"000000000000000000000000001011111",	-- instrucción 2209
	"000000000000000000000000001011111",	-- instrucción 2210
	"000000000000000000000000001011111",	-- instrucción 2211
	"000000000000000000000000001011111",	-- instrucción 2212
	"000000000000000000000000001011111",	-- instrucción 2213
	"000000000000000000000000001011111",	-- instrucción 2214
	"000000000000000000000000001011111",	-- instrucción 2215
	"000000000000000000000000001011111",	-- instrucción 2216
	"000000000000000000000000001011111",	-- instrucción 2217
	"000000000000000000000000001011111",	-- instrucción 2218
	"000000000000000000000000001011111",	-- instrucción 2219
	"000000000000000000000000001011111",	-- instrucción 2220
	"000000000000000000000000001011111",	-- instrucción 2221
	"000000000000000000000000001011111",	-- instrucción 2222
	"000000000000000000000000001011111",	-- instrucción 2223
	"000000000000000000000000001011111",	-- instrucción 2224
	"000000000000000000000000001011111",	-- instrucción 2225
	"000000000000000000000000001011111",	-- instrucción 2226
	"000000000000000000000000001011111",	-- instrucción 2227
	"000000000000000000000000001011111",	-- instrucción 2228
	"000000000000000000000000001011111",	-- instrucción 2229
	"000000000000000000000000001011111",	-- instrucción 2230
	"000000000000000000000000001011111",	-- instrucción 2231
	"000000000000000000000000001011111",	-- instrucción 2232
	"000000000000000000000000001011111",	-- instrucción 2233
	"000000000000000000000000001011111",	-- instrucción 2234
	"000000000000000000000000001011111",	-- instrucción 2235
	"000000000000000000000000001011111",	-- instrucción 2236
	"000000000000000000000000001011111",	-- instrucción 2237
	"000000000000000000000000001011111",	-- instrucción 2238
	"000000000000000000000000001011111",	-- instrucción 2239
	"000000000000000000000000001011111",	-- instrucción 2240
	"000000000000000000000000001011111",	-- instrucción 2241
	"000000000000000000000000001011111",	-- instrucción 2242
	"000000000000000000000000001011111",	-- instrucción 2243
	"000000000000000000000000001011111",	-- instrucción 2244
	"000000000000000000000000001011111",	-- instrucción 2245
	"000000000000000000000000001011111",	-- instrucción 2246
	"000000000000000000000000001011111",	-- instrucción 2247
	"000000000000000000000000001011111",	-- instrucción 2248
	"000000000000000000000000001011111",	-- instrucción 2249
	"000000000000000000000000001011111",	-- instrucción 2250
	"000000000000000000000000001011111",	-- instrucción 2251
	"000000000000000000000000001011111",	-- instrucción 2252
	"000000000000000000000000001011111",	-- instrucción 2253
	"000000000000000000000000001011111",	-- instrucción 2254
	"000000000000000000000000001011111",	-- instrucción 2255
	"000000000000000000000000001011111",	-- instrucción 2256
	"000000000000000000000000001011111",	-- instrucción 2257
	"000000000000000000000000001011111",	-- instrucción 2258
	"000000000000000000000000001011111",	-- instrucción 2259
	"000000000000000000000000001011111",	-- instrucción 2260
	"000000000000000000000000001011111",	-- instrucción 2261
	"000000000000000000000000001011111",	-- instrucción 2262
	"000000000000000000000000001011111",	-- instrucción 2263
	"000000000000000000000000001011111",	-- instrucción 2264
	"000000000000000000000000001011111",	-- instrucción 2265
	"000000000000000000000000001011111",	-- instrucción 2266
	"000000000000000000000000001011111",	-- instrucción 2267
	"000000000000000000000000001011111",	-- instrucción 2268
	"000000000000000000000000001011111",	-- instrucción 2269
	"000000000000000000000000001011111",	-- instrucción 2270
	"000000000000000000000000001011111",	-- instrucción 2271
	"000000000000000000000000001011111",	-- instrucción 2272
	"000000000000000000000000001011111",	-- instrucción 2273
	"000000000000000000000000001011111",	-- instrucción 2274
	"000000000000000000000000001011111",	-- instrucción 2275
	"000000000000000000000000001011111",	-- instrucción 2276
	"000000000000000000000000001011111",	-- instrucción 2277
	"000000000000000000000000001011111",	-- instrucción 2278
	"000000000000000000000000001011111",	-- instrucción 2279
	"000000000000000000000000001011111",	-- instrucción 2280
	"000000000000000000000000001011111",	-- instrucción 2281
	"000000000000000000000000001011111",	-- instrucción 2282
	"000000000000000000000000001011111",	-- instrucción 2283
	"000000000000000000000000001011111",	-- instrucción 2284
	"000000000000000000000000001011111",	-- instrucción 2285
	"000000000000000000000000001011111",	-- instrucción 2286
	"000000000000000000000000001011111",	-- instrucción 2287
	"000000000000000000000000001011111",	-- instrucción 2288
	"000000000000000000000000001011111",	-- instrucción 2289
	"000000000000000000000000001011111",	-- instrucción 2290
	"000000000000000000000000001011111",	-- instrucción 2291
	"000000000000000000000000001011111",	-- instrucción 2292
	"000000000000000000000000001011111",	-- instrucción 2293
	"000000000000000000000000001011111",	-- instrucción 2294
	"000000000000000000000000001011111",	-- instrucción 2295
	"000000000000000000000000001011111",	-- instrucción 2296
	"000000000000000000000000001011111",	-- instrucción 2297
	"000000000000000000000000001011111",	-- instrucción 2298
	"000000000000000000000000001011111",	-- instrucción 2299
	"000000000000000000000000001011111",	-- instrucción 2300
	"000000000000000000000000001011111",	-- instrucción 2301
	"000000000000000000000000001011111",	-- instrucción 2302
	"000000000000000000000000001011111",	-- instrucción 2303
	"000000000000000000000000001011111",	-- instrucción 2304
	"000000000000000000000000001011111",	-- instrucción 2305
	"000000000000000000000000001011111",	-- instrucción 2306
	"000000000000000000000000001011111",	-- instrucción 2307
	"000000000000000000000000001011111",	-- instrucción 2308
	"000000000000000000000000001011111",	-- instrucción 2309
	"000000000000000000000000001011111",	-- instrucción 2310
	"000000000000000000000000001011111",	-- instrucción 2311
	"000000000000000000000000001011111",	-- instrucción 2312
	"000000000000000000000000001011111",	-- instrucción 2313
	"000000000000000000000000001011111",	-- instrucción 2314
	"000000000000000000000000001011111",	-- instrucción 2315
	"000000000000000000000000001011111",	-- instrucción 2316
	"000000000000000000000000001011111",	-- instrucción 2317
	"000000000000000000000000001011111",	-- instrucción 2318
	"000000000000000000000000001011111",	-- instrucción 2319
	"000000000000000000000000001011111",	-- instrucción 2320
	"000000000000000000000000001011111",	-- instrucción 2321
	"000000000000000000000000001011111",	-- instrucción 2322
	"000000000000000000000000001011111",	-- instrucción 2323
	"000000000000000000000000001011111",	-- instrucción 2324
	"000000000000000000000000001011111",	-- instrucción 2325
	"000000000000000000000000001011111",	-- instrucción 2326
	"000000000000000000000000001011111",	-- instrucción 2327
	"000000000000000000000000001011111",	-- instrucción 2328
	"000000000000000000000000001011111",	-- instrucción 2329
	"000000000000000000000000001011111",	-- instrucción 2330
	"000000000000000000000000001011111",	-- instrucción 2331
	"000000000000000000000000001011111",	-- instrucción 2332
	"000000000000000000000000001011111",	-- instrucción 2333
	"000000000000000000000000001011111",	-- instrucción 2334
	"000000000000000000000000001011111",	-- instrucción 2335
	"000000000000000000000000001011111",	-- instrucción 2336
	"000000000000000000000000001011111",	-- instrucción 2337
	"000000000000000000000000001011111",	-- instrucción 2338
	"000000000000000000000000001011111",	-- instrucción 2339
	"000000000000000000000000001011111",	-- instrucción 2340
	"000000000000000000000000001011111",	-- instrucción 2341
	"000000000000000000000000001011111",	-- instrucción 2342
	"000000000000000000000000001011111",	-- instrucción 2343
	"000000000000000000000000001011111",	-- instrucción 2344
	"000000000000000000000000001011111",	-- instrucción 2345
	"000000000000000000000000001011111",	-- instrucción 2346
	"000000000000000000000000001011111",	-- instrucción 2347
	"000000000000000000000000001011111",	-- instrucción 2348
	"000000000000000000000000001011111",	-- instrucción 2349
	"000000000000000000000000001011111",	-- instrucción 2350
	"000000000000000000000000001011111",	-- instrucción 2351
	"000000000000000000000000001011111",	-- instrucción 2352
	"000000000000000000000000001011111",	-- instrucción 2353
	"000000000000000000000000001011111",	-- instrucción 2354
	"000000000000000000000000001011111",	-- instrucción 2355
	"000000000000000000000000001011111",	-- instrucción 2356
	"000000000000000000000000001011111",	-- instrucción 2357
	"000000000000000000000000001011111",	-- instrucción 2358
	"000000000000000000000000001011111",	-- instrucción 2359
	"000000000000000000000000001011111",	-- instrucción 2360
	"000000000000000000000000001011111",	-- instrucción 2361
	"000000000000000000000000001011111",	-- instrucción 2362
	"000000000000000000000000001011111",	-- instrucción 2363
	"000000000000000000000000001011111",	-- instrucción 2364
	"000000000000000000000000001011111",	-- instrucción 2365
	"000000000000000000000000001011111",	-- instrucción 2366
	"000000000000000000000000001011111",	-- instrucción 2367
	"000000000000000000000000001011111",	-- instrucción 2368
	"000000000000000000000000001011111",	-- instrucción 2369
	"000000000000000000000000001011111",	-- instrucción 2370
	"000000000000000000000000001011111",	-- instrucción 2371
	"000000000000000000000000001011111",	-- instrucción 2372
	"000000000000000000000000001011111",	-- instrucción 2373
	"000000000000000000000000001011111",	-- instrucción 2374
	"000000000000000000000000001011111",	-- instrucción 2375
	"000000000000000000000000001011111",	-- instrucción 2376
	"000000000000000000000000001011111",	-- instrucción 2377
	"000000000000000000000000001011111",	-- instrucción 2378
	"000000000000000000000000001011111",	-- instrucción 2379
	"000000000000000000000000001011111",	-- instrucción 2380
	"000000000000000000000000001011111",	-- instrucción 2381
	"000000000000000000000000001011111",	-- instrucción 2382
	"000000000000000000000000001011111",	-- instrucción 2383
	"000000000000000000000000001011111",	-- instrucción 2384
	"000000000000000000000000001011111",	-- instrucción 2385
	"000000000000000000000000001011111",	-- instrucción 2386
	"000000000000000000000000001011111",	-- instrucción 2387
	"000000000000000000000000001011111",	-- instrucción 2388
	"000000000000000000000000001011111",	-- instrucción 2389
	"000000000000000000000000001011111",	-- instrucción 2390
	"000000000000000000000000001011111",	-- instrucción 2391
	"000000000000000000000000001011111",	-- instrucción 2392
	"000000000000000000000000001011111",	-- instrucción 2393
	"000000000000000000000000001011111",	-- instrucción 2394
	"000000000000000000000000001011111",	-- instrucción 2395
	"000000000000000000000000001011111",	-- instrucción 2396
	"000000000000000000000000001011111",	-- instrucción 2397
	"000000000000000000000000001011111",	-- instrucción 2398
	"000000000000000000000000001011111",	-- instrucción 2399
	"000000000000000000000000001011111",	-- instrucción 2400
	"000000000000000000000000001011111",	-- instrucción 2401
	"000000000000000000000000001011111",	-- instrucción 2402
	"000000000000000000000000001011111",	-- instrucción 2403
	"000000000000000000000000001011111",	-- instrucción 2404
	"000000000000000000000000001011111",	-- instrucción 2405
	"000000000000000000000000001011111",	-- instrucción 2406
	"000000000000000000000000001011111",	-- instrucción 2407
	"000000000000000000000000001011111",	-- instrucción 2408
	"000000000000000000000000001011111",	-- instrucción 2409
	"000000000000000000000000001011111",	-- instrucción 2410
	"000000000000000000000000001011111",	-- instrucción 2411
	"000000000000000000000000001011111",	-- instrucción 2412
	"000000000000000000000000001011111",	-- instrucción 2413
	"000000000000000000000000001011111",	-- instrucción 2414
	"000000000000000000000000001011111",	-- instrucción 2415
	"000000000000000000000000001011111",	-- instrucción 2416
	"000000000000000000000000001011111",	-- instrucción 2417
	"000000000000000000000000001011111",	-- instrucción 2418
	"000000000000000000000000001011111",	-- instrucción 2419
	"000000000000000000000000001011111",	-- instrucción 2420
	"000000000000000000000000001011111",	-- instrucción 2421
	"000000000000000000000000001011111",	-- instrucción 2422
	"000000000000000000000000001011111",	-- instrucción 2423
	"000000000000000000000000001011111",	-- instrucción 2424
	"000000000000000000000000001011111",	-- instrucción 2425
	"000000000000000000000000001011111",	-- instrucción 2426
	"000000000000000000000000001011111",	-- instrucción 2427
	"000000000000000000000000001011111",	-- instrucción 2428
	"000000000000000000000000001011111",	-- instrucción 2429
	"000000000000000000000000001011111",	-- instrucción 2430
	"000000000000000000000000001011111",	-- instrucción 2431
	"000000000000000000000000001011111",	-- instrucción 2432
	"000000000000000000000000001011111",	-- instrucción 2433
	"000000000000000000000000001011111",	-- instrucción 2434
	"000000000000000000000000001011111",	-- instrucción 2435
	"000000000000000000000000001011111",	-- instrucción 2436
	"000000000000000000000000001011111",	-- instrucción 2437
	"000000000000000000000000001011111",	-- instrucción 2438
	"000000000000000000000000001011111",	-- instrucción 2439
	"000000000000000000000000001011111",	-- instrucción 2440
	"000000000000000000000000001011111",	-- instrucción 2441
	"000000000000000000000000001011111",	-- instrucción 2442
	"000000000000000000000000001011111",	-- instrucción 2443
	"000000000000000000000000001011111",	-- instrucción 2444
	"000000000000000000000000001011111",	-- instrucción 2445
	"000000000000000000000000001011111",	-- instrucción 2446
	"000000000000000000000000001011111",	-- instrucción 2447
	"000000000000000000000000001011111",	-- instrucción 2448
	"000000000000000000000000001011111",	-- instrucción 2449
	"000000000000000000000000001011111",	-- instrucción 2450
	"000000000000000000000000001011111",	-- instrucción 2451
	"000000000000000000000000001011111",	-- instrucción 2452
	"000000000000000000000000001011111",	-- instrucción 2453
	"000000000000000000000000001011111",	-- instrucción 2454
	"000000000000000000000000001011111",	-- instrucción 2455
	"000000000000000000000000001011111",	-- instrucción 2456
	"000000000000000000000000001011111",	-- instrucción 2457
	"000000000000000000000000001011111",	-- instrucción 2458
	"000000000000000000000000001011111",	-- instrucción 2459
	"000000000000000000000000001011111",	-- instrucción 2460
	"000000000000000000000000001011111",	-- instrucción 2461
	"000000000000000000000000001011111",	-- instrucción 2462
	"000000000000000000000000001011111",	-- instrucción 2463
	"000000000000000000000000001011111",	-- instrucción 2464
	"000000000000000000000000001011111",	-- instrucción 2465
	"000000000000000000000000001011111",	-- instrucción 2466
	"000000000000000000000000001011111",	-- instrucción 2467
	"000000000000000000000000001011111",	-- instrucción 2468
	"000000000000000000000000001011111",	-- instrucción 2469
	"000000000000000000000000001011111",	-- instrucción 2470
	"000000000000000000000000001011111",	-- instrucción 2471
	"000000000000000000000000001011111",	-- instrucción 2472
	"000000000000000000000000001011111",	-- instrucción 2473
	"000000000000000000000000001011111",	-- instrucción 2474
	"000000000000000000000000001011111",	-- instrucción 2475
	"000000000000000000000000001011111",	-- instrucción 2476
	"000000000000000000000000001011111",	-- instrucción 2477
	"000000000000000000000000001011111",	-- instrucción 2478
	"000000000000000000000000001011111",	-- instrucción 2479
	"000000000000000000000000001011111",	-- instrucción 2480
	"000000000000000000000000001011111",	-- instrucción 2481
	"000000000000000000000000001011111",	-- instrucción 2482
	"000000000000000000000000001011111",	-- instrucción 2483
	"000000000000000000000000001011111",	-- instrucción 2484
	"000000000000000000000000001011111",	-- instrucción 2485
	"000000000000000000000000001011111",	-- instrucción 2486
	"000000000000000000000000001011111",	-- instrucción 2487
	"000000000000000000000000001011111",	-- instrucción 2488
	"000000000000000000000000001011111",	-- instrucción 2489
	"000000000000000000000000001011111",	-- instrucción 2490
	"000000000000000000000000001011111",	-- instrucción 2491
	"000000000000000000000000001011111",	-- instrucción 2492
	"000000000000000000000000001011111",	-- instrucción 2493
	"000000000000000000000000001011111",	-- instrucción 2494
	"000000000000000000000000001011111",	-- instrucción 2495
	"000000000000000000000000001011111",	-- instrucción 2496
	"000000000000000000000000001011111",	-- instrucción 2497
	"000000000000000000000000001011111",	-- instrucción 2498
	"000000000000000000000000001011111",	-- instrucción 2499
	"000000000000000000000000001011111",	-- instrucción 2500
	"000000000000000000000000001011111",	-- instrucción 2501
	"000000000000000000000000001011111",	-- instrucción 2502
	"000000000000000000000000001011111",	-- instrucción 2503
	"000000000000000000000000001011111",	-- instrucción 2504
	"000000000000000000000000001011111",	-- instrucción 2505
	"000000000000000000000000001011111",	-- instrucción 2506
	"000000000000000000000000001011111",	-- instrucción 2507
	"000000000000000000000000001011111",	-- instrucción 2508
	"000000000000000000000000001011111",	-- instrucción 2509
	"000000000000000000000000001011111",	-- instrucción 2510
	"000000000000000000000000001011111",	-- instrucción 2511
	"000000000000000000000000001011111",	-- instrucción 2512
	"000000000000000000000000001011111",	-- instrucción 2513
	"000000000000000000000000001011111",	-- instrucción 2514
	"000000000000000000000000001011111",	-- instrucción 2515
	"000000000000000000000000001011111",	-- instrucción 2516
	"000000000000000000000000001011111",	-- instrucción 2517
	"000000000000000000000000001011111",	-- instrucción 2518
	"000000000000000000000000001011111",	-- instrucción 2519
	"000000000000000000000000001011111",	-- instrucción 2520
	"000000000000000000000000001011111",	-- instrucción 2521
	"000000000000000000000000001011111",	-- instrucción 2522
	"000000000000000000000000001011111",	-- instrucción 2523
	"000000000000000000000000001011111",	-- instrucción 2524
	"000000000000000000000000001011111",	-- instrucción 2525
	"000000000000000000000000001011111",	-- instrucción 2526
	"000000000000000000000000001011111",	-- instrucción 2527
	"000000000000000000000000001011111",	-- instrucción 2528
	"000000000000000000000000001011111",	-- instrucción 2529
	"000000000000000000000000001011111",	-- instrucción 2530
	"000000000000000000000000001011111",	-- instrucción 2531
	"000000000000000000000000001011111",	-- instrucción 2532
	"000000000000000000000000001011111",	-- instrucción 2533
	"000000000000000000000000001011111",	-- instrucción 2534
	"000000000000000000000000001011111",	-- instrucción 2535
	"000000000000000000000000001011111",	-- instrucción 2536
	"000000000000000000000000001011111",	-- instrucción 2537
	"000000000000000000000000001011111",	-- instrucción 2538
	"000000000000000000000000001011111",	-- instrucción 2539
	"000000000000000000000000001011111",	-- instrucción 2540
	"000000000000000000000000001011111",	-- instrucción 2541
	"000000000000000000000000001011111",	-- instrucción 2542
	"000000000000000000000000001011111",	-- instrucción 2543
	"000000000000000000000000001011111",	-- instrucción 2544
	"000000000000000000000000001011111",	-- instrucción 2545
	"000000000000000000000000001011111",	-- instrucción 2546
	"000000000000000000000000001011111",	-- instrucción 2547
	"000000000000000000000000001011111",	-- instrucción 2548
	"000000000000000000000000001011111",	-- instrucción 2549
	"000000000000000000000000001011111",	-- instrucción 2550
	"000000000000000000000000001011111",	-- instrucción 2551
	"000000000000000000000000001011111",	-- instrucción 2552
	"000000000000000000000000001011111",	-- instrucción 2553
	"000000000000000000000000001011111",	-- instrucción 2554
	"000000000000000000000000001011111",	-- instrucción 2555
	"000000000000000000000000001011111",	-- instrucción 2556
	"000000000000000000000000001011111",	-- instrucción 2557
	"000000000000000000000000001011111",	-- instrucción 2558
	"000000000000000000000000001011111",	-- instrucción 2559
	"000000000000000000000000001011111",	-- instrucción 2560
	"000000000000000000000000001011111",	-- instrucción 2561
	"000000000000000000000000001011111",	-- instrucción 2562
	"000000000000000000000000001011111",	-- instrucción 2563
	"000000000000000000000000001011111",	-- instrucción 2564
	"000000000000000000000000001011111",	-- instrucción 2565
	"000000000000000000000000001011111",	-- instrucción 2566
	"000000000000000000000000001011111",	-- instrucción 2567
	"000000000000000000000000001011111",	-- instrucción 2568
	"000000000000000000000000001011111",	-- instrucción 2569
	"000000000000000000000000001011111",	-- instrucción 2570
	"000000000000000000000000001011111",	-- instrucción 2571
	"000000000000000000000000001011111",	-- instrucción 2572
	"000000000000000000000000001011111",	-- instrucción 2573
	"000000000000000000000000001011111",	-- instrucción 2574
	"000000000000000000000000001011111",	-- instrucción 2575
	"000000000000000000000000001011111",	-- instrucción 2576
	"000000000000000000000000001011111",	-- instrucción 2577
	"000000000000000000000000001011111",	-- instrucción 2578
	"000000000000000000000000001011111",	-- instrucción 2579
	"000000000000000000000000001011111",	-- instrucción 2580
	"000000000000000000000000001011111",	-- instrucción 2581
	"000000000000000000000000001011111",	-- instrucción 2582
	"000000000000000000000000001011111",	-- instrucción 2583
	"000000000000000000000000001011111",	-- instrucción 2584
	"000000000000000000000000001011111",	-- instrucción 2585
	"000000000000000000000000001011111",	-- instrucción 2586
	"000000000000000000000000001011111",	-- instrucción 2587
	"000000000000000000000000001011111",	-- instrucción 2588
	"000000000000000000000000001011111",	-- instrucción 2589
	"000000000000000000000000001011111",	-- instrucción 2590
	"000000000000000000000000001011111",	-- instrucción 2591
	"000000000000000000000000001011111",	-- instrucción 2592
	"000000000000000000000000001011111",	-- instrucción 2593
	"000000000000000000000000001011111",	-- instrucción 2594
	"000000000000000000000000001011111",	-- instrucción 2595
	"000000000000000000000000001011111",	-- instrucción 2596
	"000000000000000000000000001011111",	-- instrucción 2597
	"000000000000000000000000001011111",	-- instrucción 2598
	"000000000000000000000000001011111",	-- instrucción 2599
	"000000000000000000000000001011111",	-- instrucción 2600
	"000000000000000000000000001011111",	-- instrucción 2601
	"000000000000000000000000001011111",	-- instrucción 2602
	"000000000000000000000000001011111",	-- instrucción 2603
	"000000000000000000000000001011111",	-- instrucción 2604
	"000000000000000000000000001011111",	-- instrucción 2605
	"000000000000000000000000001011111",	-- instrucción 2606
	"000000000000000000000000001011111",	-- instrucción 2607
	"000000000000000000000000001011111",	-- instrucción 2608
	"000000000000000000000000001011111",	-- instrucción 2609
	"000000000000000000000000001011111",	-- instrucción 2610
	"000000000000000000000000001011111",	-- instrucción 2611
	"000000000000000000000000001011111",	-- instrucción 2612
	"000000000000000000000000001011111",	-- instrucción 2613
	"000000000000000000000000001011111",	-- instrucción 2614
	"000000000000000000000000001011111",	-- instrucción 2615
	"000000000000000000000000001011111",	-- instrucción 2616
	"000000000000000000000000001011111",	-- instrucción 2617
	"000000000000000000000000001011111",	-- instrucción 2618
	"000000000000000000000000001011111",	-- instrucción 2619
	"000000000000000000000000001011111",	-- instrucción 2620
	"000000000000000000000000001011111",	-- instrucción 2621
	"000000000000000000000000001011111",	-- instrucción 2622
	"000000000000000000000000001011111",	-- instrucción 2623
	"000000000000000000000000001011111",	-- instrucción 2624
	"000000000000000000000000001011111",	-- instrucción 2625
	"000000000000000000000000001011111",	-- instrucción 2626
	"000000000000000000000000001011111",	-- instrucción 2627
	"000000000000000000000000001011111",	-- instrucción 2628
	"000000000000000000000000001011111",	-- instrucción 2629
	"000000000000000000000000001011111",	-- instrucción 2630
	"000000000000000000000000001011111",	-- instrucción 2631
	"000000000000000000000000001011111",	-- instrucción 2632
	"000000000000000000000000001011111",	-- instrucción 2633
	"000000000000000000000000001011111",	-- instrucción 2634
	"000000000000000000000000001011111",	-- instrucción 2635
	"000000000000000000000000001011111",	-- instrucción 2636
	"000000000000000000000000001011111",	-- instrucción 2637
	"000000000000000000000000001011111",	-- instrucción 2638
	"000000000000000000000000001011111",	-- instrucción 2639
	"000000000000000000000000001011111",	-- instrucción 2640
	"000000000000000000000000001011111",	-- instrucción 2641
	"000000000000000000000000001011111",	-- instrucción 2642
	"000000000000000000000000001011111",	-- instrucción 2643
	"000000000000000000000000001011111",	-- instrucción 2644
	"000000000000000000000000001011111",	-- instrucción 2645
	"000000000000000000000000001011111",	-- instrucción 2646
	"000000000000000000000000001011111",	-- instrucción 2647
	"000000000000000000000000001011111",	-- instrucción 2648
	"000000000000000000000000001011111",	-- instrucción 2649
	"000000000000000000000000001011111",	-- instrucción 2650
	"000000000000000000000000001011111",	-- instrucción 2651
	"000000000000000000000000001011111",	-- instrucción 2652
	"000000000000000000000000001011111",	-- instrucción 2653
	"000000000000000000000000001011111",	-- instrucción 2654
	"000000000000000000000000001011111",	-- instrucción 2655
	"000000000000000000000000001011111",	-- instrucción 2656
	"000000000000000000000000001011111",	-- instrucción 2657
	"000000000000000000000000001011111",	-- instrucción 2658
	"000000000000000000000000001011111",	-- instrucción 2659
	"000000000000000000000000001011111",	-- instrucción 2660
	"000000000000000000000000001011111",	-- instrucción 2661
	"000000000000000000000000001011111",	-- instrucción 2662
	"000000000000000000000000001011111",	-- instrucción 2663
	"000000000000000000000000001011111",	-- instrucción 2664
	"000000000000000000000000001011111",	-- instrucción 2665
	"000000000000000000000000001011111",	-- instrucción 2666
	"000000000000000000000000001011111",	-- instrucción 2667
	"000000000000000000000000001011111",	-- instrucción 2668
	"000000000000000000000000001011111",	-- instrucción 2669
	"000000000000000000000000001011111",	-- instrucción 2670
	"000000000000000000000000001011111",	-- instrucción 2671
	"000000000000000000000000001011111",	-- instrucción 2672
	"000000000000000000000000001011111",	-- instrucción 2673
	"000000000000000000000000001011111",	-- instrucción 2674
	"000000000000000000000000001011111",	-- instrucción 2675
	"000000000000000000000000001011111",	-- instrucción 2676
	"000000000000000000000000001011111",	-- instrucción 2677
	"000000000000000000000000001011111",	-- instrucción 2678
	"000000000000000000000000001011111",	-- instrucción 2679
	"000000000000000000000000001011111",	-- instrucción 2680
	"000000000000000000000000001011111",	-- instrucción 2681
	"000000000000000000000000001011111",	-- instrucción 2682
	"000000000000000000000000001011111",	-- instrucción 2683
	"000000000000000000000000001011111",	-- instrucción 2684
	"000000000000000000000000001011111",	-- instrucción 2685
	"000000000000000000000000001011111",	-- instrucción 2686
	"000000000000000000000000001011111",	-- instrucción 2687
	"000000000000000000000000001011111",	-- instrucción 2688
	"000000000000000000000000001011111",	-- instrucción 2689
	"000000000000000000000000001011111",	-- instrucción 2690
	"000000000000000000000000001011111",	-- instrucción 2691
	"000000000000000000000000001011111",	-- instrucción 2692
	"000000000000000000000000001011111",	-- instrucción 2693
	"000000000000000000000000001011111",	-- instrucción 2694
	"000000000000000000000000001011111",	-- instrucción 2695
	"000000000000000000000000001011111",	-- instrucción 2696
	"000000000000000000000000001011111",	-- instrucción 2697
	"000000000000000000000000001011111",	-- instrucción 2698
	"000000000000000000000000001011111",	-- instrucción 2699
	"000000000000000000000000001011111",	-- instrucción 2700
	"000000000000000000000000001011111",	-- instrucción 2701
	"000000000000000000000000001011111",	-- instrucción 2702
	"000000000000000000000000001011111",	-- instrucción 2703
	"000000000000000000000000001011111",	-- instrucción 2704
	"000000000000000000000000001011111",	-- instrucción 2705
	"000000000000000000000000001011111",	-- instrucción 2706
	"000000000000000000000000001011111",	-- instrucción 2707
	"000000000000000000000000001011111",	-- instrucción 2708
	"000000000000000000000000001011111",	-- instrucción 2709
	"000000000000000000000000001011111",	-- instrucción 2710
	"000000000000000000000000001011111",	-- instrucción 2711
	"000000000000000000000000001011111",	-- instrucción 2712
	"000000000000000000000000001011111",	-- instrucción 2713
	"000000000000000000000000001011111",	-- instrucción 2714
	"000000000000000000000000001011111",	-- instrucción 2715
	"000000000000000000000000001011111",	-- instrucción 2716
	"000000000000000000000000001011111",	-- instrucción 2717
	"000000000000000000000000001011111",	-- instrucción 2718
	"000000000000000000000000001011111",	-- instrucción 2719
	"000000000000000000000000001011111",	-- instrucción 2720
	"000000000000000000000000001011111",	-- instrucción 2721
	"000000000000000000000000001011111",	-- instrucción 2722
	"000000000000000000000000001011111",	-- instrucción 2723
	"000000000000000000000000001011111",	-- instrucción 2724
	"000000000000000000000000001011111",	-- instrucción 2725
	"000000000000000000000000001011111",	-- instrucción 2726
	"000000000000000000000000001011111",	-- instrucción 2727
	"000000000000000000000000001011111",	-- instrucción 2728
	"000000000000000000000000001011111",	-- instrucción 2729
	"000000000000000000000000001011111",	-- instrucción 2730
	"000000000000000000000000001011111",	-- instrucción 2731
	"000000000000000000000000001011111",	-- instrucción 2732
	"000000000000000000000000001011111",	-- instrucción 2733
	"000000000000000000000000001011111",	-- instrucción 2734
	"000000000000000000000000001011111",	-- instrucción 2735
	"000000000000000000000000001011111",	-- instrucción 2736
	"000000000000000000000000001011111",	-- instrucción 2737
	"000000000000000000000000001011111",	-- instrucción 2738
	"000000000000000000000000001011111",	-- instrucción 2739
	"000000000000000000000000001011111",	-- instrucción 2740
	"000000000000000000000000001011111",	-- instrucción 2741
	"000000000000000000000000001011111",	-- instrucción 2742
	"000000000000000000000000001011111",	-- instrucción 2743
	"000000000000000000000000001011111",	-- instrucción 2744
	"000000000000000000000000001011111",	-- instrucción 2745
	"000000000000000000000000001011111",	-- instrucción 2746
	"000000000000000000000000001011111",	-- instrucción 2747
	"000000000000000000000000001011111",	-- instrucción 2748
	"000000000000000000000000001011111",	-- instrucción 2749
	"000000000000000000000000001011111",	-- instrucción 2750
	"000000000000000000000000001011111",	-- instrucción 2751
	"000000000000000000000000001011111",	-- instrucción 2752
	"000000000000000000000000001011111",	-- instrucción 2753
	"000000000000000000000000001011111",	-- instrucción 2754
	"000000000000000000000000001011111",	-- instrucción 2755
	"000000000000000000000000001011111",	-- instrucción 2756
	"000000000000000000000000001011111",	-- instrucción 2757
	"000000000000000000000000001011111",	-- instrucción 2758
	"000000000000000000000000001011111",	-- instrucción 2759
	"000000000000000000000000001011111",	-- instrucción 2760
	"000000000000000000000000001011111",	-- instrucción 2761
	"000000000000000000000000001011111",	-- instrucción 2762
	"000000000000000000000000001011111",	-- instrucción 2763
	"000000000000000000000000001011111",	-- instrucción 2764
	"000000000000000000000000001011111",	-- instrucción 2765
	"000000000000000000000000001011111",	-- instrucción 2766
	"000000000000000000000000001011111",	-- instrucción 2767
	"000000000000000000000000001011111",	-- instrucción 2768
	"000000000000000000000000001011111",	-- instrucción 2769
	"000000000000000000000000001011111",	-- instrucción 2770
	"000000000000000000000000001011111",	-- instrucción 2771
	"000000000000000000000000001011111",	-- instrucción 2772
	"000000000000000000000000001011111",	-- instrucción 2773
	"000000000000000000000000001011111",	-- instrucción 2774
	"000000000000000000000000001011111",	-- instrucción 2775
	"000000000000000000000000001011111",	-- instrucción 2776
	"000000000000000000000000001011111",	-- instrucción 2777
	"000000000000000000000000001011111",	-- instrucción 2778
	"000000000000000000000000001011111",	-- instrucción 2779
	"000000000000000000000000001011111",	-- instrucción 2780
	"000000000000000000000000001011111",	-- instrucción 2781
	"000000000000000000000000001011111",	-- instrucción 2782
	"000000000000000000000000001011111",	-- instrucción 2783
	"000000000000000000000000001011111",	-- instrucción 2784
	"000000000000000000000000001011111",	-- instrucción 2785
	"000000000000000000000000001011111",	-- instrucción 2786
	"000000000000000000000000001011111",	-- instrucción 2787
	"000000000000000000000000001011111",	-- instrucción 2788
	"000000000000000000000000001011111",	-- instrucción 2789
	"000000000000000000000000001011111",	-- instrucción 2790
	"000000000000000000000000001011111",	-- instrucción 2791
	"000000000000000000000000001011111",	-- instrucción 2792
	"000000000000000000000000001011111",	-- instrucción 2793
	"000000000000000000000000001011111",	-- instrucción 2794
	"000000000000000000000000001011111",	-- instrucción 2795
	"000000000000000000000000001011111",	-- instrucción 2796
	"000000000000000000000000001011111",	-- instrucción 2797
	"000000000000000000000000001011111",	-- instrucción 2798
	"000000000000000000000000001011111",	-- instrucción 2799
	"000000000000000000000000001011111",	-- instrucción 2800
	"000000000000000000000000001011111",	-- instrucción 2801
	"000000000000000000000000001011111",	-- instrucción 2802
	"000000000000000000000000001011111",	-- instrucción 2803
	"000000000000000000000000001011111",	-- instrucción 2804
	"000000000000000000000000001011111",	-- instrucción 2805
	"000000000000000000000000001011111",	-- instrucción 2806
	"000000000000000000000000001011111",	-- instrucción 2807
	"000000000000000000000000001011111",	-- instrucción 2808
	"000000000000000000000000001011111",	-- instrucción 2809
	"000000000000000000000000001011111",	-- instrucción 2810
	"000000000000000000000000001011111",	-- instrucción 2811
	"000000000000000000000000001011111",	-- instrucción 2812
	"000000000000000000000000001011111",	-- instrucción 2813
	"000000000000000000000000001011111",	-- instrucción 2814
	"000000000000000000000000001011111",	-- instrucción 2815
	"000000000000000000000000001011111",	-- instrucción 2816
	"000000000000000000000000001011111",	-- instrucción 2817
	"000000000000000000000000001011111",	-- instrucción 2818
	"000000000000000000000000001011111",	-- instrucción 2819
	"000000000000000000000000001011111",	-- instrucción 2820
	"000000000000000000000000001011111",	-- instrucción 2821
	"000000000000000000000000001011111",	-- instrucción 2822
	"000000000000000000000000001011111",	-- instrucción 2823
	"000000000000000000000000001011111",	-- instrucción 2824
	"000000000000000000000000001011111",	-- instrucción 2825
	"000000000000000000000000001011111",	-- instrucción 2826
	"000000000000000000000000001011111",	-- instrucción 2827
	"000000000000000000000000001011111",	-- instrucción 2828
	"000000000000000000000000001011111",	-- instrucción 2829
	"000000000000000000000000001011111",	-- instrucción 2830
	"000000000000000000000000001011111",	-- instrucción 2831
	"000000000000000000000000001011111",	-- instrucción 2832
	"000000000000000000000000001011111",	-- instrucción 2833
	"000000000000000000000000001011111",	-- instrucción 2834
	"000000000000000000000000001011111",	-- instrucción 2835
	"000000000000000000000000001011111",	-- instrucción 2836
	"000000000000000000000000001011111",	-- instrucción 2837
	"000000000000000000000000001011111",	-- instrucción 2838
	"000000000000000000000000001011111",	-- instrucción 2839
	"000000000000000000000000001011111",	-- instrucción 2840
	"000000000000000000000000001011111",	-- instrucción 2841
	"000000000000000000000000001011111",	-- instrucción 2842
	"000000000000000000000000001011111",	-- instrucción 2843
	"000000000000000000000000001011111",	-- instrucción 2844
	"000000000000000000000000001011111",	-- instrucción 2845
	"000000000000000000000000001011111",	-- instrucción 2846
	"000000000000000000000000001011111",	-- instrucción 2847
	"000000000000000000000000001011111",	-- instrucción 2848
	"000000000000000000000000001011111",	-- instrucción 2849
	"000000000000000000000000001011111",	-- instrucción 2850
	"000000000000000000000000001011111",	-- instrucción 2851
	"000000000000000000000000001011111",	-- instrucción 2852
	"000000000000000000000000001011111",	-- instrucción 2853
	"000000000000000000000000001011111",	-- instrucción 2854
	"000000000000000000000000001011111",	-- instrucción 2855
	"000000000000000000000000001011111",	-- instrucción 2856
	"000000000000000000000000001011111",	-- instrucción 2857
	"000000000000000000000000001011111",	-- instrucción 2858
	"000000000000000000000000001011111",	-- instrucción 2859
	"000000000000000000000000001011111",	-- instrucción 2860
	"000000000000000000000000001011111",	-- instrucción 2861
	"000000000000000000000000001011111",	-- instrucción 2862
	"000000000000000000000000001011111",	-- instrucción 2863
	"000000000000000000000000001011111",	-- instrucción 2864
	"000000000000000000000000001011111",	-- instrucción 2865
	"000000000000000000000000001011111",	-- instrucción 2866
	"000000000000000000000000001011111",	-- instrucción 2867
	"000000000000000000000000001011111",	-- instrucción 2868
	"000000000000000000000000001011111",	-- instrucción 2869
	"000000000000000000000000001011111",	-- instrucción 2870
	"000000000000000000000000001011111",	-- instrucción 2871
	"000000000000000000000000001011111",	-- instrucción 2872
	"000000000000000000000000001011111",	-- instrucción 2873
	"000000000000000000000000001011111",	-- instrucción 2874
	"000000000000000000000000001011111",	-- instrucción 2875
	"000000000000000000000000001011111",	-- instrucción 2876
	"000000000000000000000000001011111",	-- instrucción 2877
	"000000000000000000000000001011111",	-- instrucción 2878
	"000000000000000000000000001011111",	-- instrucción 2879
	"000000000000000000000000001011111",	-- instrucción 2880
	"000000000000000000000000001011111",	-- instrucción 2881
	"000000000000000000000000001011111",	-- instrucción 2882
	"000000000000000000000000001011111",	-- instrucción 2883
	"000000000000000000000000001011111",	-- instrucción 2884
	"000000000000000000000000001011111",	-- instrucción 2885
	"000000000000000000000000001011111",	-- instrucción 2886
	"000000000000000000000000001011111",	-- instrucción 2887
	"000000000000000000000000001011111",	-- instrucción 2888
	"000000000000000000000000001011111",	-- instrucción 2889
	"000000000000000000000000001011111",	-- instrucción 2890
	"000000000000000000000000001011111",	-- instrucción 2891
	"000000000000000000000000001011111",	-- instrucción 2892
	"000000000000000000000000001011111",	-- instrucción 2893
	"000000000000000000000000001011111",	-- instrucción 2894
	"000000000000000000000000001011111",	-- instrucción 2895
	"000000000000000000000000001011111",	-- instrucción 2896
	"000000000000000000000000001011111",	-- instrucción 2897
	"000000000000000000000000001011111",	-- instrucción 2898
	"000000000000000000000000001011111",	-- instrucción 2899
	"000000000000000000000000001011111",	-- instrucción 2900
	"000000000000000000000000001011111",	-- instrucción 2901
	"000000000000000000000000001011111",	-- instrucción 2902
	"000000000000000000000000001011111",	-- instrucción 2903
	"000000000000000000000000001011111",	-- instrucción 2904
	"000000000000000000000000001011111",	-- instrucción 2905
	"000000000000000000000000001011111",	-- instrucción 2906
	"000000000000000000000000001011111",	-- instrucción 2907
	"000000000000000000000000001011111",	-- instrucción 2908
	"000000000000000000000000001011111",	-- instrucción 2909
	"000000000000000000000000001011111",	-- instrucción 2910
	"000000000000000000000000001011111",	-- instrucción 2911
	"000000000000000000000000001011111",	-- instrucción 2912
	"000000000000000000000000001011111",	-- instrucción 2913
	"000000000000000000000000001011111",	-- instrucción 2914
	"000000000000000000000000001011111",	-- instrucción 2915
	"000000000000000000000000001011111",	-- instrucción 2916
	"000000000000000000000000001011111",	-- instrucción 2917
	"000000000000000000000000001011111",	-- instrucción 2918
	"000000000000000000000000001011111",	-- instrucción 2919
	"000000000000000000000000001011111",	-- instrucción 2920
	"000000000000000000000000001011111",	-- instrucción 2921
	"000000000000000000000000001011111",	-- instrucción 2922
	"000000000000000000000000001011111",	-- instrucción 2923
	"000000000000000000000000001011111",	-- instrucción 2924
	"000000000000000000000000001011111",	-- instrucción 2925
	"000000000000000000000000001011111",	-- instrucción 2926
	"000000000000000000000000001011111",	-- instrucción 2927
	"000000000000000000000000001011111",	-- instrucción 2928
	"000000000000000000000000001011111",	-- instrucción 2929
	"000000000000000000000000001011111",	-- instrucción 2930
	"000000000000000000000000001011111",	-- instrucción 2931
	"000000000000000000000000001011111",	-- instrucción 2932
	"000000000000000000000000001011111",	-- instrucción 2933
	"000000000000000000000000001011111",	-- instrucción 2934
	"000000000000000000000000001011111",	-- instrucción 2935
	"000000000000000000000000001011111",	-- instrucción 2936
	"000000000000000000000000001011111",	-- instrucción 2937
	"000000000000000000000000001011111",	-- instrucción 2938
	"000000000000000000000000001011111",	-- instrucción 2939
	"000000000000000000000000001011111",	-- instrucción 2940
	"000000000000000000000000001011111",	-- instrucción 2941
	"000000000000000000000000001011111",	-- instrucción 2942
	"000000000000000000000000001011111",	-- instrucción 2943
	"000000000000000000000000001011111",	-- instrucción 2944
	"000000000000000000000000001011111",	-- instrucción 2945
	"000000000000000000000000001011111",	-- instrucción 2946
	"000000000000000000000000001011111",	-- instrucción 2947
	"000000000000000000000000001011111",	-- instrucción 2948
	"000000000000000000000000001011111",	-- instrucción 2949
	"000000000000000000000000001011111",	-- instrucción 2950
	"000000000000000000000000001011111",	-- instrucción 2951
	"000000000000000000000000001011111",	-- instrucción 2952
	"000000000000000000000000001011111",	-- instrucción 2953
	"000000000000000000000000001011111",	-- instrucción 2954
	"000000000000000000000000001011111",	-- instrucción 2955
	"000000000000000000000000001011111",	-- instrucción 2956
	"000000000000000000000000001011111",	-- instrucción 2957
	"000000000000000000000000001011111",	-- instrucción 2958
	"000000000000000000000000001011111",	-- instrucción 2959
	"000000000000000000000000001011111",	-- instrucción 2960
	"000000000000000000000000001011111",	-- instrucción 2961
	"000000000000000000000000001011111",	-- instrucción 2962
	"000000000000000000000000001011111",	-- instrucción 2963
	"000000000000000000000000001011111",	-- instrucción 2964
	"000000000000000000000000001011111",	-- instrucción 2965
	"000000000000000000000000001011111",	-- instrucción 2966
	"000000000000000000000000001011111",	-- instrucción 2967
	"000000000000000000000000001011111",	-- instrucción 2968
	"000000000000000000000000001011111",	-- instrucción 2969
	"000000000000000000000000001011111",	-- instrucción 2970
	"000000000000000000000000001011111",	-- instrucción 2971
	"000000000000000000000000001011111",	-- instrucción 2972
	"000000000000000000000000001011111",	-- instrucción 2973
	"000000000000000000000000001011111",	-- instrucción 2974
	"000000000000000000000000001011111",	-- instrucción 2975
	"000000000000000000000000001011111",	-- instrucción 2976
	"000000000000000000000000001011111",	-- instrucción 2977
	"000000000000000000000000001011111",	-- instrucción 2978
	"000000000000000000000000001011111",	-- instrucción 2979
	"000000000000000000000000001011111",	-- instrucción 2980
	"000000000000000000000000001011111",	-- instrucción 2981
	"000000000000000000000000001011111",	-- instrucción 2982
	"000000000000000000000000001011111",	-- instrucción 2983
	"000000000000000000000000001011111",	-- instrucción 2984
	"000000000000000000000000001011111",	-- instrucción 2985
	"000000000000000000000000001011111",	-- instrucción 2986
	"000000000000000000000000001011111",	-- instrucción 2987
	"000000000000000000000000001011111",	-- instrucción 2988
	"000000000000000000000000001011111",	-- instrucción 2989
	"000000000000000000000000001011111",	-- instrucción 2990
	"000000000000000000000000001011111",	-- instrucción 2991
	"000000000000000000000000001011111",	-- instrucción 2992
	"000000000000000000000000001011111",	-- instrucción 2993
	"000000000000000000000000001011111",	-- instrucción 2994
	"000000000000000000000000001011111",	-- instrucción 2995
	"000000000000000000000000001011111",	-- instrucción 2996
	"000000000000000000000000001011111",	-- instrucción 2997
	"000000000000000000000000001011111",	-- instrucción 2998
	"000000000000000000000000001011111",	-- instrucción 2999
	"000000000000000000000000001011111",	-- instrucción 3000
	"000000000000000000000000001011111",	-- instrucción 3001
	"000000000000000000000000001011111",	-- instrucción 3002
	"000000000000000000000000001011111",	-- instrucción 3003
	"000000000000000000000000001011111",	-- instrucción 3004
	"000000000000000000000000001011111",	-- instrucción 3005
	"000000000000000000000000001011111",	-- instrucción 3006
	"000000000000000000000000001011111",	-- instrucción 3007
	"000000000000000000000000001011111",	-- instrucción 3008
	"000000000000000000000000001011111",	-- instrucción 3009
	"000000000000000000000000001011111",	-- instrucción 3010
	"000000000000000000000000001011111",	-- instrucción 3011
	"000000000000000000000000001011111",	-- instrucción 3012
	"000000000000000000000000001011111",	-- instrucción 3013
	"000000000000000000000000001011111",	-- instrucción 3014
	"000000000000000000000000001011111",	-- instrucción 3015
	"000000000000000000000000001011111",	-- instrucción 3016
	"000000000000000000000000001011111",	-- instrucción 3017
	"000000000000000000000000001011111",	-- instrucción 3018
	"000000000000000000000000001011111",	-- instrucción 3019
	"000000000000000000000000001011111",	-- instrucción 3020
	"000000000000000000000000001011111",	-- instrucción 3021
	"000000000000000000000000001011111",	-- instrucción 3022
	"000000000000000000000000001011111",	-- instrucción 3023
	"000000000000000000000000001011111",	-- instrucción 3024
	"000000000000000000000000001011111",	-- instrucción 3025
	"000000000000000000000000001011111",	-- instrucción 3026
	"000000000000000000000000001011111",	-- instrucción 3027
	"000000000000000000000000001011111",	-- instrucción 3028
	"000000000000000000000000001011111",	-- instrucción 3029
	"000000000000000000000000001011111",	-- instrucción 3030
	"000000000000000000000000001011111",	-- instrucción 3031
	"000000000000000000000000001011111",	-- instrucción 3032
	"000000000000000000000000001011111",	-- instrucción 3033
	"000000000000000000000000001011111",	-- instrucción 3034
	"000000000000000000000000001011111",	-- instrucción 3035
	"000000000000000000000000001011111",	-- instrucción 3036
	"000000000000000000000000001011111",	-- instrucción 3037
	"000000000000000000000000001011111",	-- instrucción 3038
	"000000000000000000000000001011111",	-- instrucción 3039
	"000000000000000000000000001011111",	-- instrucción 3040
	"000000000000000000000000001011111",	-- instrucción 3041
	"000000000000000000000000001011111",	-- instrucción 3042
	"000000000000000000000000001011111",	-- instrucción 3043
	"000000000000000000000000001011111",	-- instrucción 3044
	"000000000000000000000000001011111",	-- instrucción 3045
	"000000000000000000000000001011111",	-- instrucción 3046
	"000000000000000000000000001011111",	-- instrucción 3047
	"000000000000000000000000001011111",	-- instrucción 3048
	"000000000000000000000000001011111",	-- instrucción 3049
	"000000000000000000000000001011111",	-- instrucción 3050
	"000000000000000000000000001011111",	-- instrucción 3051
	"000000000000000000000000001011111",	-- instrucción 3052
	"000000000000000000000000001011111",	-- instrucción 3053
	"000000000000000000000000001011111",	-- instrucción 3054
	"000000000000000000000000001011111",	-- instrucción 3055
	"000000000000000000000000001011111",	-- instrucción 3056
	"000000000000000000000000001011111",	-- instrucción 3057
	"000000000000000000000000001011111",	-- instrucción 3058
	"000000000000000000000000001011111",	-- instrucción 3059
	"000000000000000000000000001011111",	-- instrucción 3060
	"000000000000000000000000001011111",	-- instrucción 3061
	"000000000000000000000000001011111",	-- instrucción 3062
	"000000000000000000000000001011111",	-- instrucción 3063
	"000000000000000000000000001011111",	-- instrucción 3064
	"000000000000000000000000001011111",	-- instrucción 3065
	"000000000000000000000000001011111",	-- instrucción 3066
	"000000000000000000000000001011111",	-- instrucción 3067
	"000000000000000000000000001011111",	-- instrucción 3068
	"000000000000000000000000001011111",	-- instrucción 3069
	"000000000000000000000000001011111",	-- instrucción 3070
	"000000000000000000000000001011111",	-- instrucción 3071
	"000000000000000000000000001011111",	-- instrucción 3072
	"000000000000000000000000001011111",	-- instrucción 3073
	"000000000000000000000000001011111",	-- instrucción 3074
	"000000000000000000000000001011111",	-- instrucción 3075
	"000000000000000000000000001011111",	-- instrucción 3076
	"000000000000000000000000001011111",	-- instrucción 3077
	"000000000000000000000000001011111",	-- instrucción 3078
	"000000000000000000000000001011111",	-- instrucción 3079
	"000000000000000000000000001011111",	-- instrucción 3080
	"000000000000000000000000001011111",	-- instrucción 3081
	"000000000000000000000000001011111",	-- instrucción 3082
	"000000000000000000000000001011111",	-- instrucción 3083
	"000000000000000000000000001011111",	-- instrucción 3084
	"000000000000000000000000001011111",	-- instrucción 3085
	"000000000000000000000000001011111",	-- instrucción 3086
	"000000000000000000000000001011111",	-- instrucción 3087
	"000000000000000000000000001011111",	-- instrucción 3088
	"000000000000000000000000001011111",	-- instrucción 3089
	"000000000000000000000000001011111",	-- instrucción 3090
	"000000000000000000000000001011111",	-- instrucción 3091
	"000000000000000000000000001011111",	-- instrucción 3092
	"000000000000000000000000001011111",	-- instrucción 3093
	"000000000000000000000000001011111",	-- instrucción 3094
	"000000000000000000000000001011111",	-- instrucción 3095
	"000000000000000000000000001011111",	-- instrucción 3096
	"000000000000000000000000001011111",	-- instrucción 3097
	"000000000000000000000000001011111",	-- instrucción 3098
	"000000000000000000000000001011111",	-- instrucción 3099
	"000000000000000000000000001011111",	-- instrucción 3100
	"000000000000000000000000001011111",	-- instrucción 3101
	"000000000000000000000000001011111",	-- instrucción 3102
	"000000000000000000000000001011111",	-- instrucción 3103
	"000000000000000000000000001011111",	-- instrucción 3104
	"000000000000000000000000001011111",	-- instrucción 3105
	"000000000000000000000000001011111",	-- instrucción 3106
	"000000000000000000000000001011111",	-- instrucción 3107
	"000000000000000000000000001011111",	-- instrucción 3108
	"000000000000000000000000001011111",	-- instrucción 3109
	"000000000000000000000000001011111",	-- instrucción 3110
	"000000000000000000000000001011111",	-- instrucción 3111
	"000000000000000000000000001011111",	-- instrucción 3112
	"000000000000000000000000001011111",	-- instrucción 3113
	"000000000000000000000000001011111",	-- instrucción 3114
	"000000000000000000000000001011111",	-- instrucción 3115
	"000000000000000000000000001011111",	-- instrucción 3116
	"000000000000000000000000001011111",	-- instrucción 3117
	"000000000000000000000000001011111",	-- instrucción 3118
	"000000000000000000000000001011111",	-- instrucción 3119
	"000000000000000000000000001011111",	-- instrucción 3120
	"000000000000000000000000001011111",	-- instrucción 3121
	"000000000000000000000000001011111",	-- instrucción 3122
	"000000000000000000000000001011111",	-- instrucción 3123
	"000000000000000000000000001011111",	-- instrucción 3124
	"000000000000000000000000001011111",	-- instrucción 3125
	"000000000000000000000000001011111",	-- instrucción 3126
	"000000000000000000000000001011111",	-- instrucción 3127
	"000000000000000000000000001011111",	-- instrucción 3128
	"000000000000000000000000001011111",	-- instrucción 3129
	"000000000000000000000000001011111",	-- instrucción 3130
	"000000000000000000000000001011111",	-- instrucción 3131
	"000000000000000000000000001011111",	-- instrucción 3132
	"000000000000000000000000001011111",	-- instrucción 3133
	"000000000000000000000000001011111",	-- instrucción 3134
	"000000000000000000000000001011111",	-- instrucción 3135
	"000000000000000000000000001011111",	-- instrucción 3136
	"000000000000000000000000001011111",	-- instrucción 3137
	"000000000000000000000000001011111",	-- instrucción 3138
	"000000000000000000000000001011111",	-- instrucción 3139
	"000000000000000000000000001011111",	-- instrucción 3140
	"000000000000000000000000001011111",	-- instrucción 3141
	"000000000000000000000000001011111",	-- instrucción 3142
	"000000000000000000000000001011111",	-- instrucción 3143
	"000000000000000000000000001011111",	-- instrucción 3144
	"000000000000000000000000001011111",	-- instrucción 3145
	"000000000000000000000000001011111",	-- instrucción 3146
	"000000000000000000000000001011111",	-- instrucción 3147
	"000000000000000000000000001011111",	-- instrucción 3148
	"000000000000000000000000001011111",	-- instrucción 3149
	"000000000000000000000000001011111",	-- instrucción 3150
	"000000000000000000000000001011111",	-- instrucción 3151
	"000000000000000000000000001011111",	-- instrucción 3152
	"000000000000000000000000001011111",	-- instrucción 3153
	"000000000000000000000000001011111",	-- instrucción 3154
	"000000000000000000000000001011111",	-- instrucción 3155
	"000000000000000000000000001011111",	-- instrucción 3156
	"000000000000000000000000001011111",	-- instrucción 3157
	"000000000000000000000000001011111",	-- instrucción 3158
	"000000000000000000000000001011111",	-- instrucción 3159
	"000000000000000000000000001011111",	-- instrucción 3160
	"000000000000000000000000001011111",	-- instrucción 3161
	"000000000000000000000000001011111",	-- instrucción 3162
	"000000000000000000000000001011111",	-- instrucción 3163
	"000000000000000000000000001011111",	-- instrucción 3164
	"000000000000000000000000001011111",	-- instrucción 3165
	"000000000000000000000000001011111",	-- instrucción 3166
	"000000000000000000000000001011111",	-- instrucción 3167
	"000000000000000000000000001011111",	-- instrucción 3168
	"000000000000000000000000001011111",	-- instrucción 3169
	"000000000000000000000000001011111",	-- instrucción 3170
	"000000000000000000000000001011111",	-- instrucción 3171
	"000000000000000000000000001011111",	-- instrucción 3172
	"000000000000000000000000001011111",	-- instrucción 3173
	"000000000000000000000000001011111",	-- instrucción 3174
	"000000000000000000000000001011111",	-- instrucción 3175
	"000000000000000000000000001011111",	-- instrucción 3176
	"000000000000000000000000001011111",	-- instrucción 3177
	"000000000000000000000000001011111",	-- instrucción 3178
	"000000000000000000000000001011111",	-- instrucción 3179
	"000000000000000000000000001011111",	-- instrucción 3180
	"000000000000000000000000001011111",	-- instrucción 3181
	"000000000000000000000000001011111",	-- instrucción 3182
	"000000000000000000000000001011111",	-- instrucción 3183
	"000000000000000000000000001011111",	-- instrucción 3184
	"000000000000000000000000001011111",	-- instrucción 3185
	"000000000000000000000000001011111",	-- instrucción 3186
	"000000000000000000000000001011111",	-- instrucción 3187
	"000000000000000000000000001011111",	-- instrucción 3188
	"000000000000000000000000001011111",	-- instrucción 3189
	"000000000000000000000000001011111",	-- instrucción 3190
	"000000000000000000000000001011111",	-- instrucción 3191
	"000000000000000000000000001011111",	-- instrucción 3192
	"000000000000000000000000001011111",	-- instrucción 3193
	"000000000000000000000000001011111",	-- instrucción 3194
	"000000000000000000000000001011111",	-- instrucción 3195
	"000000000000000000000000001011111",	-- instrucción 3196
	"000000000000000000000000001011111",	-- instrucción 3197
	"000000000000000000000000001011111",	-- instrucción 3198
	"000000000000000000000000001011111",	-- instrucción 3199
	"000000000000000000000000001011111",	-- instrucción 3200
	"000000000000000000000000001011111",	-- instrucción 3201
	"000000000000000000000000001011111",	-- instrucción 3202
	"000000000000000000000000001011111",	-- instrucción 3203
	"000000000000000000000000001011111",	-- instrucción 3204
	"000000000000000000000000001011111",	-- instrucción 3205
	"000000000000000000000000001011111",	-- instrucción 3206
	"000000000000000000000000001011111",	-- instrucción 3207
	"000000000000000000000000001011111",	-- instrucción 3208
	"000000000000000000000000001011111",	-- instrucción 3209
	"000000000000000000000000001011111",	-- instrucción 3210
	"000000000000000000000000001011111",	-- instrucción 3211
	"000000000000000000000000001011111",	-- instrucción 3212
	"000000000000000000000000001011111",	-- instrucción 3213
	"000000000000000000000000001011111",	-- instrucción 3214
	"000000000000000000000000001011111",	-- instrucción 3215
	"000000000000000000000000001011111",	-- instrucción 3216
	"000000000000000000000000001011111",	-- instrucción 3217
	"000000000000000000000000001011111",	-- instrucción 3218
	"000000000000000000000000001011111",	-- instrucción 3219
	"000000000000000000000000001011111",	-- instrucción 3220
	"000000000000000000000000001011111",	-- instrucción 3221
	"000000000000000000000000001011111",	-- instrucción 3222
	"000000000000000000000000001011111",	-- instrucción 3223
	"000000000000000000000000001011111",	-- instrucción 3224
	"000000000000000000000000001011111",	-- instrucción 3225
	"000000000000000000000000001011111",	-- instrucción 3226
	"000000000000000000000000001011111",	-- instrucción 3227
	"000000000000000000000000001011111",	-- instrucción 3228
	"000000000000000000000000001011111",	-- instrucción 3229
	"000000000000000000000000001011111",	-- instrucción 3230
	"000000000000000000000000001011111",	-- instrucción 3231
	"000000000000000000000000001011111",	-- instrucción 3232
	"000000000000000000000000001011111",	-- instrucción 3233
	"000000000000000000000000001011111",	-- instrucción 3234
	"000000000000000000000000001011111",	-- instrucción 3235
	"000000000000000000000000001011111",	-- instrucción 3236
	"000000000000000000000000001011111",	-- instrucción 3237
	"000000000000000000000000001011111",	-- instrucción 3238
	"000000000000000000000000001011111",	-- instrucción 3239
	"000000000000000000000000001011111",	-- instrucción 3240
	"000000000000000000000000001011111",	-- instrucción 3241
	"000000000000000000000000001011111",	-- instrucción 3242
	"000000000000000000000000001011111",	-- instrucción 3243
	"000000000000000000000000001011111",	-- instrucción 3244
	"000000000000000000000000001011111",	-- instrucción 3245
	"000000000000000000000000001011111",	-- instrucción 3246
	"000000000000000000000000001011111",	-- instrucción 3247
	"000000000000000000000000001011111",	-- instrucción 3248
	"000000000000000000000000001011111",	-- instrucción 3249
	"000000000000000000000000001011111",	-- instrucción 3250
	"000000000000000000000000001011111",	-- instrucción 3251
	"000000000000000000000000001011111",	-- instrucción 3252
	"000000000000000000000000001011111",	-- instrucción 3253
	"000000000000000000000000001011111",	-- instrucción 3254
	"000000000000000000000000001011111",	-- instrucción 3255
	"000000000000000000000000001011111",	-- instrucción 3256
	"000000000000000000000000001011111",	-- instrucción 3257
	"000000000000000000000000001011111",	-- instrucción 3258
	"000000000000000000000000001011111",	-- instrucción 3259
	"000000000000000000000000001011111",	-- instrucción 3260
	"000000000000000000000000001011111",	-- instrucción 3261
	"000000000000000000000000001011111",	-- instrucción 3262
	"000000000000000000000000001011111",	-- instrucción 3263
	"000000000000000000000000001011111",	-- instrucción 3264
	"000000000000000000000000001011111",	-- instrucción 3265
	"000000000000000000000000001011111",	-- instrucción 3266
	"000000000000000000000000001011111",	-- instrucción 3267
	"000000000000000000000000001011111",	-- instrucción 3268
	"000000000000000000000000001011111",	-- instrucción 3269
	"000000000000000000000000001011111",	-- instrucción 3270
	"000000000000000000000000001011111",	-- instrucción 3271
	"000000000000000000000000001011111",	-- instrucción 3272
	"000000000000000000000000001011111",	-- instrucción 3273
	"000000000000000000000000001011111",	-- instrucción 3274
	"000000000000000000000000001011111",	-- instrucción 3275
	"000000000000000000000000001011111",	-- instrucción 3276
	"000000000000000000000000001011111",	-- instrucción 3277
	"000000000000000000000000001011111",	-- instrucción 3278
	"000000000000000000000000001011111",	-- instrucción 3279
	"000000000000000000000000001011111",	-- instrucción 3280
	"000000000000000000000000001011111",	-- instrucción 3281
	"000000000000000000000000001011111",	-- instrucción 3282
	"000000000000000000000000001011111",	-- instrucción 3283
	"000000000000000000000000001011111",	-- instrucción 3284
	"000000000000000000000000001011111",	-- instrucción 3285
	"000000000000000000000000001011111",	-- instrucción 3286
	"000000000000000000000000001011111",	-- instrucción 3287
	"000000000000000000000000001011111",	-- instrucción 3288
	"000000000000000000000000001011111",	-- instrucción 3289
	"000000000000000000000000001011111",	-- instrucción 3290
	"000000000000000000000000001011111",	-- instrucción 3291
	"000000000000000000000000001011111",	-- instrucción 3292
	"000000000000000000000000001011111",	-- instrucción 3293
	"000000000000000000000000001011111",	-- instrucción 3294
	"000000000000000000000000001011111",	-- instrucción 3295
	"000000000000000000000000001011111",	-- instrucción 3296
	"000000000000000000000000001011111",	-- instrucción 3297
	"000000000000000000000000001011111",	-- instrucción 3298
	"000000000000000000000000001011111",	-- instrucción 3299
	"000000000000000000000000001011111",	-- instrucción 3300
	"000000000000000000000000001011111",	-- instrucción 3301
	"000000000000000000000000001011111",	-- instrucción 3302
	"000000000000000000000000001011111",	-- instrucción 3303
	"000000000000000000000000001011111",	-- instrucción 3304
	"000000000000000000000000001011111",	-- instrucción 3305
	"000000000000000000000000001011111",	-- instrucción 3306
	"000000000000000000000000001011111",	-- instrucción 3307
	"000000000000000000000000001011111",	-- instrucción 3308
	"000000000000000000000000001011111",	-- instrucción 3309
	"000000000000000000000000001011111",	-- instrucción 3310
	"000000000000000000000000001011111",	-- instrucción 3311
	"000000000000000000000000001011111",	-- instrucción 3312
	"000000000000000000000000001011111",	-- instrucción 3313
	"000000000000000000000000001011111",	-- instrucción 3314
	"000000000000000000000000001011111",	-- instrucción 3315
	"000000000000000000000000001011111",	-- instrucción 3316
	"000000000000000000000000001011111",	-- instrucción 3317
	"000000000000000000000000001011111",	-- instrucción 3318
	"000000000000000000000000001011111",	-- instrucción 3319
	"000000000000000000000000001011111",	-- instrucción 3320
	"000000000000000000000000001011111",	-- instrucción 3321
	"000000000000000000000000001011111",	-- instrucción 3322
	"000000000000000000000000001011111",	-- instrucción 3323
	"000000000000000000000000001011111",	-- instrucción 3324
	"000000000000000000000000001011111",	-- instrucción 3325
	"000000000000000000000000001011111",	-- instrucción 3326
	"000000000000000000000000001011111",	-- instrucción 3327
	"000000000000000000000000001011111",	-- instrucción 3328
	"000000000000000000000000001011111",	-- instrucción 3329
	"000000000000000000000000001011111",	-- instrucción 3330
	"000000000000000000000000001011111",	-- instrucción 3331
	"000000000000000000000000001011111",	-- instrucción 3332
	"000000000000000000000000001011111",	-- instrucción 3333
	"000000000000000000000000001011111",	-- instrucción 3334
	"000000000000000000000000001011111",	-- instrucción 3335
	"000000000000000000000000001011111",	-- instrucción 3336
	"000000000000000000000000001011111",	-- instrucción 3337
	"000000000000000000000000001011111",	-- instrucción 3338
	"000000000000000000000000001011111",	-- instrucción 3339
	"000000000000000000000000001011111",	-- instrucción 3340
	"000000000000000000000000001011111",	-- instrucción 3341
	"000000000000000000000000001011111",	-- instrucción 3342
	"000000000000000000000000001011111",	-- instrucción 3343
	"000000000000000000000000001011111",	-- instrucción 3344
	"000000000000000000000000001011111",	-- instrucción 3345
	"000000000000000000000000001011111",	-- instrucción 3346
	"000000000000000000000000001011111",	-- instrucción 3347
	"000000000000000000000000001011111",	-- instrucción 3348
	"000000000000000000000000001011111",	-- instrucción 3349
	"000000000000000000000000001011111",	-- instrucción 3350
	"000000000000000000000000001011111",	-- instrucción 3351
	"000000000000000000000000001011111",	-- instrucción 3352
	"000000000000000000000000001011111",	-- instrucción 3353
	"000000000000000000000000001011111",	-- instrucción 3354
	"000000000000000000000000001011111",	-- instrucción 3355
	"000000000000000000000000001011111",	-- instrucción 3356
	"000000000000000000000000001011111",	-- instrucción 3357
	"000000000000000000000000001011111",	-- instrucción 3358
	"000000000000000000000000001011111",	-- instrucción 3359
	"000000000000000000000000001011111",	-- instrucción 3360
	"000000000000000000000000001011111",	-- instrucción 3361
	"000000000000000000000000001011111",	-- instrucción 3362
	"000000000000000000000000001011111",	-- instrucción 3363
	"000000000000000000000000001011111",	-- instrucción 3364
	"000000000000000000000000001011111",	-- instrucción 3365
	"000000000000000000000000001011111",	-- instrucción 3366
	"000000000000000000000000001011111",	-- instrucción 3367
	"000000000000000000000000001011111",	-- instrucción 3368
	"000000000000000000000000001011111",	-- instrucción 3369
	"000000000000000000000000001011111",	-- instrucción 3370
	"000000000000000000000000001011111",	-- instrucción 3371
	"000000000000000000000000001011111",	-- instrucción 3372
	"000000000000000000000000001011111",	-- instrucción 3373
	"000000000000000000000000001011111",	-- instrucción 3374
	"000000000000000000000000001011111",	-- instrucción 3375
	"000000000000000000000000001011111",	-- instrucción 3376
	"000000000000000000000000001011111",	-- instrucción 3377
	"000000000000000000000000001011111",	-- instrucción 3378
	"000000000000000000000000001011111",	-- instrucción 3379
	"000000000000000000000000001011111",	-- instrucción 3380
	"000000000000000000000000001011111",	-- instrucción 3381
	"000000000000000000000000001011111",	-- instrucción 3382
	"000000000000000000000000001011111",	-- instrucción 3383
	"000000000000000000000000001011111",	-- instrucción 3384
	"000000000000000000000000001011111",	-- instrucción 3385
	"000000000000000000000000001011111",	-- instrucción 3386
	"000000000000000000000000001011111",	-- instrucción 3387
	"000000000000000000000000001011111",	-- instrucción 3388
	"000000000000000000000000001011111",	-- instrucción 3389
	"000000000000000000000000001011111",	-- instrucción 3390
	"000000000000000000000000001011111",	-- instrucción 3391
	"000000000000000000000000001011111",	-- instrucción 3392
	"000000000000000000000000001011111",	-- instrucción 3393
	"000000000000000000000000001011111",	-- instrucción 3394
	"000000000000000000000000001011111",	-- instrucción 3395
	"000000000000000000000000001011111",	-- instrucción 3396
	"000000000000000000000000001011111",	-- instrucción 3397
	"000000000000000000000000001011111",	-- instrucción 3398
	"000000000000000000000000001011111",	-- instrucción 3399
	"000000000000000000000000001011111",	-- instrucción 3400
	"000000000000000000000000001011111",	-- instrucción 3401
	"000000000000000000000000001011111",	-- instrucción 3402
	"000000000000000000000000001011111",	-- instrucción 3403
	"000000000000000000000000001011111",	-- instrucción 3404
	"000000000000000000000000001011111",	-- instrucción 3405
	"000000000000000000000000001011111",	-- instrucción 3406
	"000000000000000000000000001011111",	-- instrucción 3407
	"000000000000000000000000001011111",	-- instrucción 3408
	"000000000000000000000000001011111",	-- instrucción 3409
	"000000000000000000000000001011111",	-- instrucción 3410
	"000000000000000000000000001011111",	-- instrucción 3411
	"000000000000000000000000001011111",	-- instrucción 3412
	"000000000000000000000000001011111",	-- instrucción 3413
	"000000000000000000000000001011111",	-- instrucción 3414
	"000000000000000000000000001011111",	-- instrucción 3415
	"000000000000000000000000001011111",	-- instrucción 3416
	"000000000000000000000000001011111",	-- instrucción 3417
	"000000000000000000000000001011111",	-- instrucción 3418
	"000000000000000000000000001011111",	-- instrucción 3419
	"000000000000000000000000001011111",	-- instrucción 3420
	"000000000000000000000000001011111",	-- instrucción 3421
	"000000000000000000000000001011111",	-- instrucción 3422
	"000000000000000000000000001011111",	-- instrucción 3423
	"000000000000000000000000001011111",	-- instrucción 3424
	"000000000000000000000000001011111",	-- instrucción 3425
	"000000000000000000000000001011111",	-- instrucción 3426
	"000000000000000000000000001011111",	-- instrucción 3427
	"000000000000000000000000001011111",	-- instrucción 3428
	"000000000000000000000000001011111",	-- instrucción 3429
	"000000000000000000000000001011111",	-- instrucción 3430
	"000000000000000000000000001011111",	-- instrucción 3431
	"000000000000000000000000001011111",	-- instrucción 3432
	"000000000000000000000000001011111",	-- instrucción 3433
	"000000000000000000000000001011111",	-- instrucción 3434
	"000000000000000000000000001011111",	-- instrucción 3435
	"000000000000000000000000001011111",	-- instrucción 3436
	"000000000000000000000000001011111",	-- instrucción 3437
	"000000000000000000000000001011111",	-- instrucción 3438
	"000000000000000000000000001011111",	-- instrucción 3439
	"000000000000000000000000001011111",	-- instrucción 3440
	"000000000000000000000000001011111",	-- instrucción 3441
	"000000000000000000000000001011111",	-- instrucción 3442
	"000000000000000000000000001011111",	-- instrucción 3443
	"000000000000000000000000001011111",	-- instrucción 3444
	"000000000000000000000000001011111",	-- instrucción 3445
	"000000000000000000000000001011111",	-- instrucción 3446
	"000000000000000000000000001011111",	-- instrucción 3447
	"000000000000000000000000001011111",	-- instrucción 3448
	"000000000000000000000000001011111",	-- instrucción 3449
	"000000000000000000000000001011111",	-- instrucción 3450
	"000000000000000000000000001011111",	-- instrucción 3451
	"000000000000000000000000001011111",	-- instrucción 3452
	"000000000000000000000000001011111",	-- instrucción 3453
	"000000000000000000000000001011111",	-- instrucción 3454
	"000000000000000000000000001011111",	-- instrucción 3455
	"000000000000000000000000001011111",	-- instrucción 3456
	"000000000000000000000000001011111",	-- instrucción 3457
	"000000000000000000000000001011111",	-- instrucción 3458
	"000000000000000000000000001011111",	-- instrucción 3459
	"000000000000000000000000001011111",	-- instrucción 3460
	"000000000000000000000000001011111",	-- instrucción 3461
	"000000000000000000000000001011111",	-- instrucción 3462
	"000000000000000000000000001011111",	-- instrucción 3463
	"000000000000000000000000001011111",	-- instrucción 3464
	"000000000000000000000000001011111",	-- instrucción 3465
	"000000000000000000000000001011111",	-- instrucción 3466
	"000000000000000000000000001011111",	-- instrucción 3467
	"000000000000000000000000001011111",	-- instrucción 3468
	"000000000000000000000000001011111",	-- instrucción 3469
	"000000000000000000000000001011111",	-- instrucción 3470
	"000000000000000000000000001011111",	-- instrucción 3471
	"000000000000000000000000001011111",	-- instrucción 3472
	"000000000000000000000000001011111",	-- instrucción 3473
	"000000000000000000000000001011111",	-- instrucción 3474
	"000000000000000000000000001011111",	-- instrucción 3475
	"000000000000000000000000001011111",	-- instrucción 3476
	"000000000000000000000000001011111",	-- instrucción 3477
	"000000000000000000000000001011111",	-- instrucción 3478
	"000000000000000000000000001011111",	-- instrucción 3479
	"000000000000000000000000001011111",	-- instrucción 3480
	"000000000000000000000000001011111",	-- instrucción 3481
	"000000000000000000000000001011111",	-- instrucción 3482
	"000000000000000000000000001011111",	-- instrucción 3483
	"000000000000000000000000001011111",	-- instrucción 3484
	"000000000000000000000000001011111",	-- instrucción 3485
	"000000000000000000000000001011111",	-- instrucción 3486
	"000000000000000000000000001011111",	-- instrucción 3487
	"000000000000000000000000001011111",	-- instrucción 3488
	"000000000000000000000000001011111",	-- instrucción 3489
	"000000000000000000000000001011111",	-- instrucción 3490
	"000000000000000000000000001011111",	-- instrucción 3491
	"000000000000000000000000001011111",	-- instrucción 3492
	"000000000000000000000000001011111",	-- instrucción 3493
	"000000000000000000000000001011111",	-- instrucción 3494
	"000000000000000000000000001011111",	-- instrucción 3495
	"000000000000000000000000001011111",	-- instrucción 3496
	"000000000000000000000000001011111",	-- instrucción 3497
	"000000000000000000000000001011111",	-- instrucción 3498
	"000000000000000000000000001011111",	-- instrucción 3499
	"000000000000000000000000001011111",	-- instrucción 3500
	"000000000000000000000000001011111",	-- instrucción 3501
	"000000000000000000000000001011111",	-- instrucción 3502
	"000000000000000000000000001011111",	-- instrucción 3503
	"000000000000000000000000001011111",	-- instrucción 3504
	"000000000000000000000000001011111",	-- instrucción 3505
	"000000000000000000000000001011111",	-- instrucción 3506
	"000000000000000000000000001011111",	-- instrucción 3507
	"000000000000000000000000001011111",	-- instrucción 3508
	"000000000000000000000000001011111",	-- instrucción 3509
	"000000000000000000000000001011111",	-- instrucción 3510
	"000000000000000000000000001011111",	-- instrucción 3511
	"000000000000000000000000001011111",	-- instrucción 3512
	"000000000000000000000000001011111",	-- instrucción 3513
	"000000000000000000000000001011111",	-- instrucción 3514
	"000000000000000000000000001011111",	-- instrucción 3515
	"000000000000000000000000001011111",	-- instrucción 3516
	"000000000000000000000000001011111",	-- instrucción 3517
	"000000000000000000000000001011111",	-- instrucción 3518
	"000000000000000000000000001011111",	-- instrucción 3519
	"000000000000000000000000001011111",	-- instrucción 3520
	"000000000000000000000000001011111",	-- instrucción 3521
	"000000000000000000000000001011111",	-- instrucción 3522
	"000000000000000000000000001011111",	-- instrucción 3523
	"000000000000000000000000001011111",	-- instrucción 3524
	"000000000000000000000000001011111",	-- instrucción 3525
	"000000000000000000000000001011111",	-- instrucción 3526
	"000000000000000000000000001011111",	-- instrucción 3527
	"000000000000000000000000001011111",	-- instrucción 3528
	"000000000000000000000000001011111",	-- instrucción 3529
	"000000000000000000000000001011111",	-- instrucción 3530
	"000000000000000000000000001011111",	-- instrucción 3531
	"000000000000000000000000001011111",	-- instrucción 3532
	"000000000000000000000000001011111",	-- instrucción 3533
	"000000000000000000000000001011111",	-- instrucción 3534
	"000000000000000000000000001011111",	-- instrucción 3535
	"000000000000000000000000001011111",	-- instrucción 3536
	"000000000000000000000000001011111",	-- instrucción 3537
	"000000000000000000000000001011111",	-- instrucción 3538
	"000000000000000000000000001011111",	-- instrucción 3539
	"000000000000000000000000001011111",	-- instrucción 3540
	"000000000000000000000000001011111",	-- instrucción 3541
	"000000000000000000000000001011111",	-- instrucción 3542
	"000000000000000000000000001011111",	-- instrucción 3543
	"000000000000000000000000001011111",	-- instrucción 3544
	"000000000000000000000000001011111",	-- instrucción 3545
	"000000000000000000000000001011111",	-- instrucción 3546
	"000000000000000000000000001011111",	-- instrucción 3547
	"000000000000000000000000001011111",	-- instrucción 3548
	"000000000000000000000000001011111",	-- instrucción 3549
	"000000000000000000000000001011111",	-- instrucción 3550
	"000000000000000000000000001011111",	-- instrucción 3551
	"000000000000000000000000001011111",	-- instrucción 3552
	"000000000000000000000000001011111",	-- instrucción 3553
	"000000000000000000000000001011111",	-- instrucción 3554
	"000000000000000000000000001011111",	-- instrucción 3555
	"000000000000000000000000001011111",	-- instrucción 3556
	"000000000000000000000000001011111",	-- instrucción 3557
	"000000000000000000000000001011111",	-- instrucción 3558
	"000000000000000000000000001011111",	-- instrucción 3559
	"000000000000000000000000001011111",	-- instrucción 3560
	"000000000000000000000000001011111",	-- instrucción 3561
	"000000000000000000000000001011111",	-- instrucción 3562
	"000000000000000000000000001011111",	-- instrucción 3563
	"000000000000000000000000001011111",	-- instrucción 3564
	"000000000000000000000000001011111",	-- instrucción 3565
	"000000000000000000000000001011111",	-- instrucción 3566
	"000000000000000000000000001011111",	-- instrucción 3567
	"000000000000000000000000001011111",	-- instrucción 3568
	"000000000000000000000000001011111",	-- instrucción 3569
	"000000000000000000000000001011111",	-- instrucción 3570
	"000000000000000000000000001011111",	-- instrucción 3571
	"000000000000000000000000001011111",	-- instrucción 3572
	"000000000000000000000000001011111",	-- instrucción 3573
	"000000000000000000000000001011111",	-- instrucción 3574
	"000000000000000000000000001011111",	-- instrucción 3575
	"000000000000000000000000001011111",	-- instrucción 3576
	"000000000000000000000000001011111",	-- instrucción 3577
	"000000000000000000000000001011111",	-- instrucción 3578
	"000000000000000000000000001011111",	-- instrucción 3579
	"000000000000000000000000001011111",	-- instrucción 3580
	"000000000000000000000000001011111",	-- instrucción 3581
	"000000000000000000000000001011111",	-- instrucción 3582
	"000000000000000000000000001011111",	-- instrucción 3583
	"000000000000000000000000001011111",	-- instrucción 3584
	"000000000000000000000000001011111",	-- instrucción 3585
	"000000000000000000000000001011111",	-- instrucción 3586
	"000000000000000000000000001011111",	-- instrucción 3587
	"000000000000000000000000001011111",	-- instrucción 3588
	"000000000000000000000000001011111",	-- instrucción 3589
	"000000000000000000000000001011111",	-- instrucción 3590
	"000000000000000000000000001011111",	-- instrucción 3591
	"000000000000000000000000001011111",	-- instrucción 3592
	"000000000000000000000000001011111",	-- instrucción 3593
	"000000000000000000000000001011111",	-- instrucción 3594
	"000000000000000000000000001011111",	-- instrucción 3595
	"000000000000000000000000001011111",	-- instrucción 3596
	"000000000000000000000000001011111",	-- instrucción 3597
	"000000000000000000000000001011111",	-- instrucción 3598
	"000000000000000000000000001011111",	-- instrucción 3599
	"000000000000000000000000001011111",	-- instrucción 3600
	"000000000000000000000000001011111",	-- instrucción 3601
	"000000000000000000000000001011111",	-- instrucción 3602
	"000000000000000000000000001011111",	-- instrucción 3603
	"000000000000000000000000001011111",	-- instrucción 3604
	"000000000000000000000000001011111",	-- instrucción 3605
	"000000000000000000000000001011111",	-- instrucción 3606
	"000000000000000000000000001011111",	-- instrucción 3607
	"000000000000000000000000001011111",	-- instrucción 3608
	"000000000000000000000000001011111",	-- instrucción 3609
	"000000000000000000000000001011111",	-- instrucción 3610
	"000000000000000000000000001011111",	-- instrucción 3611
	"000000000000000000000000001011111",	-- instrucción 3612
	"000000000000000000000000001011111",	-- instrucción 3613
	"000000000000000000000000001011111",	-- instrucción 3614
	"000000000000000000000000001011111",	-- instrucción 3615
	"000000000000000000000000001011111",	-- instrucción 3616
	"000000000000000000000000001011111",	-- instrucción 3617
	"000000000000000000000000001011111",	-- instrucción 3618
	"000000000000000000000000001011111",	-- instrucción 3619
	"000000000000000000000000001011111",	-- instrucción 3620
	"000000000000000000000000001011111",	-- instrucción 3621
	"000000000000000000000000001011111",	-- instrucción 3622
	"000000000000000000000000001011111",	-- instrucción 3623
	"000000000000000000000000001011111",	-- instrucción 3624
	"000000000000000000000000001011111",	-- instrucción 3625
	"000000000000000000000000001011111",	-- instrucción 3626
	"000000000000000000000000001011111",	-- instrucción 3627
	"000000000000000000000000001011111",	-- instrucción 3628
	"000000000000000000000000001011111",	-- instrucción 3629
	"000000000000000000000000001011111",	-- instrucción 3630
	"000000000000000000000000001011111",	-- instrucción 3631
	"000000000000000000000000001011111",	-- instrucción 3632
	"000000000000000000000000001011111",	-- instrucción 3633
	"000000000000000000000000001011111",	-- instrucción 3634
	"000000000000000000000000001011111",	-- instrucción 3635
	"000000000000000000000000001011111",	-- instrucción 3636
	"000000000000000000000000001011111",	-- instrucción 3637
	"000000000000000000000000001011111",	-- instrucción 3638
	"000000000000000000000000001011111",	-- instrucción 3639
	"000000000000000000000000001011111",	-- instrucción 3640
	"000000000000000000000000001011111",	-- instrucción 3641
	"000000000000000000000000001011111",	-- instrucción 3642
	"000000000000000000000000001011111",	-- instrucción 3643
	"000000000000000000000000001011111",	-- instrucción 3644
	"000000000000000000000000001011111",	-- instrucción 3645
	"000000000000000000000000001011111",	-- instrucción 3646
	"000000000000000000000000001011111",	-- instrucción 3647
	"000000000000000000000000001011111",	-- instrucción 3648
	"000000000000000000000000001011111",	-- instrucción 3649
	"000000000000000000000000001011111",	-- instrucción 3650
	"000000000000000000000000001011111",	-- instrucción 3651
	"000000000000000000000000001011111",	-- instrucción 3652
	"000000000000000000000000001011111",	-- instrucción 3653
	"000000000000000000000000001011111",	-- instrucción 3654
	"000000000000000000000000001011111",	-- instrucción 3655
	"000000000000000000000000001011111",	-- instrucción 3656
	"000000000000000000000000001011111",	-- instrucción 3657
	"000000000000000000000000001011111",	-- instrucción 3658
	"000000000000000000000000001011111",	-- instrucción 3659
	"000000000000000000000000001011111",	-- instrucción 3660
	"000000000000000000000000001011111",	-- instrucción 3661
	"000000000000000000000000001011111",	-- instrucción 3662
	"000000000000000000000000001011111",	-- instrucción 3663
	"000000000000000000000000001011111",	-- instrucción 3664
	"000000000000000000000000001011111",	-- instrucción 3665
	"000000000000000000000000001011111",	-- instrucción 3666
	"000000000000000000000000001011111",	-- instrucción 3667
	"000000000000000000000000001011111",	-- instrucción 3668
	"000000000000000000000000001011111",	-- instrucción 3669
	"000000000000000000000000001011111",	-- instrucción 3670
	"000000000000000000000000001011111",	-- instrucción 3671
	"000000000000000000000000001011111",	-- instrucción 3672
	"000000000000000000000000001011111",	-- instrucción 3673
	"000000000000000000000000001011111",	-- instrucción 3674
	"000000000000000000000000001011111",	-- instrucción 3675
	"000000000000000000000000001011111",	-- instrucción 3676
	"000000000000000000000000001011111",	-- instrucción 3677
	"000000000000000000000000001011111",	-- instrucción 3678
	"000000000000000000000000001011111",	-- instrucción 3679
	"000000000000000000000000001011111",	-- instrucción 3680
	"000000000000000000000000001011111",	-- instrucción 3681
	"000000000000000000000000001011111",	-- instrucción 3682
	"000000000000000000000000001011111",	-- instrucción 3683
	"000000000000000000000000001011111",	-- instrucción 3684
	"000000000000000000000000001011111",	-- instrucción 3685
	"000000000000000000000000001011111",	-- instrucción 3686
	"000000000000000000000000001011111",	-- instrucción 3687
	"000000000000000000000000001011111",	-- instrucción 3688
	"000000000000000000000000001011111",	-- instrucción 3689
	"000000000000000000000000001011111",	-- instrucción 3690
	"000000000000000000000000001011111",	-- instrucción 3691
	"000000000000000000000000001011111",	-- instrucción 3692
	"000000000000000000000000001011111",	-- instrucción 3693
	"000000000000000000000000001011111",	-- instrucción 3694
	"000000000000000000000000001011111",	-- instrucción 3695
	"000000000000000000000000001011111",	-- instrucción 3696
	"000000000000000000000000001011111",	-- instrucción 3697
	"000000000000000000000000001011111",	-- instrucción 3698
	"000000000000000000000000001011111",	-- instrucción 3699
	"000000000000000000000000001011111",	-- instrucción 3700
	"000000000000000000000000001011111",	-- instrucción 3701
	"000000000000000000000000001011111",	-- instrucción 3702
	"000000000000000000000000001011111",	-- instrucción 3703
	"000000000000000000000000001011111",	-- instrucción 3704
	"000000000000000000000000001011111",	-- instrucción 3705
	"000000000000000000000000001011111",	-- instrucción 3706
	"000000000000000000000000001011111",	-- instrucción 3707
	"000000000000000000000000001011111",	-- instrucción 3708
	"000000000000000000000000001011111",	-- instrucción 3709
	"000000000000000000000000001011111",	-- instrucción 3710
	"000000000000000000000000001011111",	-- instrucción 3711
	"000000000000000000000000001011111",	-- instrucción 3712
	"000000000000000000000000001011111",	-- instrucción 3713
	"000000000000000000000000001011111",	-- instrucción 3714
	"000000000000000000000000001011111",	-- instrucción 3715
	"000000000000000000000000001011111",	-- instrucción 3716
	"000000000000000000000000001011111",	-- instrucción 3717
	"000000000000000000000000001011111",	-- instrucción 3718
	"000000000000000000000000001011111",	-- instrucción 3719
	"000000000000000000000000001011111",	-- instrucción 3720
	"000000000000000000000000001011111",	-- instrucción 3721
	"000000000000000000000000001011111",	-- instrucción 3722
	"000000000000000000000000001011111",	-- instrucción 3723
	"000000000000000000000000001011111",	-- instrucción 3724
	"000000000000000000000000001011111",	-- instrucción 3725
	"000000000000000000000000001011111",	-- instrucción 3726
	"000000000000000000000000001011111",	-- instrucción 3727
	"000000000000000000000000001011111",	-- instrucción 3728
	"000000000000000000000000001011111",	-- instrucción 3729
	"000000000000000000000000001011111",	-- instrucción 3730
	"000000000000000000000000001011111",	-- instrucción 3731
	"000000000000000000000000001011111",	-- instrucción 3732
	"000000000000000000000000001011111",	-- instrucción 3733
	"000000000000000000000000001011111",	-- instrucción 3734
	"000000000000000000000000001011111",	-- instrucción 3735
	"000000000000000000000000001011111",	-- instrucción 3736
	"000000000000000000000000001011111",	-- instrucción 3737
	"000000000000000000000000001011111",	-- instrucción 3738
	"000000000000000000000000001011111",	-- instrucción 3739
	"000000000000000000000000001011111",	-- instrucción 3740
	"000000000000000000000000001011111",	-- instrucción 3741
	"000000000000000000000000001011111",	-- instrucción 3742
	"000000000000000000000000001011111",	-- instrucción 3743
	"000000000000000000000000001011111",	-- instrucción 3744
	"000000000000000000000000001011111",	-- instrucción 3745
	"000000000000000000000000001011111",	-- instrucción 3746
	"000000000000000000000000001011111",	-- instrucción 3747
	"000000000000000000000000001011111",	-- instrucción 3748
	"000000000000000000000000001011111",	-- instrucción 3749
	"000000000000000000000000001011111",	-- instrucción 3750
	"000000000000000000000000001011111",	-- instrucción 3751
	"000000000000000000000000001011111",	-- instrucción 3752
	"000000000000000000000000001011111",	-- instrucción 3753
	"000000000000000000000000001011111",	-- instrucción 3754
	"000000000000000000000000001011111",	-- instrucción 3755
	"000000000000000000000000001011111",	-- instrucción 3756
	"000000000000000000000000001011111",	-- instrucción 3757
	"000000000000000000000000001011111",	-- instrucción 3758
	"000000000000000000000000001011111",	-- instrucción 3759
	"000000000000000000000000001011111",	-- instrucción 3760
	"000000000000000000000000001011111",	-- instrucción 3761
	"000000000000000000000000001011111",	-- instrucción 3762
	"000000000000000000000000001011111",	-- instrucción 3763
	"000000000000000000000000001011111",	-- instrucción 3764
	"000000000000000000000000001011111",	-- instrucción 3765
	"000000000000000000000000001011111",	-- instrucción 3766
	"000000000000000000000000001011111",	-- instrucción 3767
	"000000000000000000000000001011111",	-- instrucción 3768
	"000000000000000000000000001011111",	-- instrucción 3769
	"000000000000000000000000001011111",	-- instrucción 3770
	"000000000000000000000000001011111",	-- instrucción 3771
	"000000000000000000000000001011111",	-- instrucción 3772
	"000000000000000000000000001011111",	-- instrucción 3773
	"000000000000000000000000001011111",	-- instrucción 3774
	"000000000000000000000000001011111",	-- instrucción 3775
	"000000000000000000000000001011111",	-- instrucción 3776
	"000000000000000000000000001011111",	-- instrucción 3777
	"000000000000000000000000001011111",	-- instrucción 3778
	"000000000000000000000000001011111",	-- instrucción 3779
	"000000000000000000000000001011111",	-- instrucción 3780
	"000000000000000000000000001011111",	-- instrucción 3781
	"000000000000000000000000001011111",	-- instrucción 3782
	"000000000000000000000000001011111",	-- instrucción 3783
	"000000000000000000000000001011111",	-- instrucción 3784
	"000000000000000000000000001011111",	-- instrucción 3785
	"000000000000000000000000001011111",	-- instrucción 3786
	"000000000000000000000000001011111",	-- instrucción 3787
	"000000000000000000000000001011111",	-- instrucción 3788
	"000000000000000000000000001011111",	-- instrucción 3789
	"000000000000000000000000001011111",	-- instrucción 3790
	"000000000000000000000000001011111",	-- instrucción 3791
	"000000000000000000000000001011111",	-- instrucción 3792
	"000000000000000000000000001011111",	-- instrucción 3793
	"000000000000000000000000001011111",	-- instrucción 3794
	"000000000000000000000000001011111",	-- instrucción 3795
	"000000000000000000000000001011111",	-- instrucción 3796
	"000000000000000000000000001011111",	-- instrucción 3797
	"000000000000000000000000001011111",	-- instrucción 3798
	"000000000000000000000000001011111",	-- instrucción 3799
	"000000000000000000000000001011111",	-- instrucción 3800
	"000000000000000000000000001011111",	-- instrucción 3801
	"000000000000000000000000001011111",	-- instrucción 3802
	"000000000000000000000000001011111",	-- instrucción 3803
	"000000000000000000000000001011111",	-- instrucción 3804
	"000000000000000000000000001011111",	-- instrucción 3805
	"000000000000000000000000001011111",	-- instrucción 3806
	"000000000000000000000000001011111",	-- instrucción 3807
	"000000000000000000000000001011111",	-- instrucción 3808
	"000000000000000000000000001011111",	-- instrucción 3809
	"000000000000000000000000001011111",	-- instrucción 3810
	"000000000000000000000000001011111",	-- instrucción 3811
	"000000000000000000000000001011111",	-- instrucción 3812
	"000000000000000000000000001011111",	-- instrucción 3813
	"000000000000000000000000001011111",	-- instrucción 3814
	"000000000000000000000000001011111",	-- instrucción 3815
	"000000000000000000000000001011111",	-- instrucción 3816
	"000000000000000000000000001011111",	-- instrucción 3817
	"000000000000000000000000001011111",	-- instrucción 3818
	"000000000000000000000000001011111",	-- instrucción 3819
	"000000000000000000000000001011111",	-- instrucción 3820
	"000000000000000000000000001011111",	-- instrucción 3821
	"000000000000000000000000001011111",	-- instrucción 3822
	"000000000000000000000000001011111",	-- instrucción 3823
	"000000000000000000000000001011111",	-- instrucción 3824
	"000000000000000000000000001011111",	-- instrucción 3825
	"000000000000000000000000001011111",	-- instrucción 3826
	"000000000000000000000000001011111",	-- instrucción 3827
	"000000000000000000000000001011111",	-- instrucción 3828
	"000000000000000000000000001011111",	-- instrucción 3829
	"000000000000000000000000001011111",	-- instrucción 3830
	"000000000000000000000000001011111",	-- instrucción 3831
	"000000000000000000000000001011111",	-- instrucción 3832
	"000000000000000000000000001011111",	-- instrucción 3833
	"000000000000000000000000001011111",	-- instrucción 3834
	"000000000000000000000000001011111",	-- instrucción 3835
	"000000000000000000000000001011111",	-- instrucción 3836
	"000000000000000000000000001011111",	-- instrucción 3837
	"000000000000000000000000001011111",	-- instrucción 3838
	"000000000000000000000000001011111",	-- instrucción 3839
	"000000000000000000000000001011111",	-- instrucción 3840
	"000000000000000000000000001011111",	-- instrucción 3841
	"000000000000000000000000001011111",	-- instrucción 3842
	"000000000000000000000000001011111",	-- instrucción 3843
	"000000000000000000000000001011111",	-- instrucción 3844
	"000000000000000000000000001011111",	-- instrucción 3845
	"000000000000000000000000001011111",	-- instrucción 3846
	"000000000000000000000000001011111",	-- instrucción 3847
	"000000000000000000000000001011111",	-- instrucción 3848
	"000000000000000000000000001011111",	-- instrucción 3849
	"000000000000000000000000001011111",	-- instrucción 3850
	"000000000000000000000000001011111",	-- instrucción 3851
	"000000000000000000000000001011111",	-- instrucción 3852
	"000000000000000000000000001011111",	-- instrucción 3853
	"000000000000000000000000001011111",	-- instrucción 3854
	"000000000000000000000000001011111",	-- instrucción 3855
	"000000000000000000000000001011111",	-- instrucción 3856
	"000000000000000000000000001011111",	-- instrucción 3857
	"000000000000000000000000001011111",	-- instrucción 3858
	"000000000000000000000000001011111",	-- instrucción 3859
	"000000000000000000000000001011111",	-- instrucción 3860
	"000000000000000000000000001011111",	-- instrucción 3861
	"000000000000000000000000001011111",	-- instrucción 3862
	"000000000000000000000000001011111",	-- instrucción 3863
	"000000000000000000000000001011111",	-- instrucción 3864
	"000000000000000000000000001011111",	-- instrucción 3865
	"000000000000000000000000001011111",	-- instrucción 3866
	"000000000000000000000000001011111",	-- instrucción 3867
	"000000000000000000000000001011111",	-- instrucción 3868
	"000000000000000000000000001011111",	-- instrucción 3869
	"000000000000000000000000001011111",	-- instrucción 3870
	"000000000000000000000000001011111",	-- instrucción 3871
	"000000000000000000000000001011111",	-- instrucción 3872
	"000000000000000000000000001011111",	-- instrucción 3873
	"000000000000000000000000001011111",	-- instrucción 3874
	"000000000000000000000000001011111",	-- instrucción 3875
	"000000000000000000000000001011111",	-- instrucción 3876
	"000000000000000000000000001011111",	-- instrucción 3877
	"000000000000000000000000001011111",	-- instrucción 3878
	"000000000000000000000000001011111",	-- instrucción 3879
	"000000000000000000000000001011111",	-- instrucción 3880
	"000000000000000000000000001011111",	-- instrucción 3881
	"000000000000000000000000001011111",	-- instrucción 3882
	"000000000000000000000000001011111",	-- instrucción 3883
	"000000000000000000000000001011111",	-- instrucción 3884
	"000000000000000000000000001011111",	-- instrucción 3885
	"000000000000000000000000001011111",	-- instrucción 3886
	"000000000000000000000000001011111",	-- instrucción 3887
	"000000000000000000000000001011111",	-- instrucción 3888
	"000000000000000000000000001011111",	-- instrucción 3889
	"000000000000000000000000001011111",	-- instrucción 3890
	"000000000000000000000000001011111",	-- instrucción 3891
	"000000000000000000000000001011111",	-- instrucción 3892
	"000000000000000000000000001011111",	-- instrucción 3893
	"000000000000000000000000001011111",	-- instrucción 3894
	"000000000000000000000000001011111",	-- instrucción 3895
	"000000000000000000000000001011111",	-- instrucción 3896
	"000000000000000000000000001011111",	-- instrucción 3897
	"000000000000000000000000001011111",	-- instrucción 3898
	"000000000000000000000000001011111",	-- instrucción 3899
	"000000000000000000000000001011111",	-- instrucción 3900
	"000000000000000000000000001011111",	-- instrucción 3901
	"000000000000000000000000001011111",	-- instrucción 3902
	"000000000000000000000000001011111",	-- instrucción 3903
	"000000000000000000000000001011111",	-- instrucción 3904
	"000000000000000000000000001011111",	-- instrucción 3905
	"000000000000000000000000001011111",	-- instrucción 3906
	"000000000000000000000000001011111",	-- instrucción 3907
	"000000000000000000000000001011111",	-- instrucción 3908
	"000000000000000000000000001011111",	-- instrucción 3909
	"000000000000000000000000001011111",	-- instrucción 3910
	"000000000000000000000000001011111",	-- instrucción 3911
	"000000000000000000000000001011111",	-- instrucción 3912
	"000000000000000000000000001011111",	-- instrucción 3913
	"000000000000000000000000001011111",	-- instrucción 3914
	"000000000000000000000000001011111",	-- instrucción 3915
	"000000000000000000000000001011111",	-- instrucción 3916
	"000000000000000000000000001011111",	-- instrucción 3917
	"000000000000000000000000001011111",	-- instrucción 3918
	"000000000000000000000000001011111",	-- instrucción 3919
	"000000000000000000000000001011111",	-- instrucción 3920
	"000000000000000000000000001011111",	-- instrucción 3921
	"000000000000000000000000001011111",	-- instrucción 3922
	"000000000000000000000000001011111",	-- instrucción 3923
	"000000000000000000000000001011111",	-- instrucción 3924
	"000000000000000000000000001011111",	-- instrucción 3925
	"000000000000000000000000001011111",	-- instrucción 3926
	"000000000000000000000000001011111",	-- instrucción 3927
	"000000000000000000000000001011111",	-- instrucción 3928
	"000000000000000000000000001011111",	-- instrucción 3929
	"000000000000000000000000001011111",	-- instrucción 3930
	"000000000000000000000000001011111",	-- instrucción 3931
	"000000000000000000000000001011111",	-- instrucción 3932
	"000000000000000000000000001011111",	-- instrucción 3933
	"000000000000000000000000001011111",	-- instrucción 3934
	"000000000000000000000000001011111",	-- instrucción 3935
	"000000000000000000000000001011111",	-- instrucción 3936
	"000000000000000000000000001011111",	-- instrucción 3937
	"000000000000000000000000001011111",	-- instrucción 3938
	"000000000000000000000000001011111",	-- instrucción 3939
	"000000000000000000000000001011111",	-- instrucción 3940
	"000000000000000000000000001011111",	-- instrucción 3941
	"000000000000000000000000001011111",	-- instrucción 3942
	"000000000000000000000000001011111",	-- instrucción 3943
	"000000000000000000000000001011111",	-- instrucción 3944
	"000000000000000000000000001011111",	-- instrucción 3945
	"000000000000000000000000001011111",	-- instrucción 3946
	"000000000000000000000000001011111",	-- instrucción 3947
	"000000000000000000000000001011111",	-- instrucción 3948
	"000000000000000000000000001011111",	-- instrucción 3949
	"000000000000000000000000001011111",	-- instrucción 3950
	"000000000000000000000000001011111",	-- instrucción 3951
	"000000000000000000000000001011111",	-- instrucción 3952
	"000000000000000000000000001011111",	-- instrucción 3953
	"000000000000000000000000001011111",	-- instrucción 3954
	"000000000000000000000000001011111",	-- instrucción 3955
	"000000000000000000000000001011111",	-- instrucción 3956
	"000000000000000000000000001011111",	-- instrucción 3957
	"000000000000000000000000001011111",	-- instrucción 3958
	"000000000000000000000000001011111",	-- instrucción 3959
	"000000000000000000000000001011111",	-- instrucción 3960
	"000000000000000000000000001011111",	-- instrucción 3961
	"000000000000000000000000001011111",	-- instrucción 3962
	"000000000000000000000000001011111",	-- instrucción 3963
	"000000000000000000000000001011111",	-- instrucción 3964
	"000000000000000000000000001011111",	-- instrucción 3965
	"000000000000000000000000001011111",	-- instrucción 3966
	"000000000000000000000000001011111",	-- instrucción 3967
	"000000000000000000000000001011111",	-- instrucción 3968
	"000000000000000000000000001011111",	-- instrucción 3969
	"000000000000000000000000001011111",	-- instrucción 3970
	"000000000000000000000000001011111",	-- instrucción 3971
	"000000000000000000000000001011111",	-- instrucción 3972
	"000000000000000000000000001011111",	-- instrucción 3973
	"000000000000000000000000001011111",	-- instrucción 3974
	"000000000000000000000000001011111",	-- instrucción 3975
	"000000000000000000000000001011111",	-- instrucción 3976
	"000000000000000000000000001011111",	-- instrucción 3977
	"000000000000000000000000001011111",	-- instrucción 3978
	"000000000000000000000000001011111",	-- instrucción 3979
	"000000000000000000000000001011111",	-- instrucción 3980
	"000000000000000000000000001011111",	-- instrucción 3981
	"000000000000000000000000001011111",	-- instrucción 3982
	"000000000000000000000000001011111",	-- instrucción 3983
	"000000000000000000000000001011111",	-- instrucción 3984
	"000000000000000000000000001011111",	-- instrucción 3985
	"000000000000000000000000001011111",	-- instrucción 3986
	"000000000000000000000000001011111",	-- instrucción 3987
	"000000000000000000000000001011111",	-- instrucción 3988
	"000000000000000000000000001011111",	-- instrucción 3989
	"000000000000000000000000001011111",	-- instrucción 3990
	"000000000000000000000000001011111",	-- instrucción 3991
	"000000000000000000000000001011111",	-- instrucción 3992
	"000000000000000000000000001011111",	-- instrucción 3993
	"000000000000000000000000001011111",	-- instrucción 3994
	"000000000000000000000000001011111",	-- instrucción 3995
	"000000000000000000000000001011111",	-- instrucción 3996
	"000000000000000000000000001011111",	-- instrucción 3997
	"000000000000000000000000001011111",	-- instrucción 3998
	"000000000000000000000000001011111",	-- instrucción 3999
	"000000000000000000000000001011111",	-- instrucción 4000
	"000000000000000000000000001011111",	-- instrucción 4001
	"000000000000000000000000001011111",	-- instrucción 4002
	"000000000000000000000000001011111",	-- instrucción 4003
	"000000000000000000000000001011111",	-- instrucción 4004
	"000000000000000000000000001011111",	-- instrucción 4005
	"000000000000000000000000001011111",	-- instrucción 4006
	"000000000000000000000000001011111",	-- instrucción 4007
	"000000000000000000000000001011111",	-- instrucción 4008
	"000000000000000000000000001011111",	-- instrucción 4009
	"000000000000000000000000001011111",	-- instrucción 4010
	"000000000000000000000000001011111",	-- instrucción 4011
	"000000000000000000000000001011111",	-- instrucción 4012
	"000000000000000000000000001011111",	-- instrucción 4013
	"000000000000000000000000001011111",	-- instrucción 4014
	"000000000000000000000000001011111",	-- instrucción 4015
	"000000000000000000000000001011111",	-- instrucción 4016
	"000000000000000000000000001011111",	-- instrucción 4017
	"000000000000000000000000001011111",	-- instrucción 4018
	"000000000000000000000000001011111",	-- instrucción 4019
	"000000000000000000000000001011111",	-- instrucción 4020
	"000000000000000000000000001011111",	-- instrucción 4021
	"000000000000000000000000001011111",	-- instrucción 4022
	"000000000000000000000000001011111",	-- instrucción 4023
	"000000000000000000000000001011111",	-- instrucción 4024
	"000000000000000000000000001011111",	-- instrucción 4025
	"000000000000000000000000001011111",	-- instrucción 4026
	"000000000000000000000000001011111",	-- instrucción 4027
	"000000000000000000000000001011111",	-- instrucción 4028
	"000000000000000000000000001011111",	-- instrucción 4029
	"000000000000000000000000001011111",	-- instrucción 4030
	"000000000000000000000000001011111",	-- instrucción 4031
	"000000000000000000000000001011111",	-- instrucción 4032
	"000000000000000000000000001011111",	-- instrucción 4033
	"000000000000000000000000001011111",	-- instrucción 4034
	"000000000000000000000000001011111",	-- instrucción 4035
	"000000000000000000000000001011111",	-- instrucción 4036
	"000000000000000000000000001011111",	-- instrucción 4037
	"000000000000000000000000001011111",	-- instrucción 4038
	"000000000000000000000000001011111",	-- instrucción 4039
	"000000000000000000000000001011111",	-- instrucción 4040
	"000000000000000000000000001011111",	-- instrucción 4041
	"000000000000000000000000001011111",	-- instrucción 4042
	"000000000000000000000000001011111",	-- instrucción 4043
	"000000000000000000000000001011111",	-- instrucción 4044
	"000000000000000000000000001011111",	-- instrucción 4045
	"000000000000000000000000001011111",	-- instrucción 4046
	"000000000000000000000000001011111",	-- instrucción 4047
	"000000000000000000000000001011111",	-- instrucción 4048
	"000000000000000000000000001011111",	-- instrucción 4049
	"000000000000000000000000001011111",	-- instrucción 4050
	"000000000000000000000000001011111",	-- instrucción 4051
	"000000000000000000000000001011111",	-- instrucción 4052
	"000000000000000000000000001011111",	-- instrucción 4053
	"000000000000000000000000001011111",	-- instrucción 4054
	"000000000000000000000000001011111",	-- instrucción 4055
	"000000000000000000000000001011111",	-- instrucción 4056
	"000000000000000000000000001011111",	-- instrucción 4057
	"000000000000000000000000001011111",	-- instrucción 4058
	"000000000000000000000000001011111",	-- instrucción 4059
	"000000000000000000000000001011111",	-- instrucción 4060
	"000000000000000000000000001011111",	-- instrucción 4061
	"000000000000000000000000001011111",	-- instrucción 4062
	"000000000000000000000000001011111",	-- instrucción 4063
	"000000000000000000000000001011111",	-- instrucción 4064
	"000000000000000000000000001011111",	-- instrucción 4065
	"000000000000000000000000001011111",	-- instrucción 4066
	"000000000000000000000000001011111",	-- instrucción 4067
	"000000000000000000000000001011111",	-- instrucción 4068
	"000000000000000000000000001011111",	-- instrucción 4069
	"000000000000000000000000001011111",	-- instrucción 4070
	"000000000000000000000000001011111",	-- instrucción 4071
	"000000000000000000000000001011111",	-- instrucción 4072
	"000000000000000000000000001011111",	-- instrucción 4073
	"000000000000000000000000001011111",	-- instrucción 4074
	"000000000000000000000000001011111",	-- instrucción 4075
	"000000000000000000000000001011111",	-- instrucción 4076
	"000000000000000000000000001011111",	-- instrucción 4077
	"000000000000000000000000001011111",	-- instrucción 4078
	"000000000000000000000000001011111",	-- instrucción 4079
	"000000000000000000000000001011111",	-- instrucción 4080
	"000000000000000000000000001011111",	-- instrucción 4081
	"000000000000000000000000001011111",	-- instrucción 4082
	"000000000000000000000000001011111",	-- instrucción 4083
	"000000000000000000000000001011111",	-- instrucción 4084
	"000000000000000000000000001011111",	-- instrucción 4085
	"000000000000000000000000001011111",	-- instrucción 4086
	"000000000000000000000000001011111",	-- instrucción 4087
	"000000000000000000000000001011111",	-- instrucción 4088
	"000000000000000000000000001011111",	-- instrucción 4089
	"000000000000000000000000001011111",	-- instrucción 4090
	"000000000000000000000000001011111",	-- instrucción 4091
	"000000000000000000000000001011111",	-- instrucción 4092
	"000000000000000000000000001011111",	-- instrucción 4093
	"000000000000000000000000001011111",	-- instrucción 4094
	"000000000000000000000000001011111",	-- instrucción 4095
	"000000000000000000000000001011111"	-- instrucción 4096
);
begin

dataout <= memory(to_integer(unsigned(address)));

end Behavioral;