﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assembler
{
    class SubInstruction: Instruction
    {
        private Dictionary<Tuple<ParameterType, ParameterType>, String> opcodes =
                 new Dictionary<Tuple<ParameterType, ParameterType>, string>() {
             { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.B), "0010101"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.B , ParameterType.A), "0010110"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.Lit), "0010111"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.B , ParameterType.Lit), "0011000"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.Dir), "0011001"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.B , ParameterType.Dir), "0011010"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.Dir , ParameterType.None), "0011011"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.DirB), "0011100"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.B , ParameterType.DirB), "0011101"}
        };


        public SubInstruction(String param1, String param2) : base(param1, param2){ }


        public override void addOpcode()
        {
            base.addOpcode();
            Tuple<ParameterType, ParameterType> tuple =
                new Tuple<ParameterType, ParameterType>(_param1.GetType(), _param2.GetType());
            _instruction += (opcodes[tuple]);
        }
    }
}
