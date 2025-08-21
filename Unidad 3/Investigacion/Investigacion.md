1. Actividad 1:

Se crea una esfera en la pantalla que sale al ejecutar el programa, de color blanco, que sigue el puntero del mouse dentro de esa pantalla.

2. Actividad 2:

(1) ¿Qué fue lo que incluimos en el archivo .h?

Se definieron en la clase ofApp las funciones del setup, update y draw. 2 funciones que sirven para el mouse y otras 2 para las posiciones de las esferas y el de el color de las esferas.

(2) ¿Cómo funciona la aplicación?

Cada vez que mueves el mouse, se guarda su posición y se dibuja un círculo ahí; cuando haces clic, cambia el color de esos círculos. No se mueven las esferas, solo se van creando nuevas en cada posición del mouse.

(3) ¿Qué hace la función mouseMoved?

Agrega una nueva posición del mouse al vector de partículas y elimina la más antigua si ya hay más de 100.

(4) ¿Qué hace la función mousePressed?

Cambia el color de las partículas a uno aleatorio cada vez que haces clic.

(5) ¿Qué hace la función setup?

Configura el fondo negro y pone el color inicial de las partículas en blanco.

(6) ¿Qué hace la función update?

Actualmente no hace nada, pero es donde se pondría lógica que se actualiza cada frame.

(7) ¿Qué hace la función draw?

Dibuja un círculo de color en cada una de las posiciones guardadas en el vector de partículas.

3. Actividad 3: 

La función setup() se ejecuta al inicio del programa y se encarga de configurar el fondo de la ventana en negro (ofBackground(0)) y establecer el color inicial de las partículas como blanco (particleColor = ofColor::white).

La función update() en este caso no realiza ninguna acción, pero se ejecuta constantemente en cada frame y sirve normalmente para actualizar lógica o animaciones, si existieran.

La función draw() es la que se encarga de dibujar en la ventana. Recorre todas las posiciones almacenadas en el vector particles, y para cada una de ellas establece el color actual con ofSetColor(particleColor) y luego dibuja un círculo de radio 50 en esa posición usando ofDrawCircle(pos.x, pos.y, 50).

La función mouseMoved(int x, int y) se ejecuta cada vez que se mueve el mouse dentro de la ventana. Guarda la posición actual del puntero como un nuevo vector ofVec2f(x, y) y lo agrega al final del vector particles. Si hay más de 100 partículas, elimina la más antigua usando particles.erase(particles.begin()), para que la lista no crezca indefinidamente.

La función mousePressed(int x, int y, int button) se activa cuando se hace clic dentro de la ventana, y cambia el color de las partículas a uno aleatorio. Lo hace generando valores aleatorios entre 0 y 255 para rojo, verde y azul usando ofRandom(255).

- (Experimento) 

En vez de cambiar solo el color cuando se hace clic con el mouse, ahora vamos a hacer que también se cambie el tamaño del círculo al azar. Para esto, vamos a usar una variable que ya tenemos (como ejemplo, el color), y la vamos a usar de forma creativa para simular un cambio sin agregar nuevas variables.

- (Resultado) 

Con este cambio, cada vez que se hace clic, el programa genera un nuevo color aleatorio y también un nuevo tamaño aleatorio para los círculos. En vez de agregar una nueva variable para el tamaño, reutilizamos el canal alfa del color (a) para almacenar el radio. Esto demuestra cómo se puede experimentar sin agregar variables nuevas, solo modificando el comportamiento de las que ya existen.

4. Actividad 4: 

Ver videos

5. Actividad 5: 

(1) ¿Cuál es la definición de un puntero?

Un puntero es una variable que almacena la dirección de memoria de otra variable u objeto en vez de su valor.

(2) ¿Dónde está el puntero?

En el código están en el vector: vector<Sphere*> spheres; y en la variable: Sphere* selectedSphere;.

(3) ¿Cómo se inicializa el puntero?

Se inicializa con nullptr en el setup() y también cuando se crean esferas con new Sphere.

(4) ¿Para qué se está usando el puntero?

Se usa para manejar dinámicamente las esferas y permitir seleccionar una en específico para moverla.

(5) ¿Qué es exactamente lo que está almacenado en el puntero?

El puntero almacena la dirección de memoria donde está guardado el objeto Sphere.

6. Actividad 6:

El problema del codigo es que la esfera se mantiene pegada al puntero del mouse, Entonces una vez se hace clic en una esfera, se queda pegada al mouse constantemente.

Hay que agregar un método mouseReleased en la clase ofApp.cpp y allí poner selectedSphere = nullptr;. Con esto cuando se hace clic, la esfera deja de seguir al mouse.

7. Actividad 7:

(1) Cuando presionás “c”, se crea una esfera local en el stack y se guarda su dirección en el vector, pero cuando sale de la función la esfera desaparece, dejando un puntero inválido en globalVector.

(2) 

- ¿Qué sucede cuando presionas la tecla “c”?

Cuando presionás la tecla “c”, se crea un nuevo objeto Sphere en el heap con new, y se guarda su dirección en el vector globalVector. Como está en el heap, el objeto no desaparece al salir de la función, entonces sí se mantiene vivo y lo podés dibujar o acceder sin problema.

- ¿Por qué ocurre esto?

Esto ocurre porque los objetos creados con new en el heap permanecen en memoria hasta que se liberen manualmente con delete. A diferencia de los objetos locales en el stack, que se destruyen automáticamente al salir de la función, los objetos en el heap siguen existiendo y el puntero en el vector apunta a un objeto válido.

