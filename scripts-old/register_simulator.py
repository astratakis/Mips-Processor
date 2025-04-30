# Register Simulator for CHARIS version 1
#
# THIS WILL NOT DETECT ATERMINAL LOOPS
# MAKE SURE THE CODE TERMINATES BEFORE SIMULATING

from atexit import register


data_segment = [
    "c^&1909587*($^# *&^ )(   )(* ^&^$a^(* 0954 23095 780(*&&^n+Y*(&%(_()  ++%^&#87--_)( 09 )(*O127639*^%#U(*& 89&^ f* 9*i8754 987 6@#$%^&*()n 6d)(**&^%*&^*&^%13928746 M^ 976 491823 *&%^%#$&*&_)*(E"
]

code_segment = [
    	"li r16 0",
	"li r17 400",
	"add r19 r0 r17",
	"b 4",
	"li r2 4",
	"add r4 r0 r17",
	"li r2 10",
	"b -1",
	"add r8 r0 r16",
	"li r20 0",
	"li r21 255",
	"li r3 1",
	"li r15 0",
	"li r14 0",
	"li r22 4",
	"li r10 0",
	"lui r23 8192",
	"li r18 8",
	"lw r13 r8 0",
	"li r9 4",
	"and r12 r21 r13",
	"li r11 0",
	"li r18 8",
	"b 6",
	"beq r12 r20 13",
	"b 23",
	"sub r9 r9 r3",
	"bne r0 r9 -8",
	"addi r8 r8 4",
	"b -12",
	"srl r13 r13 1",
	"addi r11 r11 1",
	"bne r11 r18 -3",
	"b -10",
	"srl r15 r15 1",
	"addi r11 r11 1",
	"bne r11 r18 -3",
	"b 6",
	"bne r0 r14 1",
	"b -36",
	"b 0",
	"li r11 0",
	"li r18 8",
	"b -10",
	"addi r14 r14 1",
	"bne r14 r22 -5",
	"sw r15 r19 0",
	"add r14 r0 r0",
	"b -45",
	"li r24 65",
	"li r25 91",
	"beq r12 r24 17",
	"addi r24 r24 1",
	"beq r24 r25 1",
	"b -4",
	"li r24 97",
	"li r25 123",
	"beq r12 r24 11",
	"addi r24 r24 1",
	"beq r24 r25 20",
	"b -4",
	"srl r15 r15 1",
	"addi r11 r11 1",
	"bne r11 r18 -3",
	"b 10",
	"sll r12 r12 1",
	"addi r11 r11 1",
	"bne r11 r18 -3",
	"b 3",
	"li r11 0",
	"li r18 24",
	"b -7",
	"li r11 0",
	"li r18 8",
	"b -14",
	"add r15 r15 r12",
	"addi r14 r14 1",
	"li r10 0",
	"beq r22 r14 3",
	"b -54",
	"beq r10 r0 10",
	"b -56",
	"sw r15 r19 0",
	"addi r19 r19 4",
	"li r14 0",
	"add r15 r0 r0",
	"b -61",
	"srl r15 r15 1",
	"addi r11 r11 1",
	"bne r11 r18 -3",
	"b 3",
	"li r11 0",
	"li r18 8",
	"b -7",
	"add r15 r15 r23",
	"addi r14 r14 1",
	"li r10 1",
	"beq r22 r14 -16",
	"b -73",
    "b -1"
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
    change = True
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
        change = False
        pc = pc + (int(parts[1]) << 2)
    elif instr == "beq":
        change = False
        if registers[reg(parts[1])] == registers[reg(parts[2])]:
            pc = pc + (int(parts[3]) << 2)
    elif instr == "bne":
        change = False
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
        change = False
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

    print("PC:", pc+4, "Command:", command)
    registers.reverse()
    print(registers)
    registers.reverse()

    input()

registers.reverse()

print("PC:", pc)
print(registers)
print("Total instructions Executed:", total_executions)

offset = 100
print('RAM: ', end="")
for i in range(7):
    print(offset+i + (1 << 8), word_to_decimal(ram[offset+i]), end=" | ")
