1. Investiga

En C++, los std::vector son estructuras que gestionan memoria de manera dinámica en el heap. Se utilizan glm::vec3, que son equivalentes como contenedor de tres float (x, y, z).

El vector en sí es std::vector que se almacena como miembro de la clase ofApp, por lo tanto vive en la memoria asociada a esa instancia.

Los elementos que el vector guarda, es decir, glm::vec3 no se almacenan dentro del objeto directamente, sino que el vector reserva memoria en el heap para ellos. A medida que crece como cuando se hace push_back o se llena con nuevas posiciones, puede pedir más memoria al heap y mover los datos allí.

Cada glm::vec3 es un objeto pequeño que ocupa tres floats en memoria contigua, lo cual hace eficiente su acceso.

La gestión de memoria la maneja el propio std::vector: él se encarga de reservar, realocar y liberar la memoria automáticamente cuando se destruye el objeto.

2. Experimenta

Al ejecutarse el codigo se pueden distinguir claramente las diferentes zonas de memoria:

- Stack (pila de ejecución):

Variables locales como rayStart, rayEnd o intersectionPoint aparecen en el stack mientras la función se está ejecutando. Al terminar la función, esas variables desaparecen automáticamente.

- Heap (memoria dinámica):

El std::vector<glm::vec3> spherePositions se muestra en el depurador como un objeto que internamente guarda un puntero hacia memoria dinámica. Allí es donde se encuentran los elementos reales (glm::vec3). A medida que la cuadrícula de esferas cambia de tamaño, el vector solicita más memoria al heap para poder almacenar todos los puntos.

- Memoria global/estática:

Variables globales como sphereSelected o selectedSpherePosition se ubican en el segmento de memoria estática. El depurador confirma que se crean una sola vez al inicio del programa y permanecen allí durante toda la ejecución.

3. Documenta

Despues de haber probado el codigo y ejecutado se puede ver lo siguiente:

- El stack se usa para variables locales y temporales que solo viven mientras la función está activa. Esto se ve en parámetros y variables como rayStart, rayEnd o las que se declaran en la función generateGrid y en mousePressed.

- El heap se utiliza de manera indirecta a través de estructuras dinámicas como el std::vector<glm::vec3>. Este mecanismo permite manejar cientos de posiciones de esferas sin necesidad de reservar memoria fija, ya que el vector solicita y libera espacio en el heap según se necesite.

- La memoria global o estática aloja las variables globales sphereSelected y selectedSpherePosition y también mantiene con vida a los objetos miembro de la clase ofApp como el ofEasyCam cam y los parámetros de la onda. Estas variables permanecen durante toda la ejecución del programa.