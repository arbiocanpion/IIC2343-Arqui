using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assembler
{
    class MovInstruction : Instruction
    {
        private Dictionary<Tuple<ParameterType, ParameterType>, String> opcodes =
            new Dictionary<Tuple<ParameterType, ParameterType>, string>() {
                { new Tuple<ParameterType, ParameterType>(ParameterType.A, ParameterType.B),     "0000000"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.B, ParameterType.A),     "0000001"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.A, ParameterType.Lit),   "0000010"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.B, ParameterType.Lit),   "0000011"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.A, ParameterType.Dir),   "0000100"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.B, ParameterType.Dir),   "0000101"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.Dir, ParameterType.A),   "0000110"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.Dir, ParameterType.B),   "0000111"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.A, ParameterType.DirB),  "0001000"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.B, ParameterType.DirB),  "0001001"},
                { new Tuple<ParameterType, ParameterType>(ParameterType.DirB, ParameterType.A),  "0001010"}
        };

        public MovInstruction(String param1, String param2) : base(param1, param2){ }

        public override void addOpcode()
        {
            base.addOpcode();
            Tuple<ParameterType, ParameterType> tuple =
                new Tuple<ParameterType, ParameterType>(_param1.GetType(), _param2.GetType());
            _instruction += (opcodes[tuple]);
        }
    }
}
