using System;

namespace Assembler
{
    class Parameter
    {
        private ParameterType _type;
        private int _value;
        private String _bitValue;

        public Parameter(String expression)
        {
            expression = expression.Replace(" ", "");
            DetermineType(expression);
        }

        private void DetermineType(String expression)
        {
            if (isLiteral(expression))
            {
                _type = ParameterType.Lit;
                SetBitValue(expression);
            }
            else if (isA(expression))
            {
                _type = ParameterType.A;
            }
            else if (isB(expression))
            {
                _type = ParameterType.B;
            }
            else if (isDirA(expression))
            {
                _type = ParameterType.DirA;
            }
            else if (isDirB(expression))
            {
                _type = ParameterType.DirB;
            }
            else if (isDir(expression))
            {
                _type = ParameterType.Dir;
                string stringValue = expression.Substring(1, expression.Length - 2);
                SetBitValue(stringValue);
            }
            else if (isNone(expression))
            {
                _type = ParameterType.None;
            }
            else
            {
                _type = ParameterType.Var;
            }
        }

        private bool isA(String expression)
        {
            if (expression.Equals("A")) return true;
            return false;
        }

        private bool isB(String expression)
        {
            if (expression.Equals("B")) return true;
            return false;
        }

        private bool isDirA(String expression)
        {
            if (expression.Equals("(A)")) return true;
            return false;
        }

        private bool isDirB(String expression)
        {
            if (expression.Equals("(B)")) return true;
            return false;
        }

        private bool isDir(String expression)
        {
            if (expression.Length >= 3 && expression[0] == '(' && expression[expression.Length - 1] == ')')
                return true;
            return false;
        }

        private bool isLiteral(String expression)
        {
            if (IsBinary(expression))
            {
                expression = expression.Substring(0, expression.Length - 1);
                return true;
            }
            else if (IsHexa(expression))
            {
                expression = expression.Substring(0, expression.Length - 1);
                return true;
            }
            else if (IsDecimal(expression))
            {
                expression = expression.Substring(0, expression.Length - 1);
                return true;
            }
            int n;
            return int.TryParse(expression, out n);
        }

        private bool isNone(String expression)
        {
            if (expression == null || expression.Equals(""))
                return true;
            return false;
        }

        public ParameterType GetType()
        {
            return _type;
        }

        public String GetBitValue()
        {
            return _bitValue;
        }

        private void SetBitValue(string stringValue)
        {
            if (IsBinary(stringValue))
            {
                _bitValue = stringValue.Substring(0, stringValue.Length - 1); 
                if (_bitValue.Length < 16)
                {
                    while (_bitValue.Length < 16)
                    {
                        _bitValue = "0" + _bitValue;
                    }
                }
            }
            else if (IsHexa(stringValue))
            {
                _bitValue = HexaToBinary(stringValue.Substring(0, stringValue.Length - 1));
            }
            else if (IsDecimal(stringValue))
            {
                _bitValue = DecimalToBinary(stringValue.Substring(0, stringValue.Length - 1));
            }
            else
            {
                _bitValue = DecimalToBinary(stringValue);
            }
        }

        private string DecimalToBinary(string stringValue)
        { 
            int x = int.Parse(stringValue);
            char[] bits = new char[16];
            int i = 0;
            for (int j = 0; j < 16; j++)
            {
                if (x != 0)
                {
                    bits[i++] = (x & 1) == 1 ? '1' : '0';
                    x >>= 1;
                }
                else
                {
                    bits[i++] = '0';
                }
            }
            Array.Reverse(bits, 0, i);
            return new string(bits);
        }

        private string HexaToBinary(string stringValue)
        {
            string reversedBits = Convert.ToString(Convert.ToInt32(stringValue, 16), 2);
            if (reversedBits.Length < 16)
            {
                int i = reversedBits.Length;
                while (reversedBits.Length < 16)
                {
                    reversedBits = reversedBits + "0";
                }
            }
            char[] reversedBitsArray = reversedBits.ToCharArray();
            Array.Reverse(reversedBitsArray);
            return new string(reversedBitsArray);
        }

        private bool IsBinary(string value)
        {
            if (value == null || value.Equals("")) return false;
            return value[value.Length - 1].Equals('b');
        }

        private bool IsHexa(string value)
        {
            if (value == null || value.Equals("")) return false;
            return value[value.Length - 1].Equals('h');
        }
        private bool IsDecimal(string value)
        {
            if (value == null || value.Equals("")) return false;
            return value[value.Length - 1].Equals('d');
        }
    }
}
