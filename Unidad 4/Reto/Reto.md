Es una obra generativa donde el usuario “dibuja” trazos en movimiento con el mouse, y esos trazos caen lentamente como si fueran partículas de pintura líquida. Se combinan una lista enlazada para seguir el rastro del mouse, y una cola para representar gotas que caen desde esos pasos del mouse. La interacción genera trazos nuevos, mientras van cayendo del fondo del trazo goteras que bajan en la pantalla.

## Lista de los datos:

Lista enlazada:

- Al mover el mouse, se crean nodos que siguen su posición (igual que en el código original de la “serpiente”).

- La lista guarda un número limitado de nodos para evitar sobrecarga.

- Cada nodo representa un punto del trazo.

Cola:

- Por cada cierto número de frames, se encola una “gota” que representa una parte del trazo que se desprende y cae.

- Las gotas caen hacia abajo simulando gravedad.

- Cuando una gota sale de la pantalla, se desencola y se libera su memoria.

## Interacción:

- Mouse: genera el trazo al moverse.

- Tecla A: activa la caída de gotas desde el trazo (empieza a encolar).

- Tecla C: limpia la pantalla (vacía lista y cola).

- Tecla V: cambia el color de las gotas.

## Gestión de memoria:

- Todas las gotas y nodos se crean dinámicamente con new y se eliminan con delete.

- Se llama clear() en ambas estructuras cuando se reinicia o termina.

- Cada estructura tiene su destructor bien definido como en los ejemplos de clase.

## Exploración creativa:

Queremos un trazo que el usuario dibuja con el mouse así como pintura líquida y que del trazo vayan desprendiéndose goteras que caen imitando chorreados. Visualmente buscamos: fluidez, variación, y sensación de materia.

**Lista enlazada (LinkedList): controla el trazo como una secuencia de puntos ordenada. Esto me puede servir para:**

- Mantener el orden del rastro en tiempo real.

- Permitir fácil eliminación del primer punto si limitas longitud.

- Usamos update() tipo serpiente para propagar movimiento sin copiar grandes arreglos.

**Cola (DropQueue): modela gotas que caen en orden FIFO (las primeras que se desprenden son las primeras en caer). Ventajas:**

- Fácil desencolado cuando la gota sale de pantalla.

- Representa bien el comportamiento físico.

## Gestión de memoria:

Cada new debe tener un delete asociado, además de esto poner destructores importantes para que limpien el programa cuando se cierre y no gaste memoria y para terminar intentar poner un limite de la memoria que va a consumir. 

Para asegurarnos de que no haya fugas vamos a implementar clear().

# Rae1:

![alt text](<Captura de pantalla 2025-09-23 002023.png>)

En esta captura vemos el trazo normal al mover el mouse.

![alt text](<Captura de pantalla 2025-09-23 002225.png>)

En esta captura vemos las goteras activas y cayendo por el canvas, estas desaparecen cuando llegan hasta abajo y ademas solo caen las del final de la cola y en un numero controlado para no gastar mucha memoria.

![alt text](<Captura de pantalla 2025-09-23 002555.png>)

En esta captura cambio el color de las goteras que caen pero no del trazo normal, tiene varios colores en los que puede cambiar.

![alt text](<Captura de pantalla 2025-09-23 002515.png>)

En esta foto he intentado evidenciar cuando presiono la C que se limpian las goteras y el trazo y las hace aparecer de 0 en un punto aleatorio, no desaparece todo por completo sino que limpia lo que hay y vuelve a iniciar de 0.

# Rae2:

**Prueba del trazo**:

![alt text](<Captura de pantalla 2025-09-23 003207.png>)

Aquí pruebo el trazo normal moviendo el mouse, moviendolo durante unos segundos y viendo como se iba dibujando en el canvas, es decir, si muy rapido o muy lento.

**Prueba de las goteras**:

![alt text](<Captura de pantalla 2025-09-23 003530.png>)

Para probar esto active las goteras y mire como aparecen, en que momento empiezan a caer, que si desaparezcan al final y tambien miro el contador de goteras que hay que en este caso se llama drops, mirando esto y dejando el mouse quieto veo que genera un rango de entre 15 a 20 goteras que se va actualizando constantemente ya que las que caen se eliminan y vuelven a caer.

**Prueba del cambio de color**: 

![alt text](<Captura de pantalla 2025-09-23 003821.png>)

![alt text](<Captura de pantalla 2025-09-23 003833.png>)

Aquí dejando el mouse quieto, dejo el mouse quieto y cambio el color de las goteras varias veces para asegurarme que el color si cambie al presionar la tecla y cada vez a un color diferente.

**prueba del clear**:

![alt text](<Captura de pantalla 2025-09-23 004118.png>)

Para presionar el clear decidi dejarlo presionado constantemente y mire que la ultima posición en la que estuve antes de presionar la C y ahora donde tengo el mouse presionado se ven al mismo tiempo en el canvas ya que se esta limpiando constantemente al tener la C activa sin parar, ahí en la captura se logra ver una gotera en la mitad de la pantalla y luego donde tengo el puntero del mouse un poco más arriba ya que se borra muy rapido y solo queda la gotera.