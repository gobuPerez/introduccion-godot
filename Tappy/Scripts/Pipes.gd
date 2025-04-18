extends Node2D

class_name Pipes

const SPEED: float = 200.0
const MARGIN: float = 50.0

func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= SPEED * delta
	if position.x < GameManager.get_vp().position.x - 50:
		die()

func die() -> void:
	set_process(false)
	queue_free()

func _on_pipe_body_entered(body: Node2D) -> void:
	if body is PlanePlayer:
		body.die()
