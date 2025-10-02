1. Actividad 1:

**Entiende la aplicación: comienza explorando detenidamente cómo funciona el programa. Usa un un modelo del lenguaje como ChatGPT y el depurador para que verifiques las explicaciones que te propone ChatGPT. Puedes escribir el prompt: quiere entender de manera muy detallada el siguiente programa escrito en C++ y el openframeworks. Luego le das el código. Ve preguntando lo que no entiendas. recuerda ir usando al mismo tiempo el depurador de visual studio.**

2. Actividad 2:

**Dile a ChatGPT que te genere preguntas para verificar si entiendes cómo funciona el programa. Trata de verificar tus hipótesis usando el depurador y luego con las conclusiones del experimento responde la pregunta de ChatGPT. Continúa con este proceso hasta que estés seguro de que entiendes cómo funciona el programa.**

3. Actividad 3:

**¿Qué es una lista enlazada y en qué se diferencia de un arreglo en cuanto a la forma en que los elementos están almacenados en la memoria?**

La lista enlazada es la colección de nodos donde cada nodo contiene dato (aquí x,y) y un puntero al siguiente nodo (next). Los elementos no están contiguos en memoria necesariamente; cada nodo puede vivir en cualquier lugar del heap, el arreglo es la colección de elementos almacenados contiguamente en memoria.

La diferencia principal entre estos es es que el arreglo se guarda en el stack mientras que los nodos en el heap.

4. Actividad 4:

**Al observar el código de una lista enlazada en C++, ¿Cómo crees que se vinculan los nodos entre sí? ¿Qué estructura se utiliza para lograr esta conexión?**

Cada Node tiene un puntero Node* next. La vinculación se logra asignando current->next = newNode al insertar al final, o ajustando prev->next = current->next al eliminar. La estructura usada es una lista enlazada simple (singly linked list) porque cada nodo apunta solo al siguiente.

5. Actividad 5:

**¿Cómo se gestiona la memoria en una lista enlazada? Investiga cómo se crea y se destruye un nodo en memoria utilizando el operador new y delete en C++.**

Se crea con: Node* n = new Node(x,y); solicita memoria en el heap y construye el objeto, y se destruye con delete current; llama al destructor de Node y libera la memoria al allocator.

6. Actividad 6:

**Considerando la estructura de una lista enlazada, ¿qué ventajas ofrece en comparación con un arreglo cuando se trata de insertar o eliminar elementos en posiciones intermedias?**

Con la lista enlazada no requiere mover bloques grandes en memoria, mientras que con el arreglo insertar/eliminar en medio requiere desplazar elementos y posiblemente realocar si no hay espacio.

7. Actividad 7:

**En el código presentado, ¿Cómo se asegura que no haya fugas de memoria? ¿Qué papel juega el destructor en la clase LinkedList?**

El código previene fugas llamando a clear tanto manualmente presionando c como desde LinkedList que es el destructor.

Cuando el objeto LinkedList sale de alcance o la aplicación termina, ~LinkedList se ejecuta y llama clear para delete todos los nodos pendientes. Esto asegura que la memoria solicitada por new sea liberada.

8. Actividad 8:

**¿Qué sucede en la memoria cuando se invoca el método clear() en una lista enlazada? Explica paso a paso cómo se liberan los recursos.**

1) Node* current = head; que hace que current apunta al primer nodo.

2) En ciclo while (current != nullptr):

- Se guarda Node* nextNode = current->next; (enlace al siguiente).

- delete current; → se libera memoria del nodo apuntado por current.

- current = nextNode; → avanzar al siguiente nodo.

3) Al terminar, head = nullptr; tail = nullptr; size = 0;.

Para concluir cada bloque de memoria asignado por new para cada nodo es liberado con delete, y la lista queda vacía. Si un delete falla o se omite, quedaría fuga.

9. Actividad 9: 

**Explica cómo cambia la estructura en memoria de una lista enlazada al agregar un nuevo nodo al final de la lista. ¿Cómo afecta esto al rendimiento de la lista enlazada?**

