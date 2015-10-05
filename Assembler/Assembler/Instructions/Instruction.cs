﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assembler
{
    enum ParameterType
    {
        A,
        B,
        Dir,
        DirA,
        DirB,
        Lit,
        Var,
        None
    }

    class Instruction
    {
        protected String _tenZeros = "0000000000";
        protected String _sixteenZeros = "0000000000000000";
        protected Parameter _param1;
        protected Parameter _param2;
        protected String _instruction;

        public Instruction(String param1, String param2)
        {
            _param1 = new Parameter(param1);
            _param2 = new Parameter(param2);
            BuildInstruction();
        }

        private void BuildInstruction()
        {
            _instruction = "";

            if (hasLiteral())
            {
                addLiteral();
            }
            else if (hasDirection())
            {
                addDirection();
            }
            else
            {
                _instruction += _sixteenZeros;
            }

            _instruction += _tenZeros;
            addOpcode();
        }

        private void addDirection()
        {
            if (_param2.GetType() == ParameterType.Dir)
            {
                _instruction += "0000" + _param2.GetBitValue().Substring(4);
            }
            else if (_param1.GetType() == ParameterType.Dir)
            {
                _instruction += "0000" + _param1.GetBitValue().Substring(4);
            }
        }

        private void addLiteral()
        {
            if (_param1.GetType() == ParameterType.Lit)
            {
                _instruction += _param1.GetBitValue();
            }
            else
            {
                _instruction += _param2.GetBitValue();
            }
        }

        public virtual void addOpcode() { }

        private bool hasLiteral()
        {
            return _param2.GetType() == ParameterType.Lit || _param1.GetType() == ParameterType.Lit;
        }

        private bool hasDirection()
        {
            return _param2.GetType() == ParameterType.Dir || _param1.GetType() == ParameterType.Dir;
        }


        public override string ToString()
        {
            return _instruction;
        }
    }
}