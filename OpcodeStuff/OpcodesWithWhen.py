cd = "Opcodes.txt"
cd2 = "OpcodesWithWhen.txt"

# Get all the instructions ready
with open(cd, "r") as file:
    lines = []
    for i in file.readlines():
        lines.append(i.strip("\n").replace("\r", " "))

instructions = []
for i in lines:
    linea = " ".join(i.split()).split()
    if linea == []:
        continue
    else:
        instructions.append(" ".join(linea))

#############################################################################
# Deprecated
# for i in instructions:
#     print i
#
# Print a complete 'value when opcode, -- command'
# with open(cd2, "w") as file:
#     file.write("with Opcode select SIGNAL <=\n")
#     command = ""
#     for i in instructions:
#         line = i.split()
#         print line
#         if len(line) == 1:
#             command = line[0]
#         else:
#             if len(line) == 3:
#                 file.write("\t" + "'0'" + "\t" * 7 + 'when "' +
#                            line[2] + '", -- ' + command + " " + line[0] +
#                            ", " + line[1] + "\n")
#             elif len(line) == 2:
#                 file.write("\t" + "'0'" + "\t" * 7 + 'when "' +
#                            line[1] + '", -- ' + command + " " + line[0] +
#                            "\n")
#     file.write("\t" + "'0'" + "\t" * 7 + 'when others;\n')
#############################################################################

# DOING MAGIC


