extends Control

@onready var game_over: Label = $MarginContainer/GameOver
@onready var press_space: Label = $MarginContainer/PressSpace
@onready var timer: Timer = $Timer
@onready var score_label: Label = $MarginContainer/Score

var _score:int = 0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		GameManager.load_game_scene()
	elif event.is_action_pressed("jump") and press_space.visible:
		GameManager.load_main_scene()		
		
func _enter_tree() -> void:
	SignalHub.on_plane_died.connect(on_plane_died)
	SignalHub.on_point_scored.connect(increase_score)

func _ready() -> void:
	_score = 0
	
func on_plane_died() -> void:
	game_over.show()
	timer.start()

func _on_timer_timeout() -> void:
	game_over.hide()
	press_space.show()
	
func increase_score() -> void:
	_score += 1
	score_label.text = "%04d" % _score
