using System;
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
                { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.B),     "0100111"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.B , ParameterType.A),     "0101000"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.Lit),   "0101001"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.B , ParameterType.Lit),   "0101010"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.A , ParameterType.Dir),   "0101011"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.B , ParameterType.Dir),   "0101100"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.Dir, ParameterType.None), "0101101"}
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
