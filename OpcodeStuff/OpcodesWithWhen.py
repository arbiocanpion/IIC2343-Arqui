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


def create_string(value, n_tabs=7):
    if (
        signal == "SA" or
        signal == "SB" or
        signal == "SL" or
        signal == "SAdd"
    ):
        n_tabs = 6
    if len(line) == 2:
        string = ("\t" + value + "\t" * n_tabs +
                  'when "' + line[1] + '", -- ' +
                  command + " " + line[0] + "\n")
        return string
    elif len(line) == 3:
        string = ("\t" + value + "\t" * n_tabs +
                  'when "' + line[2] + '", -- ' +
                  command + " " + line[0] + ", " +
                  line[1] + "\n")
        return string


def LPC(line):
    if command == "JMP":
        return create_string("'0'")
    elif command == "JEQ":
        return create_string("Z and '1'", 5)
    elif command == "JNE":
        return create_string("Z xor '1'", 5)
    elif command == "JGT":
        return create_string("(N xor '1') and (Z xor '1')", 1)
    elif command == "JLT":
        return create_string("N and '1'", 5)
    elif command == "JGE":
        return create_string("N xor '0'", 5)
    elif command == "JLE":
        return create_string("(N and '1') or (Z and '1')", 1)
    elif command == "JCR":
        return create_string("C and '1'", 5)
    elif command == "JOV":
        return create_string("V and '1'", 5)
    else:
        return create_string("'0'")


def LA(line):
    if line[0] != 'A':
        return create_string("'0'")
    elif line[0] == 'A':
        return create_string("'1'")


def LB(line):
    if line[0] != 'B':
        return create_string("'0'")
    elif line[0] == 'B':
        return create_string("'1'")


def SA(line):
    if command == "MOV":
        if line[1] == 'A':
            return create_string('"00"')
        else:
            return create_string('"01"')
    elif command == "INC":
        if line[0] == 'A':
            return create_string('"00"')
        elif line[0] == 'B' or line[0] == 'Dir':
            return create_string('"10"')
    else:
        return create_string('"00"')


def SB(line):
    if command == "MOV":
        if line[1] == 'B':
            return create_string('"00"')
        elif line[0] == 'B':
            return create_string('"01"')
        elif line[1] == 'Lit':
            return create_string('"10"')
        elif line[1] == 'Dir' or line[1] == 'DirB':
            return create_string('"11"')
        elif line[0] == 'Dir' or line[0] == 'DirB':
            return create_string('"01"')
    elif command == "INC":
        if line[0] == 'B':
            return create_string('"00"')
        elif line[0] == 'A' or line[0] == 'Dir':
            return create_string('"10"')
    elif command == "DEC":
        return create_string('"10"')
    else:
        if line[1] == 'Dir' or line[1] == 'DirB':
            return create_string('"11"')
        elif line[1] == 'Lit':
            return create_string('"10"')
        else:
            return create_string('"00"')


def SL(line):
    if command == 'ADD':
        return create_string('"000"')
    elif command == 'SUB':
        return create_string('"001"')
    elif command == 'AND':
        return create_string('"010"')
    elif command == 'OR':
        return create_string('"011"')
    elif command == 'XOR':
        return create_string('"100"')
    elif command == 'NOT':
        return create_string('"101"')
    elif command == 'SHR':
        return create_string('"110"')
    elif command == 'SHL':
        return create_string('"111"')
    elif command == 'INC':
        return create_string('"000"')
    elif command == 'DEC':
        return create_string('"001"')
    elif command == 'CMP':
        return create_string('"001"')
    else:
        return create_string('"000"')


def SAdd(line):
    if (
        command == "CALL" or
        command == "RET" or
        command == "PUSH" or
        command == "POP"
    ):
        return create_string('"10"')
    elif (line[0] == "Dir" or (len(line) >= 2 and line[1] == "Dir")):
        return create_string('"00"')
    elif (line[0] == "DirB" or (len(line) >= 2 and line[1] == "DirB")):
        return create_string('"01"')
    else:
        return create_string('"00"')


def SDin(line):
    if command == "CALL":
        return create_string("'1'")
    else:
        return create_string("'0'")


def SPC(line):
    if command == "RET":
        return create_string("'1'")
    else:
        return create_string("'0'")


def W(line):
    if line[0] == 'Dir' or line[0] == 'DirB':
        return create_string("'1'")
    else:
        return create_string("'0'")


def IncSp(line):
    if command == "RET" or command == "POP":
        return create_string("'1'")
    else:
        return create_string("'0'")


def DecSp(line):
    if command == "CALL" or command == "PUSH":
        return create_string("'1'")
    else:
        return create_string("'0'")


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

# NOW LET'S DO IT
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
        if signal_bit_lenght.get(signal, 1) > 1:
            file.write("\t" + '"' + "0" * signal_bit_lenght.get(signal, 1) +
                       '"' + "\t" * signal_tab_number.get(signal, 1) +
                       'when others;\n')
        else:
            file.write("\t" + "'" + "0" +
                       "'" + "\t" * signal_tab_number.get(signal, 1) +
                       'when others;\n')
        file.write("\n")
