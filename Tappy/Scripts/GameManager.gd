extends Node2D

class_name GameManager

static var vp:Rect2
@onready var pipes_holder: Node = $PipesHolder
@onready var upper_marker: Marker2D = $UpperMarker
@onready var lower_marker: Marker2D = $LowerMarker
const PIPES = preload("res://Scenes/Pipes.tscn")

func _ready() -> void:
	update_vp()
	get_viewport().size_changed.connect(update_vp) # si se modifica las dimensiones de pantalla, se lanza esta señal
	spawn_pipes()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

static func get_vp() -> Rect2:
	return vp;
	
func update_vp() -> void:
	vp = get_viewport_rect()
	
func spawn_pipes() -> void:
	var new_pipes:Pipes = PIPES.instantiate()
	new_pipes.position.x = upper_marker.position.x
	new_pipes.position.y = randf_range(upper_marker.position.y, lower_marker.position.y)
	pipes_holder.add_child(new_pipes)
	
func _on_spawn_timer_timeout() -> void:
	spawn_pipes()

func _on_plane_died() -> void:
	get_tree().paused = true
	
