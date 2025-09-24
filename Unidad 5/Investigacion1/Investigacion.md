# Sesión 1: la naturaleza de los objetos en C++

## Introducción a los Objetos

**¿Qué representa la clase Particle?**

La clase Particle representa una plantilla o modelo para crear partículas en un programa. Define dos cosas principales:

- Atributos (x y y), que representan la posición de la partícula en un espacio 2D.

- Comportamiento a través del método move(), que permite modificar la posición.

En términos de programación orientada a objetos, Particle encapsula tanto los datos como las acciones que se pueden hacer con esos datos. Se puede ver por asi decirlo como un espacio o plano para construir objetos que se comportan como particulas móviles. 

**¿Cómo interactúan sus atributos y métodos?**

Los atributos y métodos de Particle están conectados. Cuando se llama al método move() en un objeto Particle, ese método modifica directamente los atributos internos (x y y) del objeto que lo invoca, el metodo en si es el siguiente:

```cpp
void move(float dx, float dy) {
    x += dx;
    y += dy;
}
```
Esto ocurre gracias al puntero oculto this, que le permite al método acceder a los atributos del objeto específico (en este caso, p1) sobre el que se llamó.

**Prompt para ChatGPT: explícame en detalle qué es un objeto en C++ y cómo se relaciona con una clase. Usa el ejemplo de una clase Particle con atributos x y y y un método move.**

En C++, un objeto es una instancia concreta de una clase. Es decir, cuando defines una clase, no estás creando algo que exista en memoria todavía, solo estás describiendo cómo deberían ser los objetos: qué datos tendrán y qué operaciones podrán hacer, lo siguiente quiere decir entonces:

- Una clase es como un molde o plano.

- Un objeto es una cosa real construida con ese molde, que vive en la memoria y puede hacer cosas.

*Ejemplo con Particle*:

```cpp
class Particle {
public:
    float x, y; // Atributos que representan posición
    void move(float dx, float dy) {
        x += dx;
        y += dy;
    }
};
```

1. ¿Qué hace esta clase?

- Define un tipo llamado Particle.

- Cada Particle tiene dos atributos (x e y) que representan su posición en un espacio 2D.

- Tiene un método llamado move() que permite modificar su posición.

2. ¿Cómo se crea un objeto a partir de esta clase?

```cpp
Particle p1; // Creamos un objeto llamado p1
```

Ahora p1 es un objeto real que ocupa espacio en la memoria y tiene:

Su propio x

Su propio y

Y puede usar el método move así:

````cpp
p1.move(3.0f, 2.0f); // Cambia los valores de x e y de ese objeto
````

*¿Cómo se relaciona un objeto con una clase?*:

La clase es una definición general. Describe los atributos y comportamientos comunes a todos los objetos de ese tipo. La clase no ocupa memoria por sí sola, excepto en casos especiales como métodos estáticos.

El objeto, por otro lado, es una instancia individual de la clase. Cada objeto tiene su propia copia de los atributos definidos en la clase y utiliza los métodos de la clase para operar sobre sus propios datos.

## Explorando la memoria

![alt text](<../Evidencias1/Captura de pantalla 2025-09-18 092346.png>)




# Sesión 2: ubicación en memoria de datos y métodos

## Análisis de la estructura de una clase

**¿Dónde se almacenan los datos y métodos de una clase en C++ en la memoria? Explica el concepto de vtable y cómo se relaciona con los métodos virtuales.**

Los datos los cuales se les podría conocer como los atributos se guardan dependiendo de en donde se crea el objeto, es decir, si el objeto se guarda en el stack entonces los atributos también se guardaran en el stack, mientras que si se guarda en el heap entonces el objeto y sus atributos se guardaran en el heap pero el puntero se guarda en el stack. Como un ultimo caso con los atributos estáticos no están dentro de la instancia sino que están en una selección global del programa.

Los metodos viven todos en la selección de texto o en cierta sección de codigo del ejecutable, Esto significa que todas las instancias de una clase comparten el mismo bloque de código para sus métodos.

Vtable es una tabla interna que contiene punteros a funciones virtuales y está se genera cuando una clase tiene al menos un metodo virtual, gracias a esto cada instancia de esa clase guarda un puntero oculto a la vtable. Esto permite el polimorfismo a la hora de ejecutarlo los cual es llamar al método correcto dependiendo del tipo real del objeto, incluso si se usa a través de un puntero.

## Exploración de métodos virtuales

**¿Cómo afecta la presencia de métodos virtuales al tamaño del objeto?** 

La presencia de métodos virtuales aumenta el tamaño del objeto porque el compilador le agrega un puntero oculto a la vtable, conocido como vptr, y este se almacena como el primer campo del objeto y este tiene un tamaño dependiendo del sistema osea normalmente es de 4 bytes en sistemas de 32 bits o 8 bytes en 64 bits.

**¿Qué papel juegan las vtables en el polimorfismo?** 

Las vtables son clave para que funcione el polimorfismo lo cual esto ocurre ya que cuando se declara un metodo virtual, el compilador crea una vtable por clase que contenga punteros a las implementaciones de los métodos virtuales e inserta un puntero oculto que sería el vptr en cada objeto que apunta a esa vtable, de esta manera cuando esta en ejecución si se llama un método virtual mediante un puntero o referencia a clase base el programa va a hacer las siguientes cosas: 

- Usa el vptr del objeto para acceder a su vtable.

- Busca el puntero al método correcto según el tipo real del objeto.

- Ejecuta esa versión del método.

**Cómo se implementan los métodos virtuales en C++?**

En C++, los métodos virtuales se implementan usando una estructura interna llamada vtable y un puntero oculto llamado vptr que el compilador agrega automáticamente a los objetos de clases con métodos virtuales.

Cuando se llama un método virtual a través de un puntero o referencia a la clase base, C++ hace lo siguiente en el tiempo de ejecución: 

- Accede al vptr del objeto, el vptr es un puntero oculto. 

- Usa el vptr para acceder a la vtable.

- Busca en la vtable el puntero al método correspondiente.

- Llama a esa función, que puede ser de la clase base o de una clase derivada.

## Uso de punteros y referencias

**Analizar el impacto en memoria**

Cuando se pone un puntero dentro de una función cada instancia de esa clase tiene un campo extra en memoria que ocupa lo que ocupa un puntero y ese puntero no guarda en si la función, sino que guarda la dirección de memoria donde está el código de la función. Con todo esto en cuenta el tamaño de la instancia si aumenta porque ahora cada objeto tiene ese puntero dentro de su estructura.

**Reflexión Guiada**

**¿Cuál es la relación entre los punteros a métodos y la vtable?**

La relación entre punteros a métodos y la vtable es que Los punteros a funciones son independientes, apuntan a funciones globales o estáticas y los punteros a métodos miembro son más complejos, porque necesitan asociarse con un objeto concreto al ser invocados. La vtable como se había mencionado antes es que el compilador la crea automáticamente cuando hay métodos virtuales, esto lo hace en vez de que uno los declare uno mismo para que el mismo compilador lo haga.

**¿Cómo afectan estos mecanismos al rendimiento del programa?** 

Los punteros a funciones y los punteros a métodos miembro requieren de más recursos porque tienen hacer varios procesos que los pueden hacer más lentos que los punteros normales, por otro lado con el vtable puede llegar a ser más eficientes para el rendimiento porque puede parecer pequeña la diferencia pero en la hora de ejecutar se puede notar el cambio.

**¿Qué diferencia hay entre punteros a funciones y punteros a métodos miembro en C++?** 

Un puntero a función es solo la dirección de una función global o estática y un puntero a método miembro guarda información que permite llamar a una función asociada a un objeto específico.

**Reflexión individual** 

**¿Dónde residen los datos y métodos de una clase en la memoria?**

Los datos a los que también se les podría llamar atributos, por lo general se encuentran en el heap o el stack, dependiendo de como se instancie el objeto. Los metodos están en la sección de codigo del programa y no la del objeto.

**¿Cómo interactúan las diferentes partes en tiempo de ejecución?**

El objeto guarda solo sus datos, Los métodos se llaman accediendo a la dirección en la sección de código y si aplica en todo esto un puntero a vtable.

**Conclusión: cómo esta comprensión afecta el diseño de sistemas.** 

Entender cómo se manejan punteros, referencias y vtables permite diseñar sistemas más eficientes, esto porque se evitan usar datos innecesarios que pueden hacer el rendimiento y el gasto de memoria más significativo y además de esto se puede empezar a aprender cuando conviene usar el polimorfismo y cuando los punteros a funciones.






