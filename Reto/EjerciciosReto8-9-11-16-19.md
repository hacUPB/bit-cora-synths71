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

1) Este programa cuenta hacia atrás desde 1000 hasta 0 usando una variable i, y cuando i llega a cero sale del ciclo.

2) i esta en la memoria de la RAM y estaria en la direccion de la RAM 16 ya que es una variable que se declara.

3) Están en la ROM , y están en las primeras posiciones: por ejemplo, @1000 puede estar en ROM0, y D=A en ROM1.

4) La primera instrucción es @1000 y Está en la ROM, que es donde se cargan las instrucciones del programa Y está en ROM0.

5) CONT y LOOP son etiquetas que se usan como puntos de salto en el programa. LOOP marca el inicio del ciclo mientras que CONT es donde se salta cuando la condición i == 0 se cumple.

6) La diferencia es que i es una variable que normalmente se guarda en la RAM mientras que CONT es una etiqueta de salto que se guarda en la ROM y es en si una instrucción.

16. 

1) Este programa crea un arreglo de 10 enteros, inicializa una variable sum en 0 y luego recorre el arreglo arr sumando lo que tiene a sum. Al final sum contiene la suma de los 10 elementos del arreglo.

2) 







19. Este codigo crea un efecto visual en el simulador de Nand2Tetris usando la ventana screen 
 



