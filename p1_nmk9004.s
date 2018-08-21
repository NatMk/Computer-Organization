/******************************************************************************
* @Program 1
* simple calculator to calculate sum,differnce,product and max using keyboard input
* Natnael kebede ID:1001149004
******************************************************************************/

.global main
.func main

main:

    BL  _scannum1        /* scanf procedure with return for first int */
    MOV R4, R0           /* move return value R0 to argument register R4 */
    BL _char             /* branch to read the char procedure with return */
    MOV R6, R0           /* move return value R0 to argument register R6 */
    BL _scannum2         /* scanf procedure with return for second int */
    MOV R5, R0           /* move return value R0 to argument register R5 */
    BL _compare          /* checks the char input from the user */
    MOV R1, R0           /* move return value R0 to argument register R1 */
    BL _printVal         /* print value stored in R1 */
    B main               /* loop back to main for infinite loop */

_scannum1:

    PUSH {LR}            /* store LR since scanf call overwrites */
    SUB SP, SP, #4       /* make room on stack */
    LDR R0, = str_one    /* R0 contains address of format string */
    MOV R1, SP           /* move SP to R1 to store entry on stack */
    BL scanf             /* call scanf */
    LDR R0, [SP]         /* load value at SP into R0 */
    ADD SP, SP, #4       /* restore the stack pointer */
    POP {PC}             /* return */

_char:

    Mov R7, #3           /* Write syscall, 3 */
    Mov R0, #0           /* output stream to monitor, 0 */
    Mov R2, #1           /* read a single character */
    LDR R1, = read_char  /* store the character in data memory */
    SWI 0                /* execcute the system call */
    LDR R0, [R1]         /* move the character to the return register */
    AND R0, #0XFF        /* mask out all the lowest 8 bits */
    MOV PC, LR           /* return */

_scannum2:

    PUSH {LR}            /* store LR since scanf call overwrites */
    SUB SP, SP, #4       /* make room on stack */
    LDR R0, = str_two    /* R0 contains address of format string */
    MOV R1, SP           /* move SP to R1 to store entry on stack */
    BL scanf             /* branch to scanf */
    LDR R0, [SP]         /* load value at SP to R0 */
    ADD SP, SP, #4       /* restore the stack pointer */
    POP {PC}             /* return */

_compare:

   CMP R6, #'+'          /* compare against the char '+' */
   BEQ _add              /* branch to add calculation */
   CMP R6, #'-'          /* compare against the char '-' */
   BEQ _sub              /* branch to differnce calcualtion */
   CMP R6, #'*'          /* comapre against tje char '-' */
   BEQ _mul              /* branch to product calculation */
   CMP R6, #'M'          /* compare against the char 'M' */
   BEQ _Max              /* branch to Maximum calculation */

_add:

   MOV R0, R4           /* move return value at R4 to R0 */
   ADD R0, R5           /* add value at R5 with value at R0 */
   MOV PC, LR           /* return */

_sub:

   MOV R0, R4            /* move return value at R4 to R0 */
   SUB R0, R5            /* subtract value at R5 from value at R0 */
   MOV PC, LR            /* return */

_mul:

   MOV R0, R4            /* move return value at R4 to R0 */
   MUL R0, R5            /* multiply value at R5 with value at R0 */
   MOV PC, LR            /* return */

_Max:

  CMP R4,R5              /* compare R4 and R5 */
  BGE _checkmax          /* branch to check max if value is larger */
  MOV R0,R5              /* move return value at R5 to R0 */
  MOV R1, R0             /* move register RO to R1 */
  LDR R0, = print_str    /* string at label print_str */
  BL printf              /* call printf */
  B main                 /* loop back to main */

_checkmax:

  MOV R0, R4              /* move return value at R4 to R0 */

_printVal:

    MOV R8, LR            /* store LR since printf call overwrites */
    LDR R0, = print_str   /* string at label print_str */
    MOV R1, R1            /* restore R1 */
    BL printf             /* call printf */
    MOV PC, R8            /* return */

.data

  str_one:        .asciz      "%d"
  str_two:        .asciz      "%d"
  print_str:      .asciz      "%d\n"
  read_char:      .ascii      " "

