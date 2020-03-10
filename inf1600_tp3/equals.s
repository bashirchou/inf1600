.globl matrix_equals_asm

matrix_equals_asm:
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
        jmp equal
conditionBoucleColonne:
        movl 16(%ebp), %edx  /* Met la valeur de matorder dans %edx */
        movl -8(%ebp), %ecx     /* Met la valeur de c dans %ecx  (COlonne) */
        cmp %edx, %ecx
        jl boucleColonne    /* c < matorder */
        movl $0, -8(%ebp)    /* Remet la valeur de c a 0 (colonne) */
        inc -4(%ebp)      /* ++r (colonne) */
        jmp conditionBoucleLigne

boucleColonne:
        movl 16(%ebp), %eax  /* Met la valeur de matorder dans %eax */
        movl -4(%ebp), %ecx     /* Met la valeur de r dans %ecx  (ligne) */
        movl $0, %edx   /* Précaution comme montrer par le prof */
        mul %ecx       /* edx#eax <- eax * %ecx */

        movl -8(%ebp), %ecx     /* Met la valeur de c dans %ecx  (colonne) */
        add %eax, %ecx      /* %ecx <- (r * matorder) + c */

        movl -8(%ebp), %eax  /* Met la valeur de c dans %eax  (colonne)*/
        movl (%ecx,%eax,4),%ecx  /* Enregistre le pointeur de inmatdata1 dans %eax */
        movl (%ecx,%eax,4),%edx /* Enregistre le pointeur de inmatdata2 dans %ecx */

        cmp %ecx, %edx   /* inmatdata1[c + r * matorder] != inmatdata2[c + r * matorder]  */
        jne notEqual 

        inc -8(%ebp)    /* ++c  */
        jmp conditionBoucleColonne
equal:
        movl $1, %eax
        jmp fin
notEqual:
        movl $0, %eax
        jmp fin
fin:
        mov %ebp, %esp  /* Enleve espace de r,c */
        leave          /* Restore ebp and esp */
        ret            /* Return to the caller */