extends Node2D

const DICE = preload("res://Scenes/Dice/Dice.tscn")
const GAME_OVER = preload("res://Assets/game_over.wav")

const GROUP_NAME = "stoppable"

@onready var timer: Timer = $Timer
@onready var label: Label = $Label
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var score:int = 0

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
	audio_stream_player.stop()
	audio_stream_player.stream = GAME_OVER
	audio_stream_player.play()
	
func _on_fox_point_scored() -> void:
	score += 1
	label.text = "%04d" % score
