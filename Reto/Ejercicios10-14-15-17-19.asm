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
@0
D=M
@1
D;JGE
M=M-1

//14. Implementa en ensamblador: R4 = RAM[R1]

@R1     
A=M     
D=M     
@R4    
M=D     

//15. Implementa en ensamblador el siguiente problema. En la posición R0 está almacenada la dirección inicial de una región de memoria. En la posición R1 está almacenado el tamaño de la región de memoria. Almacena un -1 en esa región de memoria.
@0
D=A
@16        
M=D
(LOOP)
@16
D=M
@R1
D=D-M
@EXIT
D;JGE      
@16
D=M
@R0
A=M
A=A+D      
M=-1       
@16
M=M+1      
@LOOP
0;JMP

//17. if ( (D - 7) == 0) goto a la instrucción en ROM[69]
@7
D=D-A      
@69
D;JEQ      

//19. Implementa un programa en lenguaje ensamblador que dibuje el bitmap que diseñaste en la pantalla solo si se presiona la tecla “d”.
    @KBD        
    D=M         
    @100        
    D=D-A       
    @SKIPDRAW   
    D;JNE
    
    //Aquí deberia estar el codigo del dibujo.       













