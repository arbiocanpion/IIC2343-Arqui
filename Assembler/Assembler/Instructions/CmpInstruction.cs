﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assembler
{
    class CmpInstruction : Instruction
    {

        private Dictionary<Tuple<ParameterType, ParameterType>, String> opcodes =
                 new Dictionary<Tuple<ParameterType, ParameterType>, string>() {
             { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.B), "1001010"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.Lit), "1001011"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.Dir), "1001100"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.DirB), "1001101"}
        };

        public CmpInstruction(String param1, String param2) : base(param1, param2){ }


        public override void addOpcode()
        {
            base.addOpcode();
            Tuple<ParameterType, ParameterType> tuple =
                new Tuple<ParameterType, ParameterType>(_param1.GetType(), _param2.GetType());
            _instruction += (opcodes[tuple]);
        }
    }
}
