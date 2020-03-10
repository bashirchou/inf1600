.globl matrix_transpose_asm

matrix_transpose_asm:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        /* Write your solution here */
        movl 8(%ebp), %ecx    /* Met le pointeur de matrice dans registre */
        movl 12(%ebp), %edx    /* Met le pointeur de retour dans un registre*/

        movl (%ecx), %ecx   /* Récolte la valeurs de la matrice input */
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
