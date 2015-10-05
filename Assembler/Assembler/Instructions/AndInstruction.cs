using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assembler
{
    class AndInstruction: Instruction
    {

        private Dictionary<Tuple<ParameterType, ParameterType>, String> opcodes =
            new Dictionary<Tuple<ParameterType, ParameterType>, string>() {
                { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.B),     "0011001"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.B , ParameterType.A),     "0011010"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.Lit),   "0011011"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.B , ParameterType.Lit),   "0011100"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.Dir),   "0011101"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.B , ParameterType.Dir),   "0011110"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.Dir , ParameterType.None),"0011111"}
            };

        public AndInstruction(String param1, String param2) : base(param1, param2){ }


        public override void addOpcode()
        {
            base.addOpcode();
            Tuple<ParameterType, ParameterType> tuple =
                new Tuple<ParameterType, ParameterType>(_param1.GetType(), _param2.GetType());
            _instruction += (opcodes[tuple]);
        }

    }
}
