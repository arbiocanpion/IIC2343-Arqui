using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assembler.Parser
{
    class LabelManager
    {

        public Dictionary<string, int> labels
        {
            get; set;
        }

        public LabelManager()
        {
            labels = new Dictionary<string, int>();
        }

        public void addLabel(string lineContent, int romInstructionNumber)
        {
            lineContent = lineContent.Replace(":", "");
            labels.Add(lineContent, romInstructionNumber);
        }

        public bool IsLabelDeclaration(string line)
        {
            if (line.IndexOf(":") > 0 && !line.Equals("CODE:")) return true;
            return false;
        }
        public bool IsDeclaredLabel(string line)
        {
            if (line.IndexOf(":") > 0 && !line.Equals("CODE:") && labels.ContainsKey(line.Substring(0, line.Length-1)))
                return true;
            return false;
        }

    }
}
