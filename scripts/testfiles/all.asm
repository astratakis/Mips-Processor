
.data

    input: .asciiz "c^&1909587*($^# *&^ )(   )(* ^&^$a^(* 0954 23095 780(*&&^n+Y*(&%(_()  ++%^&#87--_)( 09 )(*O127639*^%#U(*& 89&^ f* 9*i8754 987 6@#$%^&*()n 6d)(**&^%*&^*&^%13928746 M^ 976 491823 *&%^%#$&*&_)*(E"

    .align 2
    output: .space 200

.text

main:

    la $s0 input
    la $s1 output
    move $s3 $s1

    j Process

    end_process:

    li $v0 4
    move $a0 $s1
    syscall

    li $v0 10
    syscall

# subroutine
Process:

    # $s0 contains the input address...

    # Copy the address of the input to $t0
    move $t0 $s0

    li $s4 0x00
    li $s5 0xFF

    li $v1 1

    # This is the saving register
    li $t7 0x00
    # This is the size of the saving register
    li $t6 0x00
    # This is the max size...
    li $s6 0x04
    # This is used as a boolean value (had previous letter...)
    li $t2 0x00

    # Just save the space character...
    lui $s7 0x2000

    li $s2 0x08

    outer_loop:

        # Register $t5 contains the loaded word from the input address.
        lw $t5 0($t0)

        li $t1 0x04

        inner_loop:

            # Get 1 byte and save it into $t4.
            and $t4 $s5 $t5

            # Shift register with loaded word bt 8 bits (to prepare for the next byte process)
            li $t3 0x00
            li $s2 0x08
            j slide_right_op1

            continue_after_slide_1:

            # Upon reaching NULL character terminate process...
            beq $t4 $s4 terminate_process

            j edit

            end_edit:

            # Reduce counter $t1 by 1
            sub $t1 $t1 $v1

            # If t1 != repeat innter loop else break...
            bne $zero $t1 inner_loop

            # Go to the next 4 bytes
            addi $t0 4
            j outer_loop

slide_right_op1:

    srl $t5 $t5 1
    addi $t3 1
    bne $t3 $s2 slide_right_op1

j continue_after_slide_1

slide_right_op2:
    srl $t7 $t7 1
    addi $t3 1
    bne $t3 $s2 slide_right_op2

j continue_after_slide_2

terminate_process:
    bne $zero $t6 final_dump
    j end_process

final_dump:

    nop

    shift:
        li $t3 0x00
        li $s2 0x08
        j slide_right_op2

        continue_after_slide_2:
        addi $t6 1

        bne $t6 $s6 shift

    sw $t7 0($s3)
    move $t6 $zero
    j end_process

edit:

    li $t8 0x41
    li $t9 0x5B

    repeat1:

        beq $t4 $t8 symbol

        addi $t8 1

        beq $t8 $t9 continue_edit

        j repeat1
    
    continue_edit:

    li $t8 0x61
    li $t9 0x7B

    repeat2:

        beq $t4 $t8 symbol

        addi $t8 1

        beq $t8 $t9 no_symbol

        j repeat2

slide_right_op3:

    srl $t7 $t7 1
    addi $t3 1
    bne $t3 $s2 slide_right_op3

j continue_after_slide_3

slide_left_op1:
    sll $t4 $t4 1
    addi $t3 1
    bne $t3 $s2 slide_left_op1
j continue_after_slide_4

symbol:

    li $t3 0x00
    li $s2 24
    j slide_left_op1
    continue_after_slide_4:

    li $t3 0x00
    li $s2 0x08
    j slide_right_op3
    continue_after_slide_3:
    
    add $t7 $t7 $t4

    addi $t6 1
    li $t2 0x00

    beq $s6 $t6 mem_dump

    j end_edit

no_symbol:

    beq $t2 $zero save_space
    j end_edit

mem_dump:

    sw $t7 0($s3)
    addi $s3 4
    li $t6 0x00

    move $t7 $zero

    j end_edit

final_slide_right:
    srl $t7 $t7 1
    addi $t3 1
    bne $t3 $s2 final_slide_right
j continue_after_slide_5

save_space:

    li $t3 0x00
    li $s2 0x08
    j final_slide_right
    continue_after_slide_5:
    
    add $t7 $t7 $s7

    addi $t6 1
    li $t2 0x01

    beq $s6 $t6 mem_dump

    j end_edit