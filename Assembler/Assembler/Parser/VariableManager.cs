using Assembler.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assembler.Parser
{
    class VariableManager
    {
        public Dictionary<string, string> variablesValues { get; }
        

        public VariableManager()
        {
            variablesValues = new Dictionary<string, string>();
        }

        public static bool IsVariable(string line)
        {
            if (!LineFormatter.ReservedWord(line) && line.Split(' ').Length <= 2)
            {
                return true;
            }
            return false;
        }
        public void AddVariable(string name, string value) 
        {
            variablesValues.Add(name, value);
        }
    }
}
