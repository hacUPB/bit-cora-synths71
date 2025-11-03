# RAE1:

**Idea:**

La idea que se me planteo fue usar el ejemplo numero 9 en la lista de ejemplos shader para cambiar la imagen y no solo eso, sino que también en lugar de solo poner un simple desenfoque que se cambie el color de un lado así uniforme y que cuando se vaya acercando al otro lado ponga el color original de la foto y usando el ejemplo 3 nos podemos guiar para realizar ese proceso.

**Video:**

https://drive.google.com/file/d/1TTmyusJpQyOGR3g00CIIuKXlaFLQY1x6/view?usp=sharing

# RAE2:

**Explica y muestra cómo probaste la aplicación en ofApp.cpp.**

El cpp lo probe usando los uniforms que solo agrege en el draw junto con cambiar la imagen, estos uniforms los agrego para que salgan en el draw final ya que dejandolos como simples variables en el shader no serviria de nada y poniendo los valores de los colores y demás que tendrían

![alt text](<Captura de pantalla 2025-11-03 175811.png>)

**Explica y muestra cómo probaste el vertex shader.**

El vertex shader no lo movi para nada para poder construir la aplicación. Es exactamente lo mismo tento para el X como para el Y.

![alt text](<Captura de pantalla 2025-11-03 180000.png>)

**Explica y muestra cómo probaste el fragment shader.**

El fragment shader cree varias variables como la del mouse y el tinte de color como uniforms, así como en el ejemplo 3 de la bola que cambia de color dependiendo de la posición del mouse, al inicio las iba a probar usando una imagen negra de un lado y luego ahí si cambiaba a la imagen normal pero opte por esta que se ve mucho mejor.

![alt text](<Captura de pantalla 2025-11-03 180816.png>)

![alt text](<Captura de pantalla 2025-11-03 180826.png>)



