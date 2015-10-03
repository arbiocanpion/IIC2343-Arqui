﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assembler
{
    class OrInstruction : Instruction
    {
        private Dictionary<Tuple<ParameterType, ParameterType>, String> opcodes =
            new Dictionary<Tuple<ParameterType, ParameterType>, string>() {
                { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.B),     "0100000"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.B , ParameterType.A),     "0100001"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.Lit),   "0100010"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.B , ParameterType.Lit),   "0100011"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.Dir),   "0100100"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.B , ParameterType.Dir),   "0100101"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.Dir, ParameterType.None), "0100110"}
            };

        public OrInstruction(String param1, String param2) : base(param1, param2){ }


        public override void addOpcode()
        {
            base.addOpcode();
            Tuple<ParameterType, ParameterType> tuple =
                new Tuple<ParameterType, ParameterType>(_param1.GetType(), _param2.GetType());
            _instruction += (opcodes[tuple]);
        }

    }
}
