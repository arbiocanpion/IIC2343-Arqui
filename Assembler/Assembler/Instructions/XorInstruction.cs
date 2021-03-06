﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assembler
{
    class XorInstruction : Instruction
    {
        private Dictionary<Tuple<ParameterType, ParameterType>, String> opcodes =
                 new Dictionary<Tuple<ParameterType, ParameterType>, string>() {
             { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.B), "0110000"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.B , ParameterType.A), "0110001"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.Lit), "0110010"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.B , ParameterType.Lit), "0110011"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.Dir), "0110100"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.B , ParameterType.Dir), "0110101"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.Dir , ParameterType.None), "0110110"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.DirB), "0110111"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.B , ParameterType.DirB), "0111000"}
        };

        public XorInstruction(String param1, String param2) : base(param1, param2){ }


        public override void addOpcode()
        {
            base.addOpcode();
            Tuple<ParameterType, ParameterType> tuple =
                new Tuple<ParameterType, ParameterType>(_param1.GetType(), _param2.GetType());
            _instruction += (opcodes[tuple]);
        }

    }
}
