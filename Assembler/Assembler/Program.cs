using Assembler.Parser;
using System.IO;


namespace Assembler
{
    class Program
    {
        static void Main(string[] args)
        {
            AssemblyInterpreter interpreter = new AssemblyInterpreter();
            string text = File.ReadAllText(args[0]);
            //string text = File.ReadAllText("./Ejemplo6.txt");
            interpreter.Interpret(text);
            string output = DocumentBuilder.GenerateFinalDocument(interpreter.GetInstructions());
            File.WriteAllText(@"./output.txt", output);
        }
    }
}
