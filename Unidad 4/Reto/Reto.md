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
