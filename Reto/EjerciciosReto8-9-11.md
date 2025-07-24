8. 

1) En este programa: lee el valor de var1 y lo guarda en D, luego de esto ese valor lo suma con lo que hay en var2 y sigue dejando el resultado en D y para acabar guarda ese mismo resultado en var3.

2) Las variables dadas en el ejercicio son variables simbólicas como por ejemplo @var1 que son etiquetas que el ensamblador traduce a posiciones RAM a partir de la dirección 16. Según esto entonces seria var1=16, var2=17, var3=18.

9. 

1) Este programa inicializa un contador que es i y una suma que es sum, luego de esto le suma i a sum y terminando aumenta el valor de i por 1. 

2) Como se habia mencionado en el ejercicio 8, las variables se asignan automaticamente por el ensamblador desde la 16 en la RAM y en orden entonces i esta en RAM16 y sum en RAM17.

3) Para podes optimizar el codigo y que quede en solo 2 intrucciones podría funcionar algo como lo siguiente:

@i
M=M+1

Esto funciona porque con la segunda instrucción directamente incrementa el valor que hay en esa dirección entonces no hay necesidad de usar D.

11. 

1) 

 



