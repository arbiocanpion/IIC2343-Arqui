using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assembler
{
    class AddInstruction : Instruction
    {

        private Dictionary<Tuple<ParameterType, ParameterType>, String> opcodes =
                 new Dictionary<Tuple<ParameterType, ParameterType>, string>() {
             { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.B), "0001100"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.B , ParameterType.A), "0001101"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.Lit), "0001110"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.B , ParameterType.Lit), "0001111"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.Dir), "0010000"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.B , ParameterType.Dir), "0010001"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.Dir , ParameterType.None), "0010010"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.DirB), "0010011"},
             { new Tuple<ParameterType, ParameterType>(ParameterType.B , ParameterType.DirB), "0010100"}
        };

        public AddInstruction(String param1, String param2) : base(param1, param2){ }

        public override void addOpcode()
        {
            base.addOpcode();
            Tuple<ParameterType, ParameterType> tuple =
                new Tuple<ParameterType, ParameterType>(_param1.GetType(), _param2.GetType());
            _instruction += (opcodes[tuple]);
        }
    }
}
