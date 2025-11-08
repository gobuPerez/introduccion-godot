extends Control

@onready var high_score_label: Label = $MarginContainer/HighScoreLabel

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("start_game"):
		GameManager.load_game_scene()
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	high_score_label.text = "%04d" % ScoreManager._high_score
