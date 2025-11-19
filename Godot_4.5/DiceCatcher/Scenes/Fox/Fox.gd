extends Area2D

class_name Fox

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var sounds: AudioStreamPlayer2D = $Sounds

signal point_scored 

const SPEED:float = 200.0

func _physics_process(delta: float) -> void:
	#if Input.is_action_pressed("ui_right"):
	#	position.x += SPEED * delta
	#if Input.is_action_pressed("ui_left"):
	#	position.x += SPEED * delta * -1
	
	var direction = Input.get_axis("ui_left", "ui_right")
	
	position.x += direction * SPEED * delta
	
	if is_zero_approx(direction):
		sprite_2d.flip_h = direction > 0.0


func _on_area_entered(area: Area2D) -> void:
	if area is Dice:
		sounds.play()
		area.queue_free()
		point_scored.emit()
