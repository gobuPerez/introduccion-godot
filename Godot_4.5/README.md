## 0. Introducción

### Deficiones

- Viewport: rectángulo azul que representa la zona renderizada del videojuego. Todo lo que esté fuera de él no se mostrará durante la partida.

- res:// : directorio donde se encuentra el proyecto. Puede encontrarse en el FileSystem.

### Ajustes de creación del proyecto

Para juegos 2D, el modo "Mobile" es más que suficiente. 

En el menú de la derecha del Project Manager está la opción "Remove". Esta sirve para dejar de mostrar un proyecto en la lista del Project Manager, pero en ningún caso elimina los archivos del proyecto del disco.

Para cambiar el formato del nombre que reciben los scripts y las escenas al guardarse: Project > Project Settings > Editor > Naming.

### Layout

Junto a cada ventana del editor hay tres puntos que sirven para elegir la posición en pantalla.

En el caso de cerrar una ventana accidentalmente: Editor > Editor Docks

Para cambiar el tamaño de una fuente y otras opciones del editor: Editor > Editor Settings

Dentro de Editor Settings, buscando "help" en el buscador, se puede acceder al menú para cambiar el tamaño de fuente de la documentación embebida.

Del mismo modo, buscando "output", se puede cambiar el tamaño de fuente de lo que se imprime por consola.

Buscando "zoom", se puede cambiar la velocidad a la que se hace zoom en la pantalla de juego.

Dentro de Editor > Editor Settings, también esta la pestaña "Shortcuts", donde pueden consultarse y modificarse los atajos de teclado.

Dentro de la ventana 2D, en View > Grid, se puede seleccionar cuándo mostrar el grid. El tamaño del grid se puede cambiar en la ventana 2D, junto a las opciones de "Snap", en los tres puntos: Configure Snap.

Arrastrando las reglas que aparecen dentro de la ventana 2D, las que indican los pixels, se pueden crear ejes para medir de manera más precisa las posiciones.

### Relación de aspecto y resolución

Para elegir el tamaño del viewport durante el desarrollo: Project > Project Settings > Display > Window > Size

Para que el juego pueda adaptarse a distintas pantallas con diferentes tamaños sin perder las proporciones es necesario configurar, Project > Project Settings > Display > Window > Stretch > Mode:
- canvas_items: para los juegos 2D que no sean pixel art.
- viewport: para juegos 2D con estilo pixel art.

Configurar Project > Project Settings > Display > Window > Stretch > Aspect en "keep".

Para que los sprites se vean bien en juegos con estilo pixel art cambiar Project > Project Settings > Rendering > Textures > Canvas Textures > Default Texture Filter a "Nearest".

### Importación de assets

A la hora de importar assets al proyecto, da igual arrastrarlos dentro del FileSystem o añadirlos a la carpeta del proyecto desde el explorador de archivos del sistema operativo.

Junto a la ventana "Scene", está "Import", que sirve para cambiar los parámetros de importación de los assets. Estos parámetos se guardan en los archivos .import que acompañan a cada asset.

Para cada asset, godot crea un archivo binario cuya lectura es más rápida. En el archivo .import de cada asset se puede consultar el nombre del archivo binario y donde está guardado.

### Escenas y nodos

Para reiniciar una escena: get_tree().reload_current_scene()

Al instanciar una escena, todos los recursos son compartidos. Es decir, si tenemos dos objetos instanciados mediante la misma escena y modificamos uno de ellos, los cambios también se aplicarán al otro. Para hacer que un recurso pertenezca solo al objeto instanciado, es decir, que no sea compartido por todos, hay que marcar el recurso como "Local to Scene" en la escena base. Por defecto, Godot intenta crear un solo recurso y que todos los objetos instanciados lo compartan. Al activar Local to Scene, se crea un recurso por cada objeto instanciado.

#### Ciclo de vida de un nodo:

- _init

- _enter_tree: se ejecuta en el orden en el que los nodos aparecen en el árbol, de arriba hacia abajo.

