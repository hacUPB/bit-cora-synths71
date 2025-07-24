//10. Las posiciones de memoria RAM de 0 a 15 tienen los nombres simbólico R0 a R15. Escribe un programa en lenguaje ensamblador que guarde en R1 la operación 2 * R0.
@R0
D=M
D=D+D
@R1
M=D

//12. Implemente en ensamblador R4 = R1 + R2 + 69
@R1
D=M
@R2
D=D+M
@69
D=D+A
@R4
M=D

//13. Implementa en ensamblador: 




