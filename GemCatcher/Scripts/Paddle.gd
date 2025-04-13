extends Area2D

const SPEED:float = 350.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Input.is_action_pressed("move_left"):
	#	position.x -= SPEED * delta
	#if Input.is_action_pressed("move_right"):
	#	position.x += SPEED * delta
	# movement va a ser -1 o 1
	var movement:float = Input.get_axis("move_left", "move_right")
	position.x += SPEED * delta * movement
	position.x = clampf(position.x, get_viewport_rect().position.x, get_viewport_rect().end.x)
