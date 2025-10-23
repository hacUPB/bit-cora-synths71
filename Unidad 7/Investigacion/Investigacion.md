# Actividad 1:

**¿Qué son los vértices?**

El renderizado de un ofMesh comienza con búferes de vértices en la CPU que se llenan con matrices de atributos de vértices, como colores, posiciones y coordenadas de texturas. Luego estos atributos se usan como los datos para hacer los vertices. 

**¿Con qué figura geométrica se dibuja en 3D?**

La figura que se usa es el triangulo. 

**¿Qué es un shader?**

Esto es un programa que recibe como entrada los valores variables generados por el vertex shader e interpolados por el rasterizador, además de esto genera valores de color y profundidad que se dibujan en el framebuffer.

**

# Actividad 2:

El ejemplo 1 de los shaders se ve de la siguiente manera:

![alt text](<Captura de pantalla 2025-10-23 083959.png>)

Lo que pasa al cambiar el codigo como piden en el ejemplo de la actividad es que sale la pantalla en blanco

![alt text](<Captura de pantalla 2025-10-21 093322.png>)

**¿Cómo funciona?**

El programa carga un shader, activa el shader y luego dibuja un rectángulo y la GPU usa el código de los shaders para decidir cómo se verá cada píxel del rectángulo.

**¿Qué resultados obtuviste?**

Se queda sin shader, es decir que se pone el triangulo blanco, esto porque el triangulo se dibuja sin usar la GPU programable, en si no se activa el shader.

**¿Estás usando un vertex shader?**

En el programa si se usan los vertex shader, esto porque el vertex shader se ejecuta una vez por cada vértice del triangulo y define su posición en pantalla.

**¿Estás usando un fragment shader?**

El fragment shader se ejecuta una vez por cada píxel del triangulo y define el color final que se muestra en la pantalla ,entonces si se usa.

**Analiza el código de los shaders. ¿Qué hace cada uno?**

El vertex shader transforma las coordenadas del rectángulo y pasa información al fragment shader, luego el fragment shader recibe esa información y calcula el color final de cada píxel.

# Actividad 3:

Para la actividad 3 usamos el ejemplo 2 de ls shaders ya que enseña a pasar variables desde la CPU al shader para alterar vértices.

![alt text](<Captura de pantalla 2025-10-23 092041.png>)

![alt text](<Captura de pantalla 2025-10-23 092055.png>)

Además de esto, uso el ejemplo 4 ya que puede funcionar como evidencia adicional de uniforms porque se pasa la textura como uniform.

![alt text](<Captura de pantalla 2025-10-23 092421.png>)

**¿Qué es un uniform?**










