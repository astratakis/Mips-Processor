
opcodes = {'add':'100000', 'li':'111000', 'lui':'111001'}

triplets = ['add']
single_immeds = ['li', 'lui']

registers = { '$0':'00000', '$1':'00001', '$2':'00010', '$3':'00011', '$4':'00100', '$5':'00101', '$6':'00110', '$7':'00111', 
'$8':'01000', '$9':'01001', '$10':'01010', '$11':'01011', '$12':'01100', '$13':'01101', '$14':'01110', '$15':'01111', '$16':'10000', 
'$17':'10001', '$18':'10010', '$19':'10011', '$20':'10100', '$21':'10101', '$22':'10110', '$23':'10111', '$24':'11000', '$25':'11001', 
'$26':'11010', '$27':'11011', '$28':'11100', '$29':'11101', '$30':'11110', '$31':'11111' }

functions = {'add':'110000'}

def main():

    file = open("sample.txt", "r")

    encoded_list = []

    for line in file:
        tokens = line.split()
        print(tokens)

        item = ""
        
        if tokens[0] in triplets:
            item = str(opcodes.get(tokens[0])) + str(registers.get(tokens[2])) + str(registers.get(tokens[1])) + str(registers.get(tokens[3])) + '-----' + str(functions.get(tokens[0]))
        
        elif tokens[0] in single_immeds:
            item = str(opcodes.get(tokens[0])) + '-----' + str(registers.get(tokens[1])) + '{0:016b}'.format(int(tokens[2]))

        assert len(item) == 32, 'Expected 32 bits'

        encoded_list.append(item)

    for item in encoded_list:
        print(item)

if __name__ == "__main__":
    main()