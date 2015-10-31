using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assembler
{
    class DocumentBuilder
    {

        public static string documentBegin = 
            @"library IEEE;
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
";

        public static string documentEnd = @");
begin

dataout <= memory(to_integer(unsigned(address)));

end Behavioral;";

        public static string emptyMessage = "000000000000000000000000001000110";

        public static string GenerateFinalDocument(string[] instructions)
        {
            StringBuilder builder = new StringBuilder();
            builder.Append(documentBegin);
            int i = 1;
            for (i = 0; i < instructions.Length; i++)
            {
                builder.Append('\t');
                builder.Append('"');
                builder.Append(instructions[i]);
                builder.Append('"');
                builder.Append(',');
                builder.Append('\t');
                builder.Append("-- instrucción ");
                builder.Append(i + 1);
                builder.Append("\r\n");
            }
            for (; i < 4095; i++)
            {
                builder.Append('\t');
                builder.Append('"');
                builder.Append(emptyMessage);
                builder.Append('"');
                builder.Append(',');
                builder.Append('\t');
                builder.Append("-- instrucción ");
                builder.Append(i + 1);
                builder.Append("\r\n");
            }
            builder.Append('\t');
            builder.Append('"');
            builder.Append(emptyMessage);
            builder.Append('"');
            builder.Append('\t');
            builder.Append("-- instrucción ");
            builder.Append(i + 1);
            builder.Append("\r\n");
            builder.Append(documentEnd);
            return builder.ToString();
        }

        public static void generateOpcodes(string[] instructions)
        {
            int count = 0;
            for (int k = 0; k < instructions.Length; k++)
            {
                if (instructions[k].Equals(""))
                    continue;
                if (instructions[k][0].Equals('-'))
                {
                    Console.WriteLine(instructions[k].Substring(1, instructions[k].Length - 1));
                    continue;
                }
                int x = count;
                string val = "";
                char[] bits = new char[7];
                int i = 0;
                for (int j = 0; j < 7; j++)
                {
                    if (x != 0)
                    {
                        bits[i++] = (x & 1) == 1 ? '1' : '0';
                        x >>= 1;
                    }
                    else
                    {
                        bits[i++] = '0';
                    }
                }
                Array.Reverse(bits, 0, i);
                val = instructions[k] + val + new string(bits) + '\n';
                Console.WriteLine(val);
                count++;
            }
        }

        public static void generateInstructions(string[] instructions)
        {
            int count = 0;
            for (int k = 0; k < instructions.Length; k++)
            {
                if (instructions[k].Equals(""))
                    continue;
                if (instructions[k][0].Equals('-'))
                {
                    Console.WriteLine(instructions[k].Substring(1, instructions[k].Length - 1));
                    continue;
                }
                int x = count;
                string val = "";
                char[] bits = new char[7];
                int i = 0;
                for (int j = 0; j < 7; j++)
                {
                    if (x != 0)
                    {
                        bits[i++] = (x & 1) == 1 ? '1' : '0';
                        x >>= 1;
                    }
                    else
                    {
                        bits[i++] = '0';
                    }
                }
                Array.Reverse(bits, 0, i);
                val = instructions[k] + " " + val + new string(bits) + '\n';
                Console.WriteLine(val);
                count++;
            }
        }
    }
}
