extends Node2D

class_name Pipes

const SPEED: float = 200.0
const MARGIN: float = 50.0
@onready var laser: Area2D = $Laser

func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= SPEED * delta
	if position.x < get_viewport_rect().position.x - 50:
		die()

func die() -> void:
	set_process(false)
	queue_free()

func _on_pipe_body_entered(body: Node2D) -> void:
	if body is PlanePlayer:
		body.die()

func _on_laser_body_entered(body: Node2D) -> void:
	if body is PlanePlayer:
		# se desconecta la señal para evitar que los jugadores hagan 2 puntos en una misma tuberia
		laser.body_entered.disconnect(_on_laser_body_entered)
		SignalHub.on_point_scored.emit()
