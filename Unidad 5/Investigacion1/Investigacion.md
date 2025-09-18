# Introducción a los Objetos

1. **¿Qué representa la clase Particle?**

La clase Particle representa una plantilla o modelo para crear partículas en un programa. Define dos cosas principales:

- Atributos (x y y), que representan la posición de la partícula en un espacio 2D.

- Comportamiento a través del método move(), que permite modificar la posición.

En términos de programación orientada a objetos, Particle encapsula tanto los datos como las acciones que se pueden hacer con esos datos. Se puede ver por asi decirlo como un espacio o plano para construir objetos que se comportan como particulas móviles. 

2. **¿Cómo interactúan sus atributos y métodos?**

Los atributos y métodos de Particle están conectados. Cuando se llama al método move() en un objeto Particle, ese método modifica directamente los atributos internos (x y y) del objeto que lo invoca, el metodo en si es el siguiente:

```cpp
void move(float dx, float dy) {
    x += dx;
    y += dy;
}
```
Esto ocurre gracias al puntero oculto this, que le permite al método acceder a los atributos del objeto específico (en este caso, p1) sobre el que se llamó.

3. **Prompt para ChatGPT: explícame en detalle qué es un objeto en C++ y cómo se relaciona con una clase. Usa el ejemplo de una clase Particle con atributos x y y y un método move.**

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

# Explorando la memoria

![alt text](<../Evidencias1/Captura de pantalla 2025-09-18 092346.png>)