- _ready: se ejecuta de arriba hacia abajo, primero en los nodos que tienen a todos sus hijos listos, hasta el nodo padre en último lugar.

- _exit_tree

En Project > Project Settings > Application > Run se puede establecer el máximo de fps al que se va a ejecutar el juego.

En Project > Project Settings > Physics > Common > Physics ticks per second se puede establecer el máximo de fps del motor de físicas.

En Project > Project Settings > Display > Windows, si V-Sync Mode está activado, los FPS se van a adaptar a la tasa de refresco del monitor.

Puede cambiarse el formato del nombre de las escenas en: Project > Project Settings > Editor > Naming. Suelo utilizar el mismo para todo: PascalCase. Este tipo de ajustes se guarda en el archivo project.godot en la raíz del proyecto.

Utilizando un editor de código se pueden abrir los archivos .tscn (escenas) y ver cómo están configuradas.

La escena principal que será renderizada cuando se ejecute el juego se puede seleccionar en Project > Project Settings > Application > Run. También se puede seleccionar haciendo click derecho sobre la escena en el FileSystem > Set as Main Scene

Al ejecutar el juego, dentro de la ventana Scene aparecen dos pestañas:

- Remote: muestra los nodos que forman parte del juego durante su ejecución. Es decir, lo que se está renderizando.

- Local: vista normal del árbol de nodos.

Dentro de un mismo nivel del árbol de nodos, dos nodos no pueden tener el mismo nombre.

Las propiedades de un nodo se pueden marcar como favoritas haciendo click derecho sobre ellas en el Inspector.

El orden en el que se renderizan en pantalla los nodos depende de la propiedad: Canvas Item > Ordering > Z Index. Si la opción "Z as relative" está activada, el índice Z de un nodo hijo se obtiene sumando su índice al que tiene su padre. En caso de igualdad de índice Z, el orden de renderizado lo determina el orden en el árbol de nodos. Cuanto más abajo en el árbol de nodos, más prioridad para ser renderizado.

Haciendo click derecho sobre un nodo en la ventana "Scene" se puede cambiar el tipo de nodo: Change Type...

La propiedad Canvas Item > Ordering > Y Sort Enable, permite ordenar los nodos según su posición Y. Esto es útil en juegos 2D tipo RPG, en los que un personaje puede rodear objetos. Gracias a esta propiedad se crea un efecto 3D. Es importante saber que esta propiedad no se activa en los nodos que queremos ordenar. Los nodos deben tener el mismo padre y la propidad se activa en el padre. Los nodos hijos deben pertenecer a la misma capa. 

La posición y la posición global de un nodo son conceptos diferentes. La posición es la que aparece en el inspector, y siempre se mide respecto al padre. La posición global es independiente de la posición del nodo padre. Lo mismo ocurre con la rotación y la rotación global. Sin embargo, el escalado se comporta de manera diferente. Cuando se escala un nodo, sus hijos también son escalados, y el escalado afecta a su posición. Por ejemplo, el hijo de un nodo con escalado 0.5 mostrará en su propiedad position que se ha desplazado el doble de lo que lo ha hecho, lo que afecta también a la física. Por esta razón, cuando se escala un nodo, este no debe tener hijos.

#### Instanciar escenas mediante código

Arrastrando una escena dentro de un script desde el sistema de archivos, y manteniendo pulsando Control al soltar, permite precargar la escena. Una escena precargada está embebida en el binario de la escena. Esto hace que cargue más rápido pero también que aumente el espacio necesario para el juego.

En Editor > Editor Settings > Text Editor > Behavior > Drop Preload Resources as UID: si está activo las escenas precargadas se referencian por su UID, por lo que, aunque cambié su ubicación no afecta al código. Si esta opción está desactivada, la escena precargada se referencia por su ruta en el sistema de archivos, que puede cambiar a lo largo del desarrollo. Por defecto, está activa.

#### Nodos

