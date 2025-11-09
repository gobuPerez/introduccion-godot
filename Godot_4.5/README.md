## 0. Introducción

### Deficiones

- Viewport: rectángulo azul que representa la zona renderizada del videojuego. Todo lo que esté fuera de él no se mostrará durante la partida.

- res:// : directorio donde se encuentra el proyecto. Puede encontrarse en el FileSystem.

### Ajustes de creación del proyecto

Para juegos 2D, el modo "Mobile" es más que suficiente. 

En el menú de la derecha del Project Manager está la opción "Remove". Esta sirve para dejar de mostrar un proyecto en la lista del Project Manager, pero en ningún caso elimina los archivos del proyecto del disco.

### Formato del nombre de scripts y escenas

Puede cambiarse en Project > Project Settings > Editor > Naming. Suelo utilizar el mismo para todo: PascalCase

Este tipo de ajustes se guardan en el archivo project.godot en la raíz del proyecto.

### Layout

Junto a cada ventana del editor hay tres puntos que sirven para elegir la posición en pantalla.

En el caso de cerrar una ventana accidentalmente: Editor > Editor Docks

Para cambiar el tamaño de una fuente y otras opciones del editor: Editor > Editor Settings

Dentro de Editor Settings, buscando "help" en el buscador, se puede acceder al menú para cambiar el tamaño de fuente de la documentación embebida.

Del mismo modo, buscando "output", se puede cambiar el tamaño de fuente de lo que se imprime por consola.

Buscando "zoom", se puede cambiar la velocidad a la que se hace zoom en la pantalla de juego.

Dentro de Editor > Editor Settings, también esta la pestaña "Shortcuts", donde pueden consultarse y modificarse los atajos de teclado.

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

Utilizando un editor de código se pueden abrir los archivos .tscn (escenas) y ver cómo están configuradas.

La escena principal que será renderizada cuando se ejecute el juego se puede seleccionar en Project > Project Settings > Application > Run. También se puede seleccionar haciendo click derecho sobre la escena en el FileSystem > Set as Main Scene

Al ejecutar el juego, dentro de la venta Scene aparecen dos pestañas:

- Remote: muestra los nodos que forman parte del juego durante su ejecución. Es decir, lo que se está renderizando.

- Local: vista normal del árbol de nodos.

Dentro de un mismo nivel del árbol de nodos, dos nodos no pueden tener el mismo nombre.

- Sprite2D: para renderizar imágenes. Es necesario añadir una imagen en la propiedad "Texture". También se puede arrastar una imagen dentro del juego y automáticamente Godot la configura como un Sprite2D.

