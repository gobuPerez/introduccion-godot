extends Node2D

@onready var plane: Sprite2D = $Plane
@onready var helicopter: Sprite2D = %Helicopter
@onready var plane_2: Sprite2D = $Plane2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Hola mundo")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	plane.position.x = plane.position.x + 50.0 * delta
	helicopter.global_rotation_degrees += 30.0 * delta # se suma en grados
	# helicopter.global_rotation += 0.5 * delta # se suma en radianes
	print("Rotacion en grados: ", helicopter.global_rotation_degrees)
	print("Pasando rotacion a grados: ", rad_to_deg(helicopter.global_rotation))
	plane_2.translate(Vector2(25, 30)*delta) # position.x += 25 * delta, position.y += 30 * delta
	# plane_2.global_translate(Vector2(25, 25)*delta)
