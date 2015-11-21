using Assembler.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assembler.Instructions
{
    class InstructionFactory
    {
        public static Instruction createInstruction(string line,
            Dictionary<string, int> labels,
            Dictionary<string, string> variables)
        {
            string[] parts = line.Split(new char[] { ' ' }, 3);
            string param1 = "";
            string param2 = "";
            if (parts.Length > 1)
            {
                param1 = GetParamRepresentation(parts[1], labels, variables);
            }
            if (parts.Length > 2)
            {
                param2 = GetParamRepresentation(parts[2], labels, variables);
            }
            if (parts[0].Equals("MOV"))
            {
                return new MovInstruction(param1, param2);
            }
            else if (parts[0].Equals("ADD"))
            {
                return new AddInstruction(param1, param2);
            }
            else if (parts[0].Equals("AND"))
            {
                return new AndInstruction(param1, param2);
            }
            else if (parts[0].Equals("CMP"))
            {
                return new CmpInstruction(param1, param2);
            }
            else if (parts[0].Equals("DEC"))
            {
                if (param1.Equals("A"))
                {
                    return new DecInstruction(param1, "1");
                }
                else
                {
                    return new DecInstruction(param1, "0");
                }
            }
            else if (parts[0].Equals("INC"))
            {
                if (param1.Equals("A"))
                {
                    return new IncInstruction(param1, "1");
                }
                else
                {
                    return new IncInstruction(param1, "0");
                }
            }
            else if (parts[0].Equals("JCR"))
            {
                return new JcrInstruction(param1, param2);
            }
            else if (parts[0].Equals("JEQ"))
            {
                return new JeqInstruction(param1, param2);
            }
            else if (parts[0].Equals("JGE"))
            {
                return new JgeInstruction(param1, param2);
            }
            else if (parts[0].Equals("JGT"))
            {
                return new JgtInstruction(param1, param2);
            }
            else if (parts[0].Equals("JLT"))
            {
                return new JltInstruction(param1, param2);
            }
            else if (parts[0].Equals("JLE"))
            {
                return new JleInstruction(param1, param2);
            }
            else if (parts[0].Equals("JMP"))
            {
                return new JmpInstruction(param1, param2);
            }
            else if (parts[0].Equals("JNE"))
            {
                return new JneInstruction(param1, param2);
            }
            else if (parts[0].Equals("NOP"))
            {
                return new NopInstruction(param1, param2);
            }
            else if (parts[0].Equals("NOT"))
            {
                return new NotInstruction(param1, param2);
            }
            else if (parts[0].Equals("OR"))
            {
                return new OrInstruction(param1, param2);
            }
            else if (parts[0].Equals("IN"))
            {
                return new InInstruction(param1, param2);
            }
            else if (parts[0].Equals("SHL"))
            {
                return new ShlInstruction(param1, param2);
            }
            else if (parts[0].Equals("SHR"))
            {
                return new ShrInstruction(param1, param2);
            }
            else if (parts[0].Equals("SUB"))
            {
                return new SubInstruction(param1, param2);
            }
            else if (parts[0].Equals("XOR"))
            {
                return new XorInstruction(param1, param2);
            }
            else if (parts[0].Equals("CALL"))
            {
                return new CallInstruction(param1, param2);
            }
            else if (parts[0].Equals("RET"))
            {
                return new Ret1Instruction("1", param2);
            }
            else if (parts[0].Equals("PUSH"))
            {
                return new PushInstruction(param1, param2);
            }
            else if (parts[0].Equals("POP"))
            {
                return new Pop1Instruction("1", param2);
            }
            else if (parts[0].Equals("2POP"))
            {
                return new Pop2Instruction(param1, param2);
            }
            else if (parts[0].Equals("2RET"))
            {
                return new Ret2Instruction(param2, param2);
            }
            else if (parts[0].Equals("OUT"))
            {
                return new OutInstruction(param1, param2);
            }
            return null;
        }

        private static string GetParamRepresentation(string param,
            Dictionary<string, int> labels,
            Dictionary<string, string> variables)
        {
            if (param == null || param.Equals("")) return "";

            bool representDirection = param[0].Equals('(') && param[param.Length - 1].Equals(')');
            bool representCharacter = param[0].Equals("'".ToCharArray()[0]) && param[param.Length - 1].Equals("'".ToCharArray()[0]);

            param = param.Replace("(", "").Replace(")", "");
            param = param.Replace("'", "");

            if (representCharacter)
            {
                int character = param[0];
                param = character.ToString();
            }
            else if (labels.ContainsKey(param))
            {
                param = labels[param].ToString();
            }
            else if (variables.ContainsKey(param))
            {
                param = variables[param];
            }
            if (representDirection)
            {
                param = "(" + param + ")";
            }
            
            return param;
        }
    }
}
