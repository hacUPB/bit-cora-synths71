@6
D = A
@a
M = D        

@9
D = A
@b
M = D        

@RET_FROM_SUMA
D = A
@ret
M = D

@SUMA
0;JMP

(RET_FROM_SUMA)
@result
D = M
@c
M = D        

@END
0;JMP

(SUMA)
@a
D = M
@b
D = D + M
@result
M = D

@ret
A = M
0;JMP

(END)
