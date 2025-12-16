extends Control

class_name GameUi

@onready var game_over_label: Label = $MarginContainer/GameOverLabel
@onready var press_key_label: Label = $MarginContainer/PressKeyLabel
@onready var timer: Timer = $Timer
@onready var game_over_sound: AudioStreamPlayer = $GameOverSound

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		GameManager.load_main_scene()
	if press_key_label.visible && event.is_action_pressed("power"):
		GameManager.load_main_scene()

func _ready() -> void:
	game_over_label.hide()
	press_key_label.hide()
	SignalHub.on_plane_died.connect(on_plane_died)

func on_plane_died() -> void:
	game_over_label.show()
	game_over_sound.play()
	timer.start()

func _on_timer_timeout() -> void:
	game_over_label.hide()
	press_key_label.show()
	print("hola")
	
