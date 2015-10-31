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
        private List<Instruction> instructions;
        public List<Instruction> Instructions
        {
            get { return instructions; }
        }
        int instructionCounter;
        int memoryCounter;

        public string Interpret(string code)
        {
            code = code.Replace("\r\n", "\n");
            code = code.Replace("\t", " ");
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
                        .createInstruction(line, labelManager.labels, variableManager.variablesValues);
                    instructions.Add(instruction);
                    instructionCounter++;
                    if (instruction.GetType() == typeof(Pop1Instruction))
                    {
                        instructions.Add(
                            InstructionFactory.createInstruction(
                                "2"+line, labelManager.labels, variableManager.variablesValues));
                        instructionCounter++;
                    }
                    else if (instruction.GetType() == typeof(Ret1Instruction))
                    {
                        instructions.Add(
                            InstructionFactory.createInstruction(
                                "2"+line, labelManager.labels, variableManager.variablesValues));
                        instructionCounter++;
                    }
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
                else if (!LineFormatter.ReservedWord(line))
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
                string line = LineFormatter.FormatDataLine(dataLines[i]);
                if (VariableManager.IsVariable(line))
                {
                    // TODO: cambiar esto, ahora las lineas de variables pueden tener solo uno de largo.
                    string[] pair = line.Split(' ');
                    string value;
                    if (pair.Length == 1)
                    {
                        value = pair[0];
                    }
                    else
                    {
                        variableManager.AddVariable(pair[0], memoryCounter.ToString());
                        value = pair[1];
                    }
                    AddInitVariableInstruction(value);
                }
            }
        }

        private void AddInitVariableInstruction(string val)
        {
            Instruction mov1 = InstructionFactory.createInstruction(
                "MOV A "+val, labelManager.labels, variableManager.variablesValues);
            Instruction mov2 = InstructionFactory.createInstruction(
                "MOV ("+ memoryCounter + ") A", labelManager.labels, variableManager.variablesValues);
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
    }
}
