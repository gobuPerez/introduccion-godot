extends Area2D

class_name Gem

const SPEED: float = 150.0

signal gem_off_screen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += (SPEED * delta)
	
	if position.y > get_viewport_rect().end.y: # si la posicion esta por debajo del limite inferior de la pantalla
		# print("La gema alcanza el limite inferior de la pantalla.")
		gem_off_screen.emit()
		die()

func die() -> void:
	set_process(false)
	queue_free()

func _on_area_entered(_area: Area2D) -> void:
	die()
