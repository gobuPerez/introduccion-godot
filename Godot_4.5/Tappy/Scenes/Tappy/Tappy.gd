extends CharacterBody2D

class_name Tappy

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var _gravity:float = ProjectSettings.get("physics/2d/default_gravity")
const JUMP_POWER: float = -500.0
var _jumped:bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("power"):
		_jumped = true
	
	# Deteccion de toques de pantalla en móviles
	if event is InputEventScreenTouch: 
		_jumped = true
		
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	
	velocity.y += _gravity * delta
	
	if _jumped:
		_jumped = false
		velocity.y = JUMP_POWER
		animation_player.play("power")
	
	if is_on_floor() || is_on_ceiling():
		die()
		
	move_and_slide()

func die() -> void:
	#set_physics_process(false)
	#animated_sprite_2d.stop()
	SignalHub.emit_on_plane_died()
	get_tree().paused = true