def LPC(line):
    if len(line) == 2:
        if command == "JMP":
            string = ("\t" + "'0'" + "\t" * 7 + 'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
        elif command == "JEQ":
            string = ("\t" + "Z and '1'" + "\t" * 5 + 'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
        elif command == "JNE":
            string = ("\t" + "Z xor '1'" + "\t" * 5 + 'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
        elif command == "JGT":
            string = ("\t" + "(N xor '1') and (Z xor '1')" + "\t" * 1 +
                      'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
        elif command == "JLT":
            string = ("\t" + "N and '1'" + "\t" * 5 + 'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
        elif command == "JGE":
            string = ("\t" + "N xor '0'" + "\t" * 5 + 'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
        elif command == "JLE":
            string = ("\t" + "(N and '1') or (Z and '1')" + "\t" * 1 +
                      'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
        elif command == "JCR":
            string = ("\t" + "C and '1'" + "\t" * 5 + 'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
        elif command == "JOV":
            string = ("\t" + "V and '1'" + "\t" * 5 + 'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
        else:
            string = ("\t" + "'0'" + "\t" * 7 + 'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
    elif len(line) == 3:
        string = ("\t" + "'0'" + "\t" * 7 + 'when "' +
                  line[2] + '", -- ' + command + " " +
                  line[0] + ", " + line[1] + "\n")
        return string


def LA(line):
    if len(line) == 2:
        if line[0] != 'A':
            string = ("\t" + "'0'" + "\t" * 7 + 'when "' +
                      line[1] + '", -- ' + command + " " + line[0] + "\n")
            return string
        elif line[0] == 'A':
            string = ("\t" + "'1'" + "\t" * 7 + 'when "' +
                      line[1] + '", -- ' + command + " " + line[0] + "\n")
            return string
    elif len(line) == 3:
        if line[0] != 'A':
            string = ("\t" + "'0'" + "\t" * 7 + 'when "' +
                      line[2] + '", -- ' + command + " " +
                      line[0] + ", " + line[1] + "\n")
            return string
        elif line[0] == 'A':
            string = ("\t" + "'1'" + "\t" * 7 + 'when "' +
                      line[2] + '", -- ' + command + " " +
                      line[0] + ", " + line[1] + "\n")
            return string


def LB(line):
    if len(line) == 2:
        if line[0] != 'B':
            string = ("\t" + "'0'" + "\t" * 7 + 'when "' +
                      line[1] + '", -- ' + command + " " + line[0] + "\n")
            return string
        elif line[0] == 'B':
            string = ("\t" + "'1'" + "\t" * 7 + 'when "' +
                      line[1] + '", -- ' + command + " " + line[0] + "\n")
            return string
    elif len(line) == 3:
        if line[0] != 'B':
            string = ("\t" + "'0'" + "\t" * 7 + 'when "' +
                      line[2] + '", -- ' + command + " " +
                      line[0] + ", " + line[1] + "\n")
            return string
        elif line[0] == 'B':
            string = ("\t" + "'1'" + "\t" * 7 + 'when "' +
                      line[2] + '", -- ' + command + " " +
                      line[0] + ", " + line[1] + "\n")
            return string


def SA(line):
    if len(line) == 2:
        if command == "INC":
            if line[0] == 'A':
                string = ("\t" + "'00'" + "\t" * 6 + 'when "' +
                          line[1] + '", -- ' + command + " " +
                          line[0] + "\n")
                return string
            elif line[0] == 'B' or line[0] == 'Dir':
                string = ("\t" + "'10'" + "\t" * 6 + 'when "' +
                          line[1] + '", -- ' + command + " " +
                          line[0] + "\n")
                return string
        else:
            string = ("\t" + "'00'" + "\t" * 6 + 'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
    elif len(line) == 3:
        if command == "MOV":
            if line[1] == 'A':
                string = ("\t" + "'00'" + "\t" * 6 + 'when "' +
                          line[2] + '", -- ' + command + " " +
                          line[0] + ", " + line[1] + "\n")
                return string
            else:
                string = ("\t" + "'01'" + "\t" * 6 + 'when "' +
                          line[2] + '", -- ' + command + " " +
                          line[0] + ", " + line[1] + "\n")
                return string
        else:
            string = ("\t" + "'00'" + "\t" * 6 + 'when "' +
                      line[2] + '", -- ' + command + " " +
                      line[0] + ", " + line[1] + "\n")
            return string


def SB(line):
    if len(line) == 2:
        if command == "INC":
            if line[0] == 'B':
                string = ("\t" + "'00'" + "\t" * 6 + 'when "' +
                          line[1] + '", -- ' + command + " " +
                          line[0] + "\n")
                return string
            elif line[0] == 'A' or line[0] == 'Dir':
                string = ("\t" + "'10'" + "\t" * 6 + 'when "' +
                          line[1] + '", -- ' + command + " " +
                          line[0] + "\n")
                return string
        elif command == "DEC":
            string = ("\t" + "'10'" + "\t" * 6 + 'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
        else:
            string = ("\t" + "'00'" + "\t" * 6 + 'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
    elif len(line) == 3:
        if command == "MOV":
            if line[1] == 'B':
                string = ("\t" + "'00'" + "\t" * 6 + 'when "' +
                          line[2] + '", -- ' + command + " " +
                          line[0] + ", " + line[1] + "\n")
                return string
            elif line[0] == 'B':
                string = ("\t" + "'01'" + "\t" * 6 + 'when "' +
                          line[2] + '", -- ' + command + " " +
                          line[0] + ", " + line[1] + "\n")
                return string
            elif line[1] == 'Lit':
                string = ("\t" + "'10'" + "\t" * 6 + 'when "' +
                          line[2] + '", -- ' + command + " " +
                          line[0] + ", " + line[1] + "\n")
                return string
            elif line[1] == 'Dir' or line[1] == 'DirB':
                string = ("\t" + "'11'" + "\t" * 6 + 'when "' +
                          line[2] + '", -- ' + command + " " +
                          line[0] + ", " + line[1] + "\n")
                return string
            elif line[0] == 'Dir' or line[0] == 'DirB':
                string = ("\t" + "'01'" + "\t" * 6 + 'when "' +
                          line[2] + '", -- ' + command + " " +
                          line[0] + ", " + line[1] + "\n")
                return string
        else:
            if line[1] == 'Dir' or line[1] == 'DirB':
                string = ("\t" + "'11'" + "\t" * 6 + 'when "' +
                          line[2] + '", -- ' + command + " " +
                          line[0] + ", " + line[1] + "\n")
                return string
            elif line[1] == 'Lit':
                string = ("\t" + "'10'" + "\t" * 6 + 'when "' +
                          line[2] + '", -- ' + command + " " +
                          line[0] + ", " + line[1] + "\n")
                return string
            else:
                string = ("\t" + "'00'" + "\t" * 6 + 'when "' +
                          line[2] + '", -- ' + command + " " +
                          line[0] + ", " + line[1] + "\n")
                return string


def SL(line):
    if len(line) == 2:
        if command == 'ADD':
            string = ("\t" + "'000'" + "\t" * 6 + 'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
        elif command == 'SUB':
            string = ("\t" + "'001'" + "\t" * 6 + 'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
        elif command == 'AND':
            string = ("\t" + "'010'" + "\t" * 6 + 'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
        elif command == 'OR':
            string = ("\t" + "'011'" + "\t" * 6 + 'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
        elif command == 'XOR':
            string = ("\t" + "'100'" + "\t" * 6 + 'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
        elif command == 'NOT':
            string = ("\t" + "'101'" + "\t" * 6 + 'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
        elif command == 'SHR':
            string = ("\t" + "'110'" + "\t" * 6 + 'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
        elif command == 'SHL':
            string = ("\t" + "'111'" + "\t" * 6 + 'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
        elif command == 'INC':
            string = ("\t" + "'000'" + "\t" * 6 + 'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
        elif command == 'DEC':
            string = ("\t" + "'001'" + "\t" * 6 + 'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
        else:
            string = ("\t" + "'000'" + "\t" * 6 + 'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
    elif len(line) == 3:
        if command == 'ADD':
            string = ("\t" + "'000'" + "\t" * 6 + 'when "' +
                      line[2] + '", -- ' + command + " " +
                      line[0] + ", " + line[1] + "\n")
            return string
        elif command == 'SUB':
            string = ("\t" + "'001'" + "\t" * 6 + 'when "' +
                      line[2] + '", -- ' + command + " " +
                      line[0] + ", " + line[1] + "\n")
            return string
        elif command == 'AND':
            string = ("\t" + "'010'" + "\t" * 6 + 'when "' +
                      line[2] + '", -- ' + command + " " +
                      line[0] + ", " + line[1] + "\n")
            return string
        elif command == 'OR':
            string = ("\t" + "'011'" + "\t" * 6 + 'when "' +
                      line[2] + '", -- ' + command + " " +
                      line[0] + ", " + line[1] + "\n")
            return string
        elif command == 'XOR':
            string = ("\t" + "'100'" + "\t" * 6 + 'when "' +
                      line[2] + '", -- ' + command + " " +
                      line[0] + ", " + line[1] + "\n")
            return string
        elif command == 'NOT':
            string = ("\t" + "'101'" + "\t" * 6 + 'when "' +
                      line[2] + '", -- ' + command + " " +
                      line[0] + ", " + line[1] + "\n")
            return string
        elif command == 'SHR':
            string = ("\t" + "'110'" + "\t" * 6 + 'when "' +
                      line[2] + '", -- ' + command + " " +
                      line[0] + ", " + line[1] + "\n")
            return string
        elif command == 'SHL':
            string = ("\t" + "'111'" + "\t" * 6 + 'when "' +
                      line[2] + '", -- ' + command + " " +
                      line[0] + ", " + line[1] + "\n")
            return string
        elif command == 'CMP':
            string = ("\t" + "'001'" + "\t" * 6 + 'when "' +
                      line[2] + '", -- ' + command + " " +
                      line[0] + ", " + line[1] + "\n")
            return string
        else:
            string = ("\t" + "'000'" + "\t" * 6 + 'when "' +
                      line[2] + '", -- ' + command + " " +
                      line[0] + ", " + line[1] + "\n")
            return string


def SAdd(line):
    if len(line) == 2:
        return "asd"
    elif len(line) == 3:
        return "asd"


def SDin(line):
    if len(line) == 2:
        return "asd"
    elif len(line) == 3:
        return "asd"


def SPC(line):
    if len(line) == 2:
        return "asd"
    elif len(line) == 3:
        return "asd"


def W(line):
    if len(line) == 2:
        if line[0] == 'Dir':
            string = ("\t" + "'1'" + "\t" * 7 + 'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
        else:
            string = ("\t" + "'0'" + "\t" * 7 + 'when "' +
                      line[1] + '", -- ' + command + " " +
                      line[0] + "\n")
            return string
    elif len(line) == 3:
        if line[0] == 'Dir' or line[0] == 'DirB':
            string = ("\t" + "'1'" + "\t" * 7 + 'when "' +
                      line[2] + '", -- ' + command + " " +
                      line[0] + ", " + line[1] + "\n")
            return string
        else:
            string = ("\t" + "'0'" + "\t" * 7 + 'when "' +
                      line[2] + '", -- ' + command + " " +
                      line[0] + ", " + line[1] + "\n")
            return string


def IncSp(line):
    if len(line) == 2:
        return "NOT REQUIRED YET"
    elif len(line) == 3:
        return "NOT REQUIRED YET"


def DecSp(line):
    if len(line) == 2:
        return "NOT REQUIRED YET"
    elif len(line) == 3:
        return "NOT REQUIRED YET"


signals = {
    'LPC': LPC,
    'LA': LA,
    'LB': LB,
    'SA': SA,
    'SB': SB,
    'SL': SL,
    'SAdd': SAdd,
    'SDin': SDin,
    'SPC': SPC,
    'W': W,
    'IncSp': IncSp,
    'DecSp': DecSp
}

signals_list = [
    'LPC',
    'LA',
    'LB',
    'SA',
    'SB',
    'SL',
    'SAdd',
    'SDin',
    'SPC',
    'W',
    'IncSp',
    'DecSp',
]

signal_bit_lenght = {
    'LPC': 1,
    'LA': 1,
    'LB': 1,
    'SA': 2,
    'SB': 2,
    'SL': 3,
    'SAdd': 2,
    'SDin': 1,
    'SPC': 1,
    'W': 1,
    'IncSp': 1,
    'DecSp': 1
}

signal_tab_number = {
    'LPC': 7,
    'LA': 7,
    'LB': 7,
    'SA': 6,
    'SB': 6,
    'SL': 6,
    'SAdd': 6,
    'SDin': 7,
    'SPC': 7,
    'W': 7,
    'IncSp': 7,
    'DecSp': 7
}

# print signals.get('LPC') # => 1
# print signals.get('SL') # => 3

with open(cd2, "w") as file:
    for signal in signals_list:
        # print signal
        file.write("with Opcode select " + signal + " <=\n")
        command = ""
        for i in instructions:
            line = i.split()
            # print line
            if len(line) == 1:
                command = line[0]
            else:
                func = signals.get(signal)
                to_print = func(line)
                file.write(to_print)
        file.write("\t" + "'" + "0" * signal_bit_lenght.get(signal, 1) + "'" +
                   "\t" * signal_tab_number.get(signal, 1) + 'when others;\n')
        file.write("\n")
