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

Para cambiar el formato del nombre de los archivos (PascalCase, snake_case,...), Project Settings (activar opciones avanzadas) > Editor > Naming > Scene Name 

Al arrastrar un nodo desde el árbol de nodos y soltarlo mantiendo pulsado control, se crea una referencia a ese nodo.

Es una buena práctica crear las escenas del juego con el botón de crear en vez de arrastrando los assets a la pantalla de juego. Esto nos asegura que el centro esté centrado.

### Area2D
Se utiliza para detectar colisiones en 2 dimensiones. Debe tener como hijo un CollisionShape2D. Posteriormente hay que seleccionar la propiedad shape de este último nodo.

En el menú superior, en la opción Debug, se puede activar la opción Visible Collision Shapes para ver los collision shapes durante el desarrollo y la ejecución del juego.

set_process(false) detiene la ejecución de la función _process() cada frame.

Al llamar a queue_free() en una escena, esta y todos sus hijos son eliminados. En realidad queue_free() pone a las escenas en una cola para ser eliminadas, lo que no tiene que producirse inmediatamente. Por eso es buena práctica detener la ejecución de la función _process() primero para evitar efectos inesperados.

Con get_viewport() se puede comprobar cuando un nodo alcanza el limite de la pantalla.

# Controles

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