- AnimatedSprite2D: para animar hojas de sprites de manera sencilla. Para configurarlo hay que crear un nuevo SpriteFrame en el Inspector. Luego al clickar sobre él, se abre una ventana en la parte inferior de la pantalla para la animación. En esta ventana, en Animation Frames, se puede añadir una hoja de sprites mediante "Add frames from sprite sheet", o hacerlo individualmente. En Animations, se pueden añadir nuevas animaciones y cambiar el tiempo que tardan en mostrarse todos los frames, así como activar el looping de las animaciones y el autoplay. En Animation Frames, se puede modificar cada frame individualmente. En esta sección "Frame duration" permite ajustar el tiempo que dura un frame individual.
- AudioStreamPlayer2D: reproduce un sonido posicionalmente. Por ejemplo, al usar auriculares se percibe de qué lugar proviene el sonido. Añadir el sonido en la propiedad "Stream", pinchando sobre el icono de la carpeta.
- Area2D: sirve para detectar cuando otros cuerpos entran o salen de su zona de influencia.
- AudioStreamPlayer: reproductor de sonido no posicional. Comprobar que se elige el nodo que no pertenece a los Nodos2D ni a los nodos3D.
- CollisionShape2D: no se debe escalar. Pueden producirse errores con el motor de físicas. Para mostrar durante la ejecución del juego: Debug > Visible Collision Shapes.
    - WorldBoundaryShape2D: tipo de CollisionShape2D que consiste en una linea infinita. La flecha apunta en la dirección de la que debería llegar el jugador.
- Sprite2D: para renderizar imágenes. Es necesario añadir una imagen en la propiedad "Texture". También se puede arrastar una imagen dentro del juego y automáticamente Godot la configura como un Sprite2D.
- Timer: un temporizador.

##### Nodos de físicas

- AnimatableBody2D: nodo de físicas para objetos que se mueven mediante animaciones.
- CharacterBody2D: nodo de físicas para personajes que se mueven mediante código. Se establece la velocidad y el motor de físicas se encarga del movimiento. La detección de suelos, techos y muros se puede configurar con las propiedades "Up Direction" y "Floor" que están en el Inspector.
- RigidBody2D: nodo que simula físicas 2D. Es controlado por el motor de físicas, por lo que no se debe modificar su estado directamente, sino aplicándole fuerzas.
- StaticBody2D: detecta colisiones pero no tiene una reacción a la colisión.

#### Colisiones

- Layer: capa a la que pertenece un objeto. Si un objeto no tiene que ser detectado por ningún otro, se puede hacer que no pertenezca a ninguna capa.
- Mask: capas con las que interactúa un objeto.

Pulsando sobre los tres puntos junto a Layer y Mask en el Inspector, se puede configurar a que capa o máscara pertenece cada objeto usando nombres personalizados. Aunque se usen las capas, es buena práctica comprobar mediante código que se está colisionando con el objeto deseado.

Los nombres pueden configurarse en Project Settings > Layer Names > 2D Physics.

### Señales

Junto al Inspector, en la ventana "Node", pueden consultarse las señales que emite un nodo. Haciendo click derecho o doble click sobre ellas se pueden conectar.

También es posible crear señales personalizadas usando la palabra reservada "signal". Para conectar señales a través de código: señalQueSea.connect(). Y señalQueSea.disconnect() para desconectar.

Distintas señales se pueden conectar a una misma función.

### Grupos

Para identificar a un conjunto de nodos se pueden usar los grupos. En la ventana "Node" junto a la ventana "Inspector", está la opción "Groups" junto a "Signals". Hay dos tipos de grupos:

- Locales a la escena: solo seleccionables dentro de la escena donde son creados.
- Globales: seleccionables por otras escenas del juego.

Cuando una escena se añade a un grupo aparece un icono de un cuadrado junto a ella en el árbol de nodos.

Una forma de obtener todos los nodos que pertenecen a un grupo: get_tree().get_nodes_in_group("grupoQueSea")

### Sobre el escalado

