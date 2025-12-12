extends Node

@onready var pipes_holder: Node = $PipesHolder
@onready var upper_mark: Marker2D = $UpperMark
@onready var lower_mark: Marker2D = $LowerMark

const PIPES = preload("uid://dnokfmil33cmm")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		GameManager.load_main_scene()

func _ready() -> void:
	spawn_pipes()
	
func _on_timer_timeout() -> void:
	spawn_pipes()
	
func spawn_pipes() -> void:
	var new_pipe:Pipes = PIPES.instantiate()
	
	new_pipe.position = Vector2(
		upper_mark.position.x, 
		randf_range(upper_mark.position.y, lower_mark.position.y)
	)
	
	pipes_holder.add_child(new_pipe)
