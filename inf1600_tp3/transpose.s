.globl matrix_transpose_asm

matrix_transpose_asm:
        push %ebp      /* Save old base pointer */
        mov %esp, %ebp /* Set ebp to current esp */

        /* Write your solution here
        8(%ebp) = param1
        12(%ebp) = param2
        16(%ebp) = param3
        */
        sub $8, %esp /* Fait de L'espace pour r et c */
        movl $0, -4(%ebp)    /* Met la valeur de r dans memoire  (ligne) */
        movl $0, -8(%ebp)    /* Met la valeur de c dans memoire (colonne)*/
        jmp conditionBoucleLigne


conditionBoucleLigne:
        movl 16(%ebp), %edx  /* Met la valeur de matorder dans %edx */
        movl -4(%ebp), %eax     /* Met la valeur de r dans %eax  (ligne) */
        cmp %edx, %eax
        jl conditionBoucleColonne    /* r < matorder */
        jmp fin
conditionBoucleColonne:
        movl 16(%ebp), %edx  /* Met la valeur de matorder dans %edx */
        movl -8(%ebp), %ecx     /* Met la valeur de c dans %ecx  (COlonne) */
        cmp %edx, %ecx
        jl boucleColonne    /* c < matorder */
        movl $0, -8(%ebp)    /* Remet la valeur de c a 0 (colonne) */
        add $1, -4(%ebp)      /* ++r (colonne) */
        jmp conditionBoucleLigne

boucleColonne:
        movl 16(%ebp), %eax
        movl -8(%ebp), %edx
        mul %edx
        addl -4(%ebp), %eax

        movl 8(%ebp), %ecx
        movl (%ecx,%eax,4),%ecx

        movl 16(%ebp), %eax
        movl -4(%ebp), %edx
        mul %edx
        addl -8(%ebp), %eax

        movl 12(%ebp), %edx
        movl %ecx, (%edx,%eax,4)

        add $1, -8(%ebp)    /* ++c  */
        jmp conditionBoucleColonne
fin:
        mov %ebp, %esp  /* Enleve espace de r,c */
        leave          /* Restore ebp and esp */
        ret            /* Return to the caller */
