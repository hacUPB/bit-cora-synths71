# Rae1:

El arte generativo consiste en simular el crecimiento dinámico e interactivo de un jardín digital, estas primero crecen como lineas, pensandolo como si fuera el tallo y cuando se presionan alguna teclas, va a hacer algunas cosas, como crecer, florecer y marchitarse. Al iniciar la aplicación, distintas especies de plantas que son flores, arbustos y espigas, comienzan a desarrollarse sobre el canvas de la pantalla.

Cada planta reacciona a eventos generados por el usuario mediante el teclado, lo que permite alterar su estado de desarrollo, estas interacciones son las siguientes:

- Con la tecla G, germina las plantas.

- Con la tecla C, las florece y hace crecer la manga.

- Con la tecla R, reposar las plantas.

- Con la tecla S, seca o marchita las plantas.

**Patrones de diseño aplicados**

**Observer:** Se utiliza para que cada planta escuche y reaccione a los eventos globales disparados desde el entorno, esto nos sirve para que podamos cambiar el estado de todas las plantas de forma ordenada.

**Factory:** Se implementa una fábrica para instanciar distintos tipos de plantas sin acoplar el código a clases específicas, esto nos deja crear diferentes tipos de plantas sin cambiar el codigo con clases diferentes.

**State:** Cada planta implementa una máquina de estados que define su comportamiento visual y funcional, esto permite encapsular la lógica de cada etapa del crecimiento y facilita la transición entre estados de manera controlada.



