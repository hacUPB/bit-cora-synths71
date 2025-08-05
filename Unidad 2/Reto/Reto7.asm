//7. Traduce este programa a lenguaje ensamblador:
//int var = 10;
//int bis = 5;
//int *p_var;
//p_var = &var;
//bis = *p_var;//

@10
D=A
@VAR
M=D

@5
D=A
@BIS
M=D

@VAR
D=A
@p_var
M=D
@P_VAR
A=M
D=M
@BIS
M=D
