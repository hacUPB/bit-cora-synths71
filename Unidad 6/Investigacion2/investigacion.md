# Sesión 1: 

Se visualizaron los videos y se estudio el contenido en los links de factory method, observer y state. 

# Sesión 2: 

**¿Qué hace el patrón observer en este caso?**

Esto sirve para que un objeto que para este caso se llama subject le pueda notificar a otros objetos diferentes cuando esta ocurriendo un estado. El cpp puede heredar de subject que esta en el  .h y por esto tiene una lista de observers que puede notificar, siguiendo esto vemos que cada particle implementa y notifica a los observer y por esto esta la función ```void Subject::notify(const std::string& event)``` y haciendo esto cuando se presionan las teclas S, A, R, N se llama al notify y todas las particulas reaccionan al cambio de estado.

**¿Qué hace el patrón factory en este caso?**

Este patrón lo que hace es permite crear objetos sin especificar la clase exacta del objeto que se va a crear, es decir que la función ```ParticleFactory::createParticle("tipo")``` crea diferentes tipos de partículas y de ahi cada una tiene una personalidad y logica de creación para cada tipo.

**¿Qué hace el patrón state en este caso?**

Esto lo que hace es que permite cambiar el comportamiento de un objeto según el estado actual en el que se encuentre y encapsula cada comportamiento especifico en una clase separada, esto se logra porque cada particula tiene un puntero state y estas particulas tienen los estados NormalState, AttractState, RepelState, StopState los cuales van a definir el comportamiento de estas y actualiza el mismo según que tecla se presione para cambiar de estado y para cambiar el estado de las particulas se usa ```setState(new State)```

## Experimenta con el código y realiza algunas modificaciones para entender mejor su funcionamiento. Por ejemplo:


