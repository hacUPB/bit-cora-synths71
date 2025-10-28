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

Un uniform es una variable especial que se declara dentro de un shader, así como por ejemplo en shader.frag o shader.vert, luego que recibe información enviada desde el programa principal en C++. Esto significa que en cada frame, el shader recibe el tiempo total que ha pasado desde que comenzó el programa, y puede usarlo para animar cosas como movimiento, color o distorsión.

**¿Cómo funciona el código de aplicación, los shaders y cómo se comunican estos?**

El código en C++ se encarga de enviar datos a los shaders, como el tiempo, la posición del mouse o las texturas. El vertex shader usa esa información para mover los vértices de la malla, y el fragment shader decide el color de cada píxel. Todo se comunica por medio de uniforms que son variables que vienen del programa, varyings que es lo que pasa del vertex al fragment shader y atributos que son datos propios de cada vértice como posición o color.

# Actividad 4:

Para esta actividad podesmo usar el ejemplo 3 de las lista de ejemplos, es decir, 03_simpleShaderInteraction.

Esta ejemplo se ve de la siguiente forma: 

![alt text](<Captura de pantalla 2025-10-28 082101.png>)

Dependiendo de donde pongamos la bola con el mouse, cambia el color de azul a rosado y puede haber morado que es el punto medio

![alt text](<Captura de pantalla 2025-10-28 085930.png>)

**¿Qué hace el código del ejemplo?**

El código crea un plano, que se puede ver como una cuadricula, que cubre toda la pantalla, y luego usa un shader para modificar su apariencia en función de la posición del mouse.

Además de esto el programa calcula la posición del mouse respecto al centro de la ventana, luego envía esa posición como una variable al shader.

También envía un color mezclado entre magenta y azul, dependiendo de la posición horizontal del mouse.

**¿Cómo funciona el código de aplicación, los shaders y cómo se comunican estos?**

















