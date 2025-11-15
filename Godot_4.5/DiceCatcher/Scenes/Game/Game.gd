extends Node2D

const DICE = preload("res://Scenes/Dice/Dice.tscn")
const GROUP_NAME = "stoppable"

@onready var timer: Timer = $Timer

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

func _ready() -> void:
	spawn_dice()

func spawn_dice() -> void:
	var new_dice:Dice = DICE.instantiate()
	new_dice.game_over.connect(_on_gamer_over)
	add_child(new_dice)
	
func pause_all() -> void:
	var to_stop:Array[Node] = get_tree().get_nodes_in_group(GROUP_NAME)
	for item in to_stop:
		item.set_physics_process(false)

func _on_timer_timeout() -> void:
	spawn_dice()

func _on_gamer_over() -> void:
	timer.stop()
	pause_all()
	
	
