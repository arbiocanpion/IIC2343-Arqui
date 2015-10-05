using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assembler
{
    class NotInstruction: Instruction
    {
        private Dictionary<Tuple<ParameterType, ParameterType>, String> opcodes =
            new Dictionary<Tuple<ParameterType, ParameterType>, string>() {
                { new Tuple<ParameterType, ParameterType>(ParameterType.A, ParameterType.None),   "0101110"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.B , ParameterType.A),     "0101111"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.Dir , ParameterType.A),   "0110000"}
            };

        public NotInstruction(String param1, String param2) : base(param1, param2){ }


        public override void addOpcode()
        {
            base.addOpcode();
            Tuple<ParameterType, ParameterType> tuple =
                new Tuple<ParameterType, ParameterType>(_param1.GetType(), _param2.GetType());
            _instruction += (opcodes[tuple]);
        }

    }
}
