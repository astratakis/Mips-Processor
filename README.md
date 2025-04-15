# Mips Processor

This repository contains the implementation of a Mips-inpired processor with a reduced instruction set. There are **3** different implementations of the processor. A basic single cycle, a more complex multi cycle and an advanced one with pipeline.

## Instruction Types

### R-Type

| 6 bits | 5 bits | 5 bits | 5 bits | 5 bits | 6 bits |
|--------|--------|--------|--------|--------|--------|
| Opcode |   Rs   |   Rd   |   Rt   | unused |  Func  |

### J-Type

| 6 bits | 5 bits | 5 bits | 16 bits         |
|--------|--------|--------|----------------|
| Opcode |   Rs   |   Rd   | Immediate       |


## Instruction Set

| Opcode      | Type | Func | Instr |  Description |
|--------------| - | ------ | ----- | ----------------------------|
| 100000 | R | 110000 | add | `RF[rd] ← RF[rs] + RF[rt]` |
| 100000 | R | 110001 | sub | `RF[rd] ← RF[rs] - RF[rt]` |
| 100000 | R | 110010 | and | `RF[rd] ← RF[rs] & RF[rt]` |
| 100000 | R | 110011 | or | `RF[rd] ← RF[rs] \| RF[rt]` |
| 100000 | - | 110100 | not | `RF[rd] ← !RF[rs]` |
| 100000 | R | 110101 | mul | `RF[rd] ← RF[rs] * RF[rt]` |
| 100000 | R | 110110 | div | `RF[rd] ← RF[rs] / RF[rt]` |
| 100000 | R | 110111 | mod | `RF[rd] ← RF[rs] % RF[rt]` |
| 100000 | J | 111000 | sra | `RF[rd] ← SE(RF[rs] >> ZF(Imm))` |
| 100000 | J | 111001 | sll | `RF[rd] ← RF[rs] << ZF(Imm)` |
| 100000 | J | 111010 | srl | `RF[rd] ← ZF(RF[rs] >> ZF(Imm))` |
| 100000 | J | 111011 | rol | `RF[rd] ← Rotate left(RF[rs])` |
| 100000 | J | 111100 | ror | `RF[rd] ← Rotate right(RF[rs])` |
| 100000 | R | 111101 | nand | `RF[rd] ← RF[rs] !& RF[rt]` |
| 100000 | R | 111110 | nor | `RF[rd] ← RF[rs] !\| RF[rt]` |
| 100000 | R | 111111 | xor | `RF[rd] ← RF[rs] ⊕ RF[rt]` |
| 111000 | J | - | li | `RF[rd] ← SE(Imm)` |
| 111001 | J | - | lui | `RF[rd] ← (Imm << 16)` |
| 110000 | J | - | addi | `RF[rd] ← RF[rs] + SE(Imm)` |
| 110010 | J | - | andi | `RF[rd] ← RF[rs] & ZF(Imm)` |
| 110011 | J | - | ori | `RF[rd] ← RF[rs] \| ZF(Imm)` |
| 111111 | J | - | b | `PC ← PC + 4 + (SE(Imm) << 2)` |
| 111110 | J | - | br | `PC ← PC + 4 + RF[rs]` |
| 010000 | J | - | beq | `PC ← PC + 4 + (SE(Imm) << 2) if RF[rs] == RF[rd]` |
| 010001 | J | - | bne | `PC ← PC + 4 + (SE(Imm) << 2) if RF[rs] != RF[rd]` |
| 000011 | J | - | lb | `RF[rd] ← ZF(MEM[RF[rs] + SE(Imm)] 7...0)` |
| 001111 | J | - | lw | `RF[rd] ← MEM[RF[rs] + SE(Imm)]` |
| 000111 | J | - | sb | `MEM[RF[rs] + SE(Imm)] ← RF[rd] 7...0` |
| 011111 | J | - | sw | `MEM[RF[rs] + SE(Imm)] ← RF[rd]` |

