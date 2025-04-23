## Apuntes Godot

Para proyectos 2D, la opción Mobile es suficiente. Para gráficos más avanzados, usar Forward+. Esta opción puede cambiarse en cualquier momento.

Para cambiar la escena principal (que se renderiza al ejecutar el juego): Project Settings > Application > 

Para cambiar la velocidad de la rueda del ratón para hacer zoom: Editor Settings > Buscar zoom > Zoom Speed Factor

Para escalar proporcionalmente, mantener Shift pulsado.

En la barra de herramientas hay un icono para cambiar el punto sobre el que pivotan los objetos, una regla para medir distancias, ajustar la posición de los objetos
usando la cuadrícula, una opción para agrupar objetos.

Para centra el editor en un nodo, pulsar sobre el nodo, colocar el ratón dentro de la pantalla de edición y pulsar la letra F.

En el Inspector, se pueden marcar las propiedades como favoritas haciendo click derecho, y aparecerán al principio del Inspector. Esto también puede hacerse con 
los archivos del FileSystem.

Para cambiar el formato del nombre de los archivos (PascalCase, snake_case,...), Project Settings (activar opciones avanzadas) > Editor > Naming

Al arrastrar un nodo desde el árbol de nodos y soltarlo mantiendo pulsado control, se crea una referencia a ese nodo.

Es una buena práctica crear las escenas del juego con el botón de crear en vez de arrastrando los assets a la pantalla de juego. Esto nos asegura que el centro esté centrado.

### Area2D
Se utiliza para detectar colisiones en 2 dimensiones. Debe tener como hijo un CollisionShape2D. Posteriormente hay que seleccionar la propiedad shape de este último nodo.

En el menú superior, en la opción Debug, se puede activar la opción Visible Collision Shapes para ver los collision shapes durante el desarrollo y la ejecución del juego.

set_process(false) detiene la ejecución de la función _process() cada frame. Tambión puede detenerse la ejecución de la función _physics_process() con set_physics_process(false)

Al llamar a queue_free() en una escena, esta y todos sus hijos son eliminados. En realidad queue_free() pone a las escenas en una cola para ser eliminadas, lo que no tiene que producirse inmediatamente. Por eso es buena práctica detener la ejecución de la función _process() primero para evitar efectos inesperados.

Con get_viewport_rect() se puede comprobar cuando un nodo alcanza el limite de la pantalla. En los juegos en los que la dimensión de la pantalla puede cambiar, es interesante crear una variable estática para almacenar este valor, y conectar una señal (get_viewport.size_changed) para actualizar la variable estática cada vez que la pantalla cambie de tamaño. Así no hay que llamar a get_viewport_rect() continuamente.

### Controles

Project > Project Settings > Input Map > Add new action > Escribir nombre de la nueva accion (ej: jump, move_right, etc.) y añadir.

Para lanzar la acción creada, hay que especificar que control la activa. Por ejemplo, si se pulsa la tecla A, entonces move_left.

Activando la opción Show Built-in Actions, se muestran todas las acciones preestablecidas.

Una de las formas de manejar la entrada, es haciendo uso del singleton Input. Ej: Input.is_action_pressed("accion"). 

Input.get_axis("accion") también es útil para manejar la entrada de acciones opuestas, como moverse a derecha o izquierda.

clampf(value,min,max) devuelve el valor de value siempre entre min y max. Esto puede ser útil para que el jugador no salga de los limites de la pantalla.  

Timer es el nodo que se usa para realizar cuentas regresivas. Cuando llega a cero, emite la señal timeout(). Entre otros métodos útiles, destaca stop().

Para instanciar una escena mediante codigo, lo primero es indicarle a godot la ruta a esa escena. Esto se consigue arrastrando la escena al código mientras se mantiene pulsado control.

Con preload(), la carga se realiza en tiempo de compilación. Aumenta el tamaño del programa pero es más rápido.

Con load(), se realiza en tiempo de ejecución.

### Ejemplo de instaciación de una escena
```
const GEM = preload("res://Scenes/Gem.tscn")

func spawn_gem() -> void:
	var new_gem = GEM.instantiate()
	new_gem.position = Vector2(100, -50)
	add_child(new_gem)
```

get_children() permite recorrer todos los hijos de un nodo

### Ajustes de importaciones
Al seleccionar un asset, en Import (junto a Scene) se pueden configurar los parámetros de importación. También pueden establecerse estos parámetros de forma global en Project > Project Settings > Import Defaults > Importer (seleccionar tipo de archivo).

Para poner música de fondo, se puede utilizar el nodo AudioStreamPlayer. Aparte de los métodos play() y stop(), una propiedad útil es stream, que permite seleccionar el sonido que se reproduce.

