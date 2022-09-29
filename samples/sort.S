# Bubble Sort
.data
v:   
    .word 12,13,6,9,1,4,3,10,8

.text
sort:
    addi sp,sp,-20
    sw   ra,16(sp)
    sw   s7,12(sp)
    sw   s6,8(sp)
    sw   s4,4(sp)
    sw   s3,0(sp)
    li   a1,9        # n = 9
    li   s3,0        # i = 0
    la   a0,v        # a0 = address of v
    mv   s5,a0       # s5 = v   
    mv   s6,a1       # s6 = n
loop1:
    bge  s3,s6,exit1 # if i >= n, goto exit1
    addi s4,s3,-1    # else j = i - 1
loop2:
    blt  s4,x0,exit2 # if j < 0, goto exit2
    slli t0,s4,2     # t0 = j*4, word
    add  t0,s5,t0    # t0 = v+j*4
    lw   t1,0(t0)    # t1 = v[j]
    lw   t2,4(t0)    # t2 = v[j+1]
    ble  t1,t2,exit2 # if v[j] <= v[j+1], then goto exit2
    mv   a0,s5       # else, a0 = v, for swap
    mv   a1,s4       # a1 = j, for swap
    jal  ra,swap
    addi s4,s4,-1    # j=j-1
    j    loop2
exit2:
    addi s3,s3,1     # i=i+1
    j    loop1
exit1:
    lw   s3,0(sp)
    lw   s4,4(sp)
    lw   s6,8(sp) 
    lw   s7,12(sp)  
    lw   ra,16(sp) 
    addi sp,sp,20   
    jal  x0,exit
swap:
    slli t0,a1,2
    add  t0,a0,t0  # v + k
    lw   t1,0(t0)  # t1 = v[k]
    lw   t2,4(t0)  # t2 = v[k+1]
    sw   t2,0(t0)  # v[k] = t2
    sw   t1,4(t0)  # v[k+1] = t0
    jalr  x0,0(ra) # go back
exit:
