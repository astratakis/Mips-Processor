# Register Simulator for CHARIS version 1
#
# THIS WILL NOT DETECT ATERMINAL LOOPS
# MAKE SURE THE CODE TERMINATES BEFORE SIMULATING

data_segment = [
    # "c^&1909587*($^# *&^ )(   )(* ^&^$a^(* 0954 23095 780(*&&^n+Y*(&%(_()  ++%^&#87--_)( 09 )(*O127639*^%#U(*& 89&^ f* 9*i8754 987 6@#$%^&*()n 6d)(**&^%*&^*&^%13928746 M^ 976 491823 *&%^%#$&*&_)*(E"
]

code_segment = [
    
]

# Ram will simulate the data segment only!!!
ram = []

for element in data_segment:

    total_words = len(element) >> 2

    if len(element) % 2 != 0:
        total_words = total_words + 1

    for i in range(total_words):

        s = element[4*i:(4*i + 4)]
        b = bytearray()
        b.extend(map(ord, s))

        byte_list = []

        for byte in b:
            byte_list.append(byte)

        if (len(byte_list) != 4):
            for i in range(4 - len(byte_list)):
                byte_list.append(0)

        byte_list.reverse()

        ram.append(byte_list)

used_ram_words = len(ram)

for i in range((1 << 11) - (1 << 8) - used_ram_words):
    ram.append([0, 0, 0, 0])

# Simulation of Instructions...
# MAKE SURE THE PROGRAM TERMINATES
# ATERMINAL LOOPS ARE NOT DETECTED.

registers = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
             0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
pc = -4

total_executions = 0


def reg(register):
    return int(register[1:])


def word_to_decimal(word):
    val = int(word[3]) + (int(word[2]) << 8) + \
        (int(word[1]) << 16) + (int(word[0]) << 24)
    return val


while True:

    pc = pc + 4
    command = code_segment[pc >> 2]

    total_executions = total_executions + 1

    parts = command.split(" ")
    instr = parts[0]

    # Execute instructions
    if command == "b -1":
        break
    elif instr == "lw":
        pos = (registers[reg(parts[2])] + int(parts[3])) >> 2
        word = ram[pos]
        registers[reg(parts[1])] = word_to_decimal(word)
    elif instr == "li":
        registers[reg(parts[1])] = int(parts[2])
    elif instr == "lui":
        registers[reg(parts[1])] = (int(parts[2]) << 16)
    elif instr == "add":
        registers[reg(parts[1])] = (
            registers[reg(parts[2])] + registers[reg(parts[3])])
    elif instr == "sub":
        registers[reg(parts[1])] = (
            registers[reg(parts[2])] - registers[reg(parts[3])])
    elif instr == "and":
        registers[reg(parts[1])] = (
            registers[reg(parts[2])] & registers[reg(parts[3])])
    elif instr == "addi":
        registers[reg(parts[1])] = (registers[reg(parts[2])] + int(parts[3]))
    elif instr == "b":
        pc = pc + (int(parts[1]) << 2)
    elif instr == "beq":
        if registers[reg(parts[1])] == registers[reg(parts[2])]:
            pc = pc + (int(parts[3]) << 2)
    elif instr == "bne":
        if registers[reg(parts[1])] != registers[reg(parts[2])]:
            pc = pc + (int(parts[3]) << 2)
    elif instr == "srl":
        registers[reg(parts[1])] = (registers[reg(parts[2])] >> 1)
    elif instr == "sll":
        registers[reg(parts[1])] = (registers[reg(parts[2])] << 1)
    elif instr == "ori":
        registers[reg(parts[1])] = registers[reg(parts[2])] | int(parts[3])
    elif instr == "sw":
        pos = (registers[reg(parts[2])] + int(parts[3])) >> 2

        new_word = [0, 0, 0, 0]
        rd = registers[reg(parts[1])]

        new_word[3] = rd & 255
        new_word[2] = (rd >> 8) & 255
        new_word[1] = (rd >> 16) & 255
        new_word[0] = (rd >> 24) & 255

        ram[pos] = new_word
    elif instr == "not":
        registers[reg(parts[1])] = ~registers[reg(parts[2])]
    elif instr == "nand":
        registers[reg(parts[1])] = ~(registers[reg(parts[2])] & registers[reg(parts[3])])
    elif instr == "nor":
        registers[reg(parts[1])] = ~(registers[reg(parts[2])] | registers[reg(parts[3])])
    elif instr == "or":
        registers[reg(parts[1])] = (registers[reg(parts[2])] | registers[reg(parts[3])])
    elif instr == "nandi":
        registers[reg(parts[1])] = ~(registers[reg(parts[2])] & int(parts[3]))
    elif instr == "sra":
        registers[reg(parts[1])] = (registers[reg(parts[2])] >> 1) + 0x80000000
    else:
        print('Command not found... ', instr)
        exit(1)

registers.reverse()

print("PC:", pc)
print(registers)
print("Total instructions Executed:", total_executions)

offset = 100
print('RAM: ', end="")
for i in range(7):
    print(offset+i + (1 << 8), word_to_decimal(ram[offset+i]), end=" | ")