Para hacer que el sonido se produzca en una posición concreta se puede usar AudioStreamPlayer2D.

str() convierte una variable a tipo String.

### Ciclo de vida de un nodo
1. _init: se definen variables y métodos.
2. _enter_tree: la instancia sea añade al árbol de escenas
3. _ready: la instancia y sus hijos se añaden al árbol. Esta función se ejecuta primero en los hijos y luego en los padres.
4. _exit_tree: la instancia se prepara para ser eliminada del árbol de escenas.

### Aspect Ratios
Project Settings > General > Display > Window > Stretch

Mode: las opciones canvas_items y viewport son prácticamente iguales, pero canvas_items no se recomienda para pixel art.

Después de seleccionar una de las dos opciones anteriores, se establece aspect en keep. De esta manera se asegura que se mantenga la relación de aspecto.

### Pasos al iniciar un nuevo proyecto
1. Importar los assets.
2. Establecer las dimensiones de la pantalla.
3. Establecer el aspect ratio. Por ejemplo, Canvas Items y Keep Aspect.

### Nodos para físicas
1. StaticBody2D: para objetos que no pueden ser movidos por fuerzas externas. Cuando son móvidos por script, no afectan a otros objetos. Útil para suelos y muros.
2. CharacterBody2D: pensado para personajes que se mueven mediante script. No son afectados por las físicas pero afectan a las físicas de otros objetos.
3. AnimatableBody2D: para objetos que se mueven solo mediante script o animación. Cuando se mueven mediante script, afectan a las físicas de otros objetos. Útil para plataformas que se mueven y puertas.
4. RigidBody2D: para objetos a los que se les aplican físicas. Útil para objetos que sufren la gravedad y pueden ser golpeados por otros objetos.

De estos nodos se modifica la velocidad o la fuerza que se le aplica, pero en ningún caso la posición. El motor de físicas es el encargado de calcularla.

Aunque el Area2D y el CharacterBody2D son parecidos y ambos tienen collisionShape2D, en el primero se utiliza para detectar colisiones con otros CollisionShape2D mientras que en el segundo para interactuar con esos CollisionShape2D.

Cuando se quieren animar varios sprites, puede usarse AnimatedSprite2D en lugar de Sprite2D. Pulsar sobre Animation > Sprite Frame > empty > New Sprite Frame. Se abre un nuevo menú donde cargar la hoja de sprites. Buscar la opción: Add frames from sprite sheet. Una vez cargados, aparecerá una nueva ventana para recortarlos. 

Los Sprites Frames quedan guardados en la escena, pero se pueden guardar de forma independiente con la opción Save as. De esta manera pueden ser reutilizados por escenas distintas. Si se quiere modificar un Sprite Frame compartido por varios escenas sin que afecte al resto, se puede usar la opcion Make Unique (esto hace que el sprite frame se guarde en la escena).

Esta forma de guardar los recursos dentro de una escena o de forma separada aparece continuamente a la hora de trabajar con godot.

Cuando una escena con físicas necesita ser escalada, es preferible escalar los sprites (AnimatedSprite2D o Sprite2D) que la escena completa, ya que se pueden producir errores con el motor de físicas (aunque no debería).

Al trabajar con nodos de físicas, usar _physics_process(delta) en lugar de _process(delta). Esto permite al motor de físicas realizar todos los cálculos correctamente.

Para acceder a una variable de la configuración del proyecto, seguir estos pasos:
1. Buscar la variable en Project Settings. Por ejemplo, gravity.
2. Hacer click derecho sobre el nombre de la variable y copiar la ruta: Copy Property Path.
3. Dentro del script, usar la función ProjectSettings.get(ruta). Ej: var _gravity:float = ProjectSettings.get("physics/2d/default_gravity")

## move_and_slide() multiplica por delta internamente!!

### AnimationPlayer
Mientras que el AnimatedSprite2D permite crear una animación formada por varios sprites, el AnimationPlayer permite animar otras propiedades como la rotación, la posición, la escala, etc.

Al añadir el nodo AnimationPlayer, se abre un nuevo menú llamado Animation. Para crear una nueva animación, pulsar sobre Animation > New. Siempre que esté el menú Animation abierto, en el inspector van a aparecer las propiedades que se pueden animar con una llave al lado. Las propiedades se pueden añadir a la animación pulsando sobre la llave o dentro del menú Animation pulsando sobre Add track.

Para iniciar la animación desde un script, animation_player.play("nombre_animacion")