Se crea new Node(x,y) en heap. Si tail != nullptr, se hace tail->next = newNode; tail = newNode;. Si la lista estaba vacía (tail == nullptr), head = tail = newNode. size++.

Si mantienes puntero a tail, agregar al final es O(1). Si no lo mantuvieras y tuvieras que recorrer desde head para encontrar el final, sería O(n). En este código el tail sí está guardado entonces inserción final O(1).

10. Actividad 10:

**Analiza una situación en la que utilizar una lista enlazada sería más ventajoso que utilizar un arreglo. Justifica tu respuesta considerando la gestión de memoria y las operaciones de inserción y eliminación.** 

una simulación en tiempo real donde constantemente aparecen y desaparecen entidades que pueden ser por ejemplo, partículas, enemigos, objetos en un generador procedural, etc. Y la colección cambia mucho con inserciones y eliminaciones frecuentes en posiciones arbitrarias.

Justificación: evita costosos desplazamientos de memoria y reubicaciones de arrays dinámicos; permite liberar memoria inmediatamente con delete.

11. Actividad 11:

**Después de estudiar el manejo de memoria en listas enlazadas, ¿Cómo aplicarías este conocimiento para diseñar una estructura de datos personalizada para una aplicación creativa? ¿Qué aspectos considerarías para asegurar la eficiencia y evitar fugas de memoria?**

Al diseñar una estructura de datos personalizada usando listas enlazadas para una aplicación creativa, es clave pensar en la eficiencia, manteniendo punteros como head y tail para inserciones rápidas en ambos extremos y usando, si hace falta, un pool de objetos que reduzca el costo de muchas asignaciones. En cuanto a la seguridad, conviene inicializar punteros en nullptr, limpiarlos tras liberar memoria y encapsular el acceso mediante funciones claras de agregar o eliminar, evitando exponer los punteros internos. También es útil implementar iteradores seguros o usar un patrón de marcado para evitar problemas al recorrer mientras se eliminan nodos. Finalmente, se debe validar el diseño con profiling para comprobar fugas y, si la aplicación es concurrente, proteger la estructura con alguna especie de candado.

12. Actividad 12:

**Reflexiona sobre las diferencias en la gestión de memoria entre C++ y un lenguaje con recolección de basura automática como C#. ¿Qué ventajas y desafíos encuentras en la gestión explícita de memoria en C++ al trabajar con estructuras de datos?**

En C++, la gestión de memoria es explícita con new y delete, lo que da la ventaja de tener un control total sobre cuándo y cómo se liberan los recursos. Esto permite un uso más eficiente y determinista, muy útil en estructuras de datos que requieren optimización fina. Sin embargo, este control trae desafíos: es fácil cometer errores como fugas de memoria, dangling pointers o incluso un double delete, lo que aumenta la complejidad del desarrollo.

En cambio, en C# el recolector de basura (GC) libera memoria automáticamente cuando los objetos ya no se usan. La gran ventaja es que se reducen los errores comunes y el desarrollo se vuelve más rápido y seguro, pero como desventaja se pierde el control preciso sobre el momento exacto de liberación, lo que puede introducir overhead y comportamientos menos deterministas.

13. Actividad 13:

**Imagina que estás optimizando una pieza de arte generativo que usa listas enlazadas para representar elementos en movimiento. ¿Qué consideraciones tomarías en cuenta para garantizar que la gestión de la memoria sea eficiente y que no ocurran fugas de memoria?**

* Evitar crear/borrar cada frame: reciclar nodos (object pool) para evitar overhead de new/delete masivo.

* Marcar para eliminación: marcar nodos para eliminar y limpiarlos en momentos controlados (evita problemas si se está iterando).

* Thread-safety: si la generación usa varios hilos, sincronizar.

* Profiling: medir uso de memoria y FPS para identificar cuellos de botella.

* Destructor y clear robustos: siempre limpiar en el destructor y tener una función de limpieza segura clear() que sea idempotente (puede llamarse varias veces sin crash).




