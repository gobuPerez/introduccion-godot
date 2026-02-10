extends Control

@onready var high_score_value: Label = $MarginContainer/HighScoreValue

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("power"):
		GameManager.load_game_scene()

func _ready() -> void:
	get_tree().paused = false
	high_score_value.text = "%03d" % ScoreManager.high_score