El nodo VisibleOnScreenNotifier2D permite saber si un nodo está dentro de la pantalla o no. Sin embargo, tiene ciertos problemas cuando el juego está minimizado o está detrás de otras ventanas en algunos sistemas operativos, por lo que realmente es mejor usar otras técnicas para saber cuando un objeto ha salido de la pantalla.

Para agrupar múltiples nodos y manipularlos a todos como un conjunto, se puede usar el nodo Node con el conjunto de nodos como sus hijos.

Para marcar posiciones en el juego, se puede usar el nodo Marker2D.

Los nodos para físicas, como el CharacterBody2D, no son buenos para detectar con qué objeto ha impactado el nodo.

### Pausar una escena
Para pausar todas las físicas, animaciones, etc de una escena, puede usarse get_tree().paused = true
Cuando se pausa una escena, se pausan todos sus hijos. Para evitar que se pausen, se pueden seleccionar y modificar en el inspector: Node > Process > Mode > Always.

### Interfaz de usuario
En cuanto a la interfaz de usuario, hay dos tipos de nodos:
1. Presenting nodes: muestran algo por pantalla.
2. Containers: controlan la diposición de sus hijos en pantalla. Es mejor usar estos nodos que posicionar los elementos en pantalla de forma manual.

Para añadir imágenes a la interfaz, se usa TextureRect.
Para añadir texto, se usa el nodo Label. Para cambiar su aspecto, crear un nuevo Label Settings. Esto permite cargar fuentes personalizadas, por ejemplo.
Para añadir márgenes, MarginContainer (recordar ajustar su tamaño a toda la pantalla). Todos los nodos a los que se les quiera aplicar margen deberán ser hijos de este nodo. Ahora todos los nodos deberán posicionarse individualmente usando la barra de herramientas de la barra superior. Para establecer los márgenes, dentro del inspector, Control > Theme Overrides > Constants

Las animaciones pueden usarse también en los nodos de control. Para que un nodo parpadee, por ejemplo, se anima la propiedad CanvasItem > Visibility > Modulate.

Para dibujar elementos en una pantalla de juego, hay que añadir el nodo CanvasLayer, los elementos de la interfaz tienen que añadirse como hijos de este. En una misma pantalla, pueden añadirse múltiples CanvasLayer.

El CanvasLayer se muestra por delante del resto de los elementos del juego, independientemente del orden en el árbol. Este orden puede cambiarse en el inspector: CanvasLayer > Layer > Layer. Se muestra primero la capa que tiene este valor más alto.

De CanvasLayer son útiles las funciones show() y hide() para mostrar y ocultar etiquetas, por ejemplo. Se puede conseguir el mismo efecto usando la propiedad visible. Ej: label.visible = true

Para ocultar un nodo o escena por defecto, puede pulsarse sobre el icono del ojo en el árbol de escenas.

Para detectar una entrada puntual se puede usar la función _input(event:InputEvent). En los casos de entradas puntuales es recomendable no usar _process(). 

_input() y unhandled_input() se diferencian en que las entradas manejadas por la interfaz son marcadas como manejadas y nunca llegan a la función unhandled_input().

### Cambios de escena
1. Precargar escena arrastrándola al código manteniendo pulsado Control.
2. Usar get_tree().change_scene_to_packed(escena_precargada)

### Problema de dependencias circulares
Failed to instantiate scene state of "", node count is 0. Esto error aparece cuando la escena A precarga en su script a la escena B, y la escena B precarga en su script a la escena A. Esto se soluciona usando load() en lugar de preload() en una de las escenas.

### Signal Hub
Para manejar las múltiples señales que se emiten durante el juego, se puede usar un signal hub. Para ello:
1. Crear una carpeta llamada Globals en la raíz del proyecto.
2. Dentro de esa carpeta crear un script llamado SignalHub, seleccionando Template: Empty
3. Project Settings > Globals > Autoload. Cargar el script, darle un nombre y añadir. A partir de este momento, podremos usar el script anterior en otros scripts para emitir señales. El orden en el que son creados los autoloads es el mismo en el que aparecerán en el árbol de nodos cuando empiece el juego. Puede modificarse usando las flechas que aparecen a la derecha.
4. Conectar la señal en la función _enter_tree() en lugar de _ready(). La primera se ejecuta antes que la segunda. De esta forma nos aseguramos que cuando se envíe una señal, ya esté conectada previamente.

Al usar un GameManager para precargar las escenas del juego, no se va a producir el error de las dependencias cruzadas, ya que todas las escenas se precargaran una sola vez al comienzo del juego. Además, el GameManager se encargará de los cambios de escena.

Al igual que es posible conectar una señal a una función, es posible desconectarla.