extends Area2D

class_name Dice

@onready var sprite_2d: Sprite2D = $Sprite2D

signal game_over

const SCREEN_OFFSET: int = 90
var speed:float = 200.0
var rotation_speed:float = 0.0
var rotation_dir = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.y = -30
	position.x = randf() * get_viewport_rect().size.x
	position.x = clampf(position.x, SCREEN_OFFSET, get_viewport_rect().size.x - SCREEN_OFFSET)
	
	if randf() > 0.5: rotation_dir = -1
	rotation_speed = randf() * PI/2
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.y += speed * delta
	sprite_2d.rotate(rotation_speed * delta * rotation_dir)
	
	if (position.y > get_viewport_rect().end.y + SCREEN_OFFSET):
		die()

func die() -> void:
	game_over.emit()
	set_physics_process(false)
	queue_free()
