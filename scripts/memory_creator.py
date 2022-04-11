
input_string = "c^&1909587*($^# *&^ )(   )(* ^&^$a^(* 0954 23095 780(*&&^n+Y*(&%(_()  ++%^&#87--_)( 09 )(*O127639*^%#U(*& 89&^ f* 9*i8754 987 6@#$%^&*()n 6d)(**&^%*&^*&^%13928746 M^ 976 491823 *&%^%#$&*&_)*(E"

empty = "00000000000000000000000000000000"

leading_zeros = {0:"", 1:"0", 2:"00", 3:"000", 4:"0000"}

commands = [
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

count = 0

for command in commands:
	print(count, " ", command)
	count = count + 4

code_segment = []

print('Total instructions: ', len(commands))

for command in commands:
    parts = command.split()

    instr = parts[0]

    if instr == "li":

        reg_num = parts[1][1:]

        instruction = "11100000000" + str(bin(int(reg_num)))[2:].zfill(5) + str(bin(int(parts[2])))[2:].zfill(16)

    elif instr == "add":
        
        rd = parts[1][1:]
        rs = parts[2][1:]
        rt = parts[3][1:]

        instruction = "100000" + str(bin(int(rs)))[2:].zfill(5) + str(bin(int(rd)))[2:].zfill(5) + str(bin(int(rt)))[2:].zfill(5) + "00000" + "110000"
    elif instr == "lui":

        reg_num = parts[1][1:]

        instruction = "11100100000" + str(bin(int(reg_num)))[2:].zfill(5) + str(bin(int(parts[2])))[2:].zfill(16)
    elif instr == "lw":

        rd = parts[1][1:]
        rs = parts[2][1:]

        instruction = "001111" + str(bin(int(rs)))[2:].zfill(5) + str(bin(int(rd)))[2:].zfill(5) + str(bin(int(parts[3])))[2:].zfill(16)
    elif instr == "and":

        rd = parts[1][1:]
        rs = parts[2][1:]
        rt = parts[3][1:]

        instruction = "100000" + str(bin(int(rs)))[2:].zfill(5) + str(bin(int(rd)))[2:].zfill(5) + str(bin(int(rt)))[2:].zfill(5) + "00000" + "110010"
    elif instr == "b":

        eee = int(parts[1])

        instruction = "1111110000000000" + format(int(parts[1]) % (1 << 16), "b").zfill(16)
    elif instr == "nop":

        instruction = empty
    
    elif instr == "srl":

        rd = parts[1][1:]
        rs = parts[2][1:]

        instruction = "100000" + str(bin(int(rs)))[2:].zfill(5) + str(bin(int(rd)))[2:].zfill(5) + "0000000000" + "111001"
    
    elif instr == "addi":

        rd = parts[1][1:]
        rs = parts[2][1:]

        instruction = "110000" + str(bin(int(rs)))[2:].zfill(5) + str(bin(int(rd)))[2:].zfill(5) + str(bin(int(parts[3])))[2:].zfill(16)
    
    elif instr == "bne":

        rd = parts[1][1:]
        rs = parts[2][1:]

        instruction = "000001" + str(bin(int(rs)))[2:].zfill(5) + str(bin(int(rd)))[2:].zfill(5) + format(int(parts[3]) % (1 << 16), "b").zfill(16)
    elif instr == "beq":
        
        rd = parts[1][1:]
        rs = parts[2][1:]

        instruction = "000000" + str(bin(int(rs)))[2:].zfill(5) + str(bin(int(rd)))[2:].zfill(5) + format(int(parts[3]) % (1 << 16), "b").zfill(16)
    elif instr == "sub":

        rd = parts[1][1:]
        rs = parts[2][1:]
        rt = parts[3][1:]

        instruction = "100000" + str(bin(int(rs)))[2:].zfill(5) + str(bin(int(rd)))[2:].zfill(5) + str(bin(int(rt)))[2:].zfill(5) + "00000" + "110001"

    elif instr == "sw":

        rd = parts[1][1:]
        rs = parts[2][1:]

        instruction = "011111" + str(bin(int(rs)))[2:].zfill(5) + str(bin(int(rd)))[2:].zfill(5) + str(bin(int(parts[3])))[2:].zfill(16)

    elif instr == "sll":

        rd = parts[1][1:]
        rs = parts[2][1:]

        instruction = "100000" + str(bin(int(rs)))[2:].zfill(5) + str(bin(int(rd)))[2:].zfill(5) + "0000000000" + "111010"
    

    else:
        print("NOT FOUND... (", instr, ")")
        exit(0)

    
    if (len(instruction) != 32):
        print("Error", instr)

    code_segment.append(instruction)

ram_file = open("ram.data", "w")

for elem in code_segment:
    ram_file.write(elem)
    ram_file.write("\n")

for i in range(256 - len(code_segment)):
    ram_file.write(empty)
    ram_file.write("\n")

def toBinary(a):
  l,m=[],[]
  for i in a:
    l.append(ord(i))
  for i in l:
    m.append(int(bin(i)[2:]))
  return m

binary = toBinary(input_string)
binary.append("00000000")

total = int(len(binary)/4)
remain = len(binary) % 4

count = 0

for i in range(total):
    word = str(leading_zeros.get(8-len(str(binary[4*i + 3])))) + str(str(binary[4*i + 3])) + str(leading_zeros.get(8-len(str(binary[4*i + 2])))) + str(str(binary[4*i + 2])) + str(leading_zeros.get(8-len(str(binary[4*i + 1])))) + str(str(binary[4*i + 1])) + str(leading_zeros.get(8-len(str(binary[4*i])))) + str(str(binary[4*i])) 

    ram_file.write(word)
    ram_file.write("\n")

word = ""

for i in range(remain):
    word = word + str(leading_zeros.get(8-len(str(binary[4*total + i])))) + str(binary[4*total + i])

for i in range(4-remain):
    word = word + "00000000"

ram_file.write(word)
ram_file.write("\n")

last = (1 << 11) - 256 - total
if (remain != 0):
    last = last - 1

for i in range(last-1):
    ram_file.write(empty)
    ram_file.write("\n")

ram_file.write(empty)

ram_file.close()

ram_file = open("ram.data", "r")

nums = []

for line in ram_file:
    nums.append(int(line, 2))

bin_file = open("ram.bin", "wb")

for num in nums:

    bin_file.write(num.to_bytes(4, 'big'))

bin_file.close()