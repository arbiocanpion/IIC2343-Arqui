using Assembler.Parser;
using Assembler.Util;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assembler
{
    class Program
    {
        static void Main(string[] args)
        {
            AssemblyInterpreter interpreter = new AssemblyInterpreter();
            //string text = File.ReadAllText(args[0]);
            string text = File.ReadAllText("./Ejemplo1.txt");
            interpreter.Interpret(text);
            string output = DocumentBuilder.GenerateFinalDocument(interpreter.GetInstructions());
            File.WriteAllText(@"./output.txt", output);
        }
    }
}
