Idea de Proyecto: "Partículas con Personalidad"

Concepto general:
Vamos a crear un sistema de partículas en openFrameworks donde cada partícula tiene un comportamiento distinto, dependiendo de su "tipo". Por ejemplo, algunas partículas se mueven en línea recta, otras siguen trayectorias onduladas, y otras se comportan de manera errática (ruido perlin o movimiento aleatorio). Estas partículas estarán representadas como clases derivadas de una clase base Particle, lo que nos permitirá aplicar herencia y polimorfismo. Además, cada partícula encapsulará su estado interno como posición, velocidad, color, etc.

✍️ Redacción para la Bitácora (borrador inicial)
Nombre del Proyecto:

Partículas con Personalidad

Descripción del proyecto:

Este proyecto consiste en un sistema de arte generativo interactivo desarrollado con openFrameworks y C++. A través del uso de programación orientada a objetos, se genera un conjunto de partículas que se mueven de maneras distintas según su "personalidad" o tipo. Algunas partículas se desplazan en línea recta, otras siguen trayectorias onduladas y otras se comportan de forma errática. El objetivo es visualizar cómo la herencia y el polimorfismo permiten estructurar comportamientos complejos de manera clara y extensible.

Motivación y relación con los conceptos de OOP:

Este proyecto nace del interés por explorar cómo los principios de la programación orientada a objetos pueden aplicarse para construir un sistema visual dinámico y flexible. Al implementar una clase base Particle y múltiples clases derivadas (StraightParticle, WavyParticle, RandomParticle), se pone en práctica:

Encapsulamiento: cada partícula gestiona sus propios datos privados como posición, velocidad y color. Solo expone lo necesario para interactuar con el sistema general.

Herencia: las clases derivadas heredan los atributos y métodos básicos de la clase Particle, extendiéndolos según el tipo de movimiento.

Polimorfismo: el sistema puede almacenar punteros a Particle sin importar su tipo real, y llamar a métodos como update() o draw() de forma genérica, logrando así una interfaz común para comportamientos diferentes.

Plan general de implementación:

Crear una clase abstracta Particle con métodos virtuales puros update() y draw().

Definir clases derivadas que implementen diferentes comportamientos:

StraightParticle: se mueve en línea recta.

WavyParticle: se mueve con un patrón sinusoidal.

RandomParticle: cambia de dirección aleatoriamente en cada frame.

Generar múltiples partículas de diferentes tipos y almacenarlas en un vector de punteros a Particle.

En cada frame, se actualizan y dibujan todas las partículas utilizando polimorfismo.

Experimentar con el número de partículas, colores y tamaños para obtener distintos efectos visuales.

Usar herramientas de depuración para observar el impacto de los métodos virtuales en el uso de memoria y rendimiento.

Reflexión inicial:

Esta idea busca no solo generar una visual interesante, sino también demostrar de forma clara y práctica cómo funcionan los mecanismos internos de OOP en C++. Al observar cómo se comportan las partículas en la ejecución del programa, se podrá razonar sobre la estructura de memoria, el uso de vtables, y la eficiencia de cada tipo de implementación. La simplicidad visual del proyecto facilita enfocarse en el análisis técnico y conceptual.