Si se necesita que el jugador sea más pequeño, escalar únicamente su sprite. No escalar al padre porque esto afectaría a su velocidad de movimiento.

No escalar las CollisionShape porque se pueden producir inconsistencias con el motor de físicas. Para modificar una CollisionShape, ajustar su forma.


### Scripting

Puede cambiarse el formato del nombre de los scripts en: Project > Project Settings > Editor > Naming.

Arrastrando un nodo al editor de código de Godot y pulsando Control se puede crear una variable @onready. Si se quiere que la ruta al nodo no dependa de su posición en el árbol de nodos, se puede hacer click derecho sobre el nodo en la ventana "Scene", marcar la opción "Access as Unique Name" y arrastar el nodo al editor de código.

En la ventana "Script" en la esquina superior derecha se puede activar el modo "Sin distracciones", que amplía el espacio del editor de código. Bajo este icono, hay otro para hacer que el editor sea flotante, de manera que puede ampliarse para que ocupe toda la pantalla.

Es buena práctica al añadir un script a un nodo, darle un nombre con class_name.

Poniendo un guion bajo (_) al comienzo de una variable que no se usa, deja de aparecer el warning por no usarla.

Aunque GDScript permite el tipado dinámico es preferible evitarlo. Se evitan errores y se optimiza la ejecución del juego.

Haciendo click derecho sobre un nodo en el árbol de nodos, se puede crear como una escena independiente: "Save Branch as Scene". En el desplegable que se abre, hay opciones para resetear la posición a cero.

Para hacer que una variable aparezca en el Inspector, anteponer en su declaración: @export. El valor de una variable en el Inspector tiene prioridad sobre el valor al que se inicializa en el código.

### Manejo de la entrada

Para acciones que se realizan de manera puntual, como reiniciar el juego, se puede usar: func _unhandled_input(event: InputEvent) -> void

Para detectar toques de pantalla en juegos para móviles o tablets, hay que usar func _unhandled_input(event: InputEvent) -> void. Input no detecta este tipo de entrada.

La detección de la entrada también puede hacerse en _physics_process(delta: float) o en _process(delta: float) usando Input, pero el movimiento solo se aplica en _physics_process(delta: float) 

### Animaciones

- AnimatedSprite2D: para generar una animación sencilla consistente en una sucesión de frames. Se necesita tener los sprites individuales que van a conformar la aplicación, ya sea sueltos o en una hoja de sprites.
- AnimationPlayer: para generar animaciones un poco más complejas. Con este nodo se pueden animar las propiedades que están en el Inspector.

#### Cómo usar el AnimationPlayer

Para configurarlo, abrir la ventana "Animation". Pulsando sobre Animation > New, se pueden crear las animaciones. Hay dos formas de añadir los estados a la animación. La primera consiste en pulsar sobre el icono "+" y seleccionar la propiedad que se quiere animar. Luego hacer click derecho sobre la pista de animaciones y "Insert Key" La otra forma es pulsar el icono de la llave que aparece en el Inspector junto a cada propiedad (para ello tiene que estar abierta la ventana Animation). Esta segunda opción es preferible, ya que es más sencilla y rápida.

Se puede configurar tanto la duración total de la animación (icono de tiempo en la esquina superior derecha), como la separación entre frames (icono de tiempo en la esquina inferior derecha).

Al pulsar sobre la key (o frame) que se ha añadido a la animación, se puede ajustar su valor en el Inspector.

### Interfaz de usuario

No colocar las etiquetas de texto en posiciones aleatorias de forma manual. Usar la herramienta de alineación horizontal y vertical.

Nodos para interfaces:

- Control: nodo base para construir las interfaces de usuario.
- Label
- MarginContainer: para personalizar el valor de los márgenes: Theme Overrides > Constants > Margin.
- TextureRect: para cargar texturas, como una imagen.

### Globals

Global es la forma que tiene Godot de llamar a un singleton. Pueden crearse en Project Settings > Globals. Solo hay que darle un nombre y añadir. Heredan de Node. Para organizarlos mejor se puede crear una carpeta llamada "Globals" en el proyecto.

Algunos singletons útiles:
- GameManager: para gestionar el cambio de escenas evitando las dependencias circulares.


### Funciones y propiedades útiles:

Al pasar el ratón por encima de cualquier propiedad de un nodo en el Inspector, aparece el nombre que debemos utilizar para acceder a esa variable desde el código.

- clampf(float, float, float): asegura que un valor siempre esté entre otros dos indicados. 
- deg_to_rad(): grados a radianes. 
- get_tree().reload_current_scene(): reinicia la escena.
- get_tree().paused: para pausar una escena completa.
- get_viewport_rect(): devuelve las dimensiones del viewport. Útil para saber cuando un objeto ha salido de la pantalla. Para esto ver también VisibleOnScreenNotifier2D.
- is_equal_approx(), is_zero_approx(): para comparar floats.
- is_zero_approx(), is_zero_approx(): para comprobar si un float es 0.
- queue_free(): pide al motor que se elimine un nodo. Suele usarse junto con set_physics_process(false) porque puede transcurrir algo de tiempo entre el momento en el que queremos eliminar un nodo y el momento en que se elimina.
- rad_to_deg(): radianes a grados.
- randf_range(float, float): valor aleatorio en un intervalo.
- set_physics_process(bool): para detener la ejecución de _physics_process().
- type_string(typeof(var)): devuelve el tipo de una variable.
- CanvasItem.get_viewport_rect(): devuelve un rectángulo con las medidas de la pantalla del juego.
- CanvasItem.hide(): oculta el nodo.
- CanvasItem.show(): hace visible al nodo.
- CanvasItem.get_global_mouse_position()
- CharacterBody2D.velocity: para mover este nodo, se modifica la velocidad (píxeles/segundo)
- CharacterBody2D.move_and_slide(): esta función se encarga de aplicar la velocidad previamente establecida y hacer los cálculos de físicas. Multiplica automáticamente por delta. Para aplicar gravedad hay que multiplicar por delta en el código, ya que se trata de una aceleración (px/s^2): la primera multiplicación de delta la hace move_and_slide(), la segunda hay que incluirla manualmente. 
- get_tree().change_scene_to_packed("ESCENA"): para cambiar de escena.
- Input.is_action_just_pressed("string")
- Input.is_action_pressed("string")
- Input.get_axis("negative_action", "positive_action")
- Label.text
- load() y preload(): load carga una escena en tiempo de ejecución y preload en tiempo de ejecución.
- Marker2D: nodo 2D que marca su posición con una cruz visible en pantalla.
- Node2D.translate(Vector2()): modifica position.x y position.y
- Node2D.global_translate(Vector2()): modifica global_position.x y global_position.y. En el caso de un nodo hijo cuyo padre haya sido escalado, esta función hace que la velocidad del hijo no se vea alterada por la escala (aunque es preferible evitar este tipo de situaciones).
- Node2D.look_at(Vector2): hace que el nodo apunte en la dirección seleccionada.
- Node2D.rotate(radianes)
- ProjectSettings.get("ruta"): permite acceder a los valores establecidos en los ajustes del proyecto. Haciendo click derecho sobre cualquier propiedad en Project Settings, aparece la opción "Copy Property Path". Ejemplo para acceder al valor establecido para la gravedad: var _gravity:float = ProjectSettings.get("physics/2d/default_gravity")
- Sprite2D.flip_h
- Sprite2D.flip_v
- Vector2.move_toward(Vector2, float): devuelve un nuevo vector que se dirige a la posicion indicada avazando la cantidad indicada
- Vector2.length(): módulo de un vector.
- Vector2.angle()
- Vector2.normalized(): devuelve un vector con la misma dirección pero de módulo 1.
- Vector2.direction_to(Vector2): devuelve un vector normalizado que sirve para conocer la dirección que une dos puntos.
- VisibleOnScreenNotifier2D: emite señales cuando un objeto entra o sale de la pantalla.