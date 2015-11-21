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
            else if (line.Substring(0, 2).Equals("IN") && !line.Substring(0, 3).Equals("INC"))
            {
                line = line.Insert(2, " ");
            }
            else if (line.Length > 3 && (line.Substring(0, 4).Equals("CALL") || line.Substring(0, 4).Equals("PUSH") ||
                line.Substring(0, 4).Equals("POP2") || line.Substring(0, 4).Equals("RET2")))
            {
                line = line.Insert(4, " ");
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
            line = line.Trim();
            return line;
        }

        public static string DeleteComments(string line)
        {
            line = Regex.Replace(line, " (?=[^(]*\\))", "");
            if (line.Replace(" ", "").Equals("")) return line;
            int endIndex = line.IndexOf("//");
            if (endIndex == 0) return "";
            if (endIndex < 0) return line.Trim();
            return line.Substring(0, endIndex).Trim();
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

        public static bool IsString(string line)
        {
            if (line == null || line.Equals(""))
                return false;
            string[] parts = line.Split(new char[] { ' ' }, 2);
            if (parts.Length < 2)
                return false;
            string begin = parts[1].Substring(0, 1);
            string end = parts[1].Substring(parts[1].Length - 1, 1);
            if (begin.Equals("\"") && end.Equals("\"")) {
                return true;
            }
            return false;
        }

        public static string GetCharacterArray(string line)
        {
            string[] parts = line.Split(new char[] { ' ' }, 2);
            string value = parts[1].TrimStart('"').TrimEnd('"');
            char[] charArray = value.ToCharArray();
            StringBuilder builder = new StringBuilder();
            builder.Append(parts[0]).Append(" ");
            foreach (char character in charArray)
            {
                builder.Append("'").Append(character).Append("'").Append("\n");
            }
            return builder.ToString();
        }
    }

}
