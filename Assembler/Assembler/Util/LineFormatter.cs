using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Assembler.Util
{
    class LineFormatter
    {
        public static string FormatCodeLine(string line)
        {
            line = DeleteComments(line);

            if (line.Replace(" ", "").Equals("")) return line;
            line = line.Replace(" ", "");
            line = line.Replace(",", " ");
            if (line.Substring(0, 2).Equals("OR"))
            {
                line = line.Insert(2, " ");
            }
            else
            {
                line = line.Insert(3, " ");
            }
            return line;
        }

        public static string FormatDataLine(string line)
        {
            line = DeleteComments(line);

            line = Regex.Replace(line, " (?=[^(]*\\))", "");

            int endIndex = line.Length;
            while (line[endIndex - 1].Equals(' '))
            {
                endIndex--;
            }
            int startIndex = 0;
            while (line[startIndex].Equals(' '))
            {
                startIndex++;
            }
            return line.Substring(startIndex, endIndex-startIndex);
        }

        public static string DeleteComments(string line)
        {
            line = Regex.Replace(line, " (?=[^(]*\\))", "");
            if (line.Replace(" ", "").Equals("")) return line;
            int startIndex = 0;
            while (line[startIndex].Equals(' '))
            {
                startIndex++;
            }
            int endIndex = line.IndexOf("//");
            if (endIndex == 0) return "";
            if (endIndex < 0)
            {
                endIndex = line.Length;
            }
            while (line[endIndex-1].Equals(' '))
            {
                endIndex--;
            }
            return line.Substring(startIndex, endIndex-startIndex);
        }

        public static bool ReservedWord(string line)
        {
            if (line.Length >= 5)
            {
                return line.Substring(0,5).Equals("CODE:") || line.Substring(0,5).Equals("DATA:");
            }
            return false;
        }

        public static bool IsStartCode(string line)
        {
            if (line.Length >= 5)
            {
                return line.Substring(0, 5).Equals("CODE:");
            }
            return false;
        }

        public static bool IsStartData(string line)
        {
            if (line.Length >= 5)
            {
                return line.Substring(0, 5).Equals("DATA:");
            }
            return false;
        }

        public static bool IsCommentLine(string line)
        {
            if (DeleteComments(line).Equals(""))
            {
                return true;
            }
            return false;
        }


        public static string DeleteSpaces(string line)
        {
            return line.Replace(" ", "");
        }
    }
}
