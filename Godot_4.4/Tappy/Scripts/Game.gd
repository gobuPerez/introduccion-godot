extends Node2D

@onready var pipes_holder: Node = $PipesHolder
@onready var upper_marker: Marker2D = $UpperMarker
@onready var lower_marker: Marker2D = $LowerMarker

const PIPES = preload("res://Scenes/Pipes.tscn")

func _enter_tree() -> void:
	SignalHub.on_plane_died.connect(_on_plane_died)
	
func _ready() -> void:
	get_tree().paused = false
	spawn_pipes()
	
func spawn_pipes() -> void:
	var new_pipes:Pipes = PIPES.instantiate()
	new_pipes.position.x = upper_marker.position.x
	new_pipes.position.y = randf_range(upper_marker.position.y, lower_marker.position.y)
	pipes_holder.add_child(new_pipes)
	
func _on_spawn_timer_timeout() -> void:
	spawn_pipes()

func _on_plane_died() -> void:
	get_tree().paused = true
	
