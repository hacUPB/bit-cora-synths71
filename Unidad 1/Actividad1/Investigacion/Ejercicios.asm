 //RAM = 250
 @250
 D=A
 @200
 M=D
 
 @200
 D=M
 @100
 M=D

 //RAM[3] = RAM [3] - 15
 @250
 D=A
 @200
 M=D

 @15
 D=A
 @3
 M=M-D

 RAM[2] = RAM[0] + RAM[1] + 17
 @0
 D=M
 @1
 D=D+M
 @17
 D=D+A
 @2
 M=D

 Ejercicios con 0
 @100
 D=A
 @3
 D=M-D