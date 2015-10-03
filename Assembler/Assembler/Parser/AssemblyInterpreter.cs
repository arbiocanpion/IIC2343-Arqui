using Assembler.Instructions;
using Assembler.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assembler.Parser
{
    public class AssemblyInterpreter
    {
        LabelManager labelManager;
        VariableManager variableManager;
        AssemblyCode assemblyCode;
        List<Instruction> instructions;
        int instructionCounter;
        int memoryCounter;

        public string Interpret(string code)
        {
            code = code.Replace("\r\n", "\n");
            assemblyCode = new AssemblyCode(code);
            labelManager = new LabelManager();
            variableManager = new VariableManager();

            instructions = new List<Instruction>();
            GetVariables();
            GetLabels();
            ProcessCode();
            return null;
        }

        private void ProcessCode()
        {
            instructionCounter = instructions.Count;
            string[] codeLines = assemblyCode.GetCodeLines();
            for (int i = 0; i < codeLines.Length; i++)
            {
                if (!labelManager.IsLabelDeclaration(codeLines[i]) 
                    && !LineFormatter.ReservedWord(codeLines[i])
                    && !LineFormatter.IsCommentLine(codeLines[i]))
                {
                    string line = LineFormatter.FormatCodeLine(codeLines[i]);
                    Instruction instruction = InstructionFactory
                        .createInstruction(line, labelManager.labels, variableManager.variables);
                    instructions.Add(instruction);
                    instructionCounter++;
                }
            }
        }

        private void GetLabels()
        {
            string[] codeLines = assemblyCode.GetCodeLines();
            for (int i = 0; i < codeLines.Length; i++)
            {
                string line = LineFormatter.DeleteComments(codeLines[i]);
                if (labelManager.IsLabelDeclaration(line) && !LineFormatter.IsCommentLine(line))
                {
                    labelManager.addLabel(line, instructionCounter);
                }
                else
                {
                    instructionCounter++;
                }
            }
        }

        private void GetVariables()
        {
            string[] dataLines = assemblyCode.GetDataLines();

            for (int i = 0; i < dataLines.Length; i++)
            {
                string line = LineFormatter.DeleteComments(dataLines[i]);
                if (VariableManager.IsVariable(line))
                {
                    string[] pair = line.Split(' ');
                    variableManager.AddVariable(pair[0], memoryCounter.ToString());
                    AddInitVariableInstruction(pair[1]);
                }
            }
        }

        private void AddInitVariableInstruction(string val)
        {
            Instruction mov1 = InstructionFactory.createInstruction(
                "MOV A "+val, labelManager.labels, variableManager.variables);
            Instruction mov2 = InstructionFactory.createInstruction(
                "MOV ("+ memoryCounter + ") A", labelManager.labels, variableManager.variables);
            instructions.Add(mov1);
            instructionCounter++;
            instructions.Add(mov2);
            instructionCounter++;
            memoryCounter++;
        }

        public void PrintInstructions()
        {
            for (int i = 0; i < instructions.Count; i++)
            {
                Console.WriteLine(instructions[i].ToString());
            }
        }

        public string[] GetInstructions()
        {
            string[] stringInstructions = new string[instructions.Count];
            for (int i = 0; i < instructions.Count; i++)
            {
                stringInstructions[i] = instructions[i].ToString();
            }
            return stringInstructions;
        }
    }
}
