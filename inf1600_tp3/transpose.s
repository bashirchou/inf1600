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
        movl $0, %eax    /* Met la valeur de r dans eax */
        movl $0, %ecx    /* Met la valeur de c dans ecx */
        movl 16(%ebp), %edx    /* Met la valeur de matorder dans edx */
        jmp conditionBoucleLigne


conditionBoucleLigne:
        cmp %edx, %eax
        jl conditionBoucleColonne    /* r < matorder */
        jmp fin
conditionBoucleColonne:
        cmp %edx, %ecx
        jl boucleColonne    /* c < matorder */
        movl $0, %ecx    /* Remet la valeur de c a 0 */
        inc %eax  
        jmp conditionBoucleLigne

boucleColonne:

        movl %eax,-4(%ebp)    /* Enregistre le r dans la mémoire */
        movl %ecx,-8(%ebp)    /* Enregistre le c dans la mémoire */
        mul %edx       /* edx#eax  eax * source32 */
        add %eax, %ecx      /* c + r * matorder = %edx */
        movl %ecx, %edx

        movl 8(%ebp), %eax     /* Enregistre le pointeur inmatdata1 dans %eax */
        movl 12(%ebp), %ecx     /* Enregistre le pointeur outmatdata dans %ecx */
        push %ebx   /* Sauvegarde %ebx */

        movl %eax(%edx), %ebx  /* inmatdata[r + c * matorder] = %ebx  */
        movl %ebx, %ecx(%edx)   /* inmatdata[r + c * matorder] = outmatdata[c + r * matorder]  */

        movl -4(%ebp), %eax     /* Rétablir les données */
        movl -8(%ebp), %ecx
        pop %ebx
        movl 16(%ebp), %edx    /* Met la valeur de matorder dans edx */

        inc %ecx
        jmp conditionBoucleColonne

fin:
        mov %ebp, %esp  /* Enleve espace de r,c */
        leave          /* Restore ebp and esp */
        ret            /* Return to the caller */
