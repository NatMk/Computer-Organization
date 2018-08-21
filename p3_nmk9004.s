/***************************************************************************** 
* Implements recursive solution for computing * * integer partitions of      * 
* positive integer n with parts m
* Natnael Kebede ID:1001149004 	 					    * 
******************************************************************************/

.global main
.func main

main:

    BL _scanfone		 @ branch to scanf procedure with return
    MOV R7, R0			 @ move return value R0 to argument regiser R5
    PUSH {R7}			 @ store R7
    BL _scanftwo                 @ branch to scanf procedure with return
    MOV R8, R0			 @ move return value R0 to R8
    PUSH {R8}			 @ store R8
    BL _partitions		 @ branch to partitions procedure with return
    MOV R1, R0			 @ move return value R0 to R1
    BL _print			 @ branch to print procedure with return
    B _loop			 @ branch to loop procedure

_partitions:

    PUSH {LR}			 @ store LR since scanf call overwrites
    CMP R7,#0			 @ compare R7 with 0
    MOVEQ R0,#1		         @ If R7 = 0, store one into R0
    POPEQ {PC}			 @ If R7 = 0, restore
    MOVLT R0, #0                 @ If R7 < 0, move value to R0
    POPLT {PC}			 @ If R7 < 0, restore
    CMP R8, #0			 @ compare R8 with 0
    MOVEQ R0,#0		         @ If R8 = 0, store 0 to R0
    POPEQ {PC}                   @ If R8 = 0, restore
    PUSH {R8}			 @ store R8
    PUSH {R7}                    @ store R7
    SUB R7, R7, R8               @ subtract R8 from R7 and store it to R7
    BL _partitions               @ Branch to _partions
    POP {R7}			 @ restore value of R7
    POP {R8}			 @ restore R7
    PUSH {R0}			 @ restore R8
    SUB R8,R8, #1		 @ subtract one from R8 and put it in R8
    BL _partitions		 @ Branch to _partitions
    MOV R3, R0			 @ store value of R0 to R3
    POP {R0}			 @ restore R0
    ADD R0, R0, R3		 @ Add R3 to R0 and put value in R0
    POP {PC}			 @ return

_scanfone:

    PUSH {LR}                    @ store LR since scanf call overwrites
    SUB SP, SP, #4               @ make room on stack
    LDR R0, = format_str_one     @ R0 contains address of format string
    MOV R1, SP                   @ move SP to R1 to store entry on stack
    BL scanf                     @ call scanf
    LDR R0, [SP]                 @ load value at SP into R0
    ADD SP, SP, #4               @ restore the stack pointer
    POP {PC}                     @ return

_scanftwo:

    PUSH {LR}                    @ store LR since scanf call overwrites
    SUB SP, SP, #4               @ make room on stack
    LDR R0, = format_str_two     @ R0 contains address of format string
    MOV R1, SP                   @ move SP to R1 to store entry on stack
    BL scanf                     @ call scanf
    LDR R0, [SP]                 @ load value at SP into R0
    ADD SP, SP, #4               @ restore the stack pointer
    POP {PC}                     @ return

_print:

    POP {R8}			 @ Restore R8
    POP {R7}			 @ Restore R7
    PUSH {LR}                    @ store the return address
    LDR R0,= print_str           @ R0 contains formatted string address
    MOV R1,R1			 @ move the partion value back to register R1
    MOV R2,R7                    @ move the first scanned value to R2
    MOV R3,R8                    @ move the second scanned value to R3
    BL printf                    @ call printf
    POP {PC}			 @ return

_loop:

    B main			 @ Branch back to main with return

.data

format_str_one: .asciz   "%d"
format_str_two: .asciz   "%d"
print_str:      .asciz   "There are %d partitions of %d using integer up to %d\n"

