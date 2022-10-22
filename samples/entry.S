.equ reg_size, 0x8

    .section .text.entry
    .align 2
    .globl _traps 
_traps:
    # YOUR CODE HERE
    # -----------

        # 1. save 32 registers and sepc to stack

        csrw sscratch, sp 
        
        addi sp, sp, -32*reg_size

        sd x1 ,  0*reg_size(sp)
        sd x3 ,  2*reg_size(sp)
        sd x4 ,  3*reg_size(sp)
        sd x5 ,  4*reg_size(sp)
        sd x6 ,  5*reg_size(sp)
        sd x7 ,  6*reg_size(sp)
        sd x8 ,  7*reg_size(sp)
        
        csrr t0, sepc
        sd t0,  31*reg_size(sp)

        csrrw t0, sscratch, x0
        sd t0,   1*reg_size(sp)

    # -----------

        # 2. call trap_handler
        csrr a0, scause
        csrr a1, sepc
        mv a2, sp

        call trap_handler

    # -----------

        # 3. restore sepc and 32 registers (x2(sp) should be restore last) from stack
        ld t0, 31*reg_size(sp)
        csrw sepc, t0

        ld x1 ,  0*reg_size(sp)
        ld x3 ,  2*reg_size(sp)
        ld x4 ,  3*reg_size(sp)
        ld x5 ,  4*reg_size(sp)
        ld x6 ,  5*reg_size(sp)
        ld x7 ,  6*reg_size(sp)
        ld x8 ,  7*reg_size(sp)

        ld x2 ,  1*reg_size(sp)

    # -----------

        # 4. return from trap
        sret

    # -----------