extends CharacterBody2D

const JUMP_POWER:float = -350.0
var _gravity:float = ProjectSettings.get("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.     

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += _gravity * delta
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_POWER
	move_and_slide()
