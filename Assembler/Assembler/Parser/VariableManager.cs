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
            int count = 0;
            if (!LineFormatter.ReservedWord(line))
            {
                return true;
            }
            foreach (string b in line.Split(' '))
            {
                if (!b.Equals("") || !b.Equals(" "))
                {
                    count++;
                }
            }
            if (count == 2)
                return true;
            return false;
        }
        public void AddVariable(string name, string value) 
        {
            variablesValues.Add(name, value);
        }
    }
}
