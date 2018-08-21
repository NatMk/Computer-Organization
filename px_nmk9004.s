/****************************************************************************** 
* Prints an array populated with 10 input numbers and searches for a
* number based on user input. Natnael Kebede ID:1001149004
******************************************************************************/

.global main
.func main

main:

    MOV R0, #0              @ initialze index variable

writeloop:

    CMP R0, #10             @ check to see if we are done iterating
    BEQ writedone	    @ brnch to write done when done looping
    LDR R1, = a             @ get address of a
    LSL R2, R0, #2          @ multiply index*4 to get array offset
    ADD R2, R1, R2          @ R2 now has the element address
    PUSH {R0}               @ backup iterator before procedure call
    PUSH {R2}               @ backup element address before procedure call
    BL _scanf		    @ branch to scanf
    POP {R2}                @ restore element address
    STR R0, [R2]            @ write the address of a[i] to a[i]
    POP {R0}                @ restore iterator
    ADD R0, R0, #1          @ increment index
    B   writeloop           @ branch to next loop iteration

writedone:

    MOV R0, #0              @ initialze index variable

readloop:

    CMP R0, #10             @ check to see if we are done iterating
    BEQ readdone	    @ exit loop if done
    LDR R1, = a             @ get address of a
    LSL R2, R0, #2          @ multiply index*4 to get array offset
    ADD R2, R1, R2          @ R2 now has the element address
    LDR R1, [R2]            @ read the array at address
    PUSH {R0}               @ backup register before printf
    PUSH {R1}               @ backup register before printf
    PUSH {R2}               @ backup register before printf
    MOV R2, R1              @ move array value to R2 for printf
    MOV R1, R0              @ move array index to R1 for printf
    BL  _printf             @ branch to print procedure with return
    POP {R2}                @ restore register
    POP {R1}                @ restore register
    POP {R0}                @ restore register
    ADD R0, R0, #1          @ increment index
    B   readloop            @ branch to next loop iteration

readdone:

    B  _printval	    @ prompt user for search number

_scanf:

    PUSH {LR}               @ store LR since scanf call overwrites
    SUB SP, SP, #4          @ make room on stack
    LDR R0, = format_str    @ R0 contains address of format string
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ restore the stack pointer
    POP {PC}                @ return

_printf:

    PUSH {LR}               @ store the return address
    LDR R0, = printf_str    @ R0 contains formatted string address
    BL printf               @ call printf
    POP {PC}                @ restore the stack pointer and return

_printval:

    LDR R0, = printf_val    @ R0 contains formatted string address
    BL printf               @ call printf
    BL _scanf               @ branch to read the search value
    MOV R6, R0		    @ put return register to R6
    MOV R7,#50		    @ R7 = 50
    MOV R0, #0		    @ Reset R0 to 0
    B _readsearch	    @ find the read number in array

_readsearch:

    CMP R0, #10             @ check to see if we are done iterating
    BEQ _exit	    	    @ exit loop if done
    LDR R1, = a             @ get address of a
    LSL R2, R0, #2          @ multiply index*4 to get array offset
    ADD R2, R1, R2          @ R2 now has the element address
    LDR R1, [R2]            @ read the array at address
    CMP R1,R6		    @ compare R1 with R6
    PUSH {R0}               @ backup register before printf
    PUSH {R1}               @ backup register before printf
    PUSH {R2}               @ backup register before printf
    MOV R2, R1              @ move array value to R2 for printf
    MOV R1, R0              @ move array index to R1 for printf
    BLEQ  _printf           @ branch to print procedure with return
    POP {R2}                @ restore register
    POP {R1}                @ restore register
    POP {R0}                @ restore register
    SUBEQ R7, #1            @ branch to R7 = 1
    ADD R0, R0, #1          @ increment index
    B  _readsearch          @ branch to next loop iteration

_finalcheck:

  CMP R7, #50		    @ compare R7 with 50
  BEQ _incorrect	    @ branch to incorrect if R7 = 50
  BNE _exittwo		    @ branch to exittwo if R7 isn't equal to 50

_incorrect:

  MOV R7, #4		    @ write syscall, 4
  MOV R0, #1		    @ output stream to monitor, 1
  MOV R2, #100		    @ print string length
  LDR R1, = exit_str1	    @ string at label exit_str1
  SWI 0			    @ execute syscall
  MOV R7, #1		    @ terminate syscall, 1
  SWI 0			    @ execute syscall

_exittwo:

  MOV R7, #4		    @ write syscall, 4
  MOV R0, #1		    @ output stream to monitor, 1
  MOV R2, #100		    @ print string length
  SWI 0			    @ execute syscall
  MOV R7, #1		    @ terminate syscall, 1
  SWI 0			    @ execute syscall

_exit:

   B  _finalcheck	    @ branch to _finalcheck instruction

.data
.balign 4
a:              .skip       40

printf_str:     .asciz      "array_a[%d] = %d\n"
printf_val:     .asciz      "Enter A Search value: "
format_str:     .asciz      "%d"
exit_str1:      .asciz       "That value does not exist in the array!\n"




