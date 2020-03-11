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
        jae conditionBoucleColonne    /* r < matorder */
        jmp fin
conditionBoucleColonne:
        movl 16(%ebp), %edx  /* Met la valeur de matorder dans %edx */
        movl -8(%ebp), %ecx     /* Met la valeur de c dans %ecx  (COlonne) */
        cmp %edx, %ecx
        jae boucleColonne    /* c < matorder */
        movl $0, -8(%ebp)    /* Remet la valeur de c a 0 (colonne) */
        add $1, -4(%ebp)      /* ++r (colonne) */
        jmp conditionBoucleLigne

boucleColonne:
        movl 16(%ebp), %eax  /* Met la valeur de matorder dans %eax */
        movl -8(%ebp), %ecx     /* Met la valeur de c dans %ecx  (colonne) */
        movl $0, %edx   /* Précaution comme montrer par le prof */
        mul %ecx       /* edx#eax <- eax * %ecx */

        movl -4(%ebp), %ecx     /* Met la valeur de r dans %ecx  (ligne) */
        add %eax, %ecx      /* %ecx <- (c * matorder) + r */

        
        movl 8(%ebp), %edx  /* Met la valeur de debut de inmatdata*/
        movl (%edx,%ecx,4), %edx  /* Enregistre la valeur de inmatdata a la bonne position dans %edx */
        
        /* -------------- */
        
        movl 16(%ebp), %eax  /* Met la valeur de matorder dans %eax */
        movl -4(%ebp), %ecx     /* Met la valeur de r dans %ecx  (ligne) */
        movl $0, %edx   /* Précaution comme montrer par le prof */
        mul %ecx       /* edx#eax <- eax * %ecx */

        movl -8(%ebp), %ecx     /* Met la valeur de c dans %ecx  (colonne) */
        add %eax, %ecx      /* %ecx <- (r * matorder) + c */

        movl 12(%ebp), %eax  /* Met la valeur de debut de outmatdata*/
        movl  %edx, (%eax, %ecx,4)  /* outmatdata[c + r * matorder] = inmatdata[r + c * matorder];  */

        add $1, -8(%ebp)    /* ++c  */
        jmp conditionBoucleColonne
fin:
        mov %ebp, %esp  /* Enleve espace de r,c */
        leave          /* Restore ebp and esp */
        ret            /* Return to the caller */
