using Assembler.Parser;
using Assembler.Util;
using System;
using System.IO;


namespace Assembler
{
    class Program
    {
        static void Main(string[] args)
        {
            AssemblyInterpreter interpreter = new AssemblyInterpreter();
            if (args.Length == 0)
            {
                Console.WriteLine("Debes arrastrar un archivo al .exe");
                Console.ReadKey();
                return;
            }
            string text = File.ReadAllText(args[0]);
            //string text = File.ReadAllText("./Ejemplo14.txt");
            interpreter.Interpret(text);
            string output = DocumentBuilder.GenerateFinalDocument(interpreter.Instructions);
            File.WriteAllText(@"./output.txt", output);
        }
    }
}
