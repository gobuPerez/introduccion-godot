extends Node2D

@onready var plane: Sprite2D = $Plane
@onready var helicopter: Sprite2D = $Helicopter
@onready var plane_2: Sprite2D = $Plane2
@onready var plane_3: Sprite2D = $Plane3
@onready var plane_4: Sprite2D = $Plane4

var target: Vector2 = Vector2.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("setTarget"):
		target = get_global_mouse_position()
		plane.look_at(target)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	plane.position.x = plane.position.x + 50.0 * delta
	helicopter.global_rotation_degrees += 30.0 * delta # se suma en grados
	# helicopter.global_rotation += 0.5 * delta # se suma en radianes
	print("Rotacion en grados: ", helicopter.global_rotation_degrees)
	print("Pasando rotacion a grados: ", rad_to_deg(helicopter.global_rotation))
	plane_2.translate(Vector2(25, 30)*delta) # position.x += 25 * delta, position.y += 30 * delta
	# plane_2.global_translate(Vector2(25, 25)*delta)
	plane_3.position = plane_3.position.move_toward(target, 50 * delta)
	if Input.is_action_pressed("ui_right"):
		plane_4.rotate(deg_to_rad(90)*delta)
