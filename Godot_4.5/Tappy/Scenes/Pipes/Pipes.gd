extends Node2D

class_name Pipes

var pipes_speed:float = 200.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.x -= pipes_speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	set_physics_process(false)
	queue_free()

func _on_pippe_body_entered(body: Node2D) -> void:
	if body is Tappy:
		body.die()


func _on_laser_body_exited(body: Node2D) -> void:
	if body is Tappy:
		print("Punto anotado")
