using Assembler.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assembler.Parser
{
    class AssemblyCode
    {
        private string[] lines;
        int dataStart;
        int codeStart;

        public AssemblyCode(string assemblyCode)
        {
            StringBuilder builder = new StringBuilder();
            assemblyCode.Replace("\t", "");
            string[] lines = assemblyCode.Split('\n');
            dataStart = 0;
            codeStart = 0;
            int originalLineCounter = 0;
            int reducedLineCounter = 0;
            while (originalLineCounter < lines.Length)
            {
                
                string line = LineFormatter.DeleteComments(lines[originalLineCounter]);
                if (line.Replace(" ","").Equals(""))
                {
                    originalLineCounter++;
                    continue;
                }
                if (LineFormatter.IsStartData(line))
                {
                    dataStart = reducedLineCounter;
                }
                if (LineFormatter.IsStartCode(line))
                {
                    codeStart = reducedLineCounter;
                }
                builder.Append(line);
                builder.Append('\n');
                reducedLineCounter++;
                originalLineCounter++;
            }
            this.lines = builder.ToString().Split('\n');
        }

        public string[] GetDataLines()
        {
            return lines.Take(codeStart).ToArray();
        }

        public string[] GetCodeLines()
        {
            return lines.Skip(codeStart).Take(lines.Length).ToArray();
        }
    }
}
