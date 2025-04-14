extends Node2D

const EXPLODE = preload("res://assets/explode.wav")
const GEM = preload("res://Scenes/Gem.tscn")
const MARGIN:float = 70.0
var _score:int = 0

@onready var spawn_timer: Timer = $SpawnTimer
@onready var paddle: Area2D = $Paddle
@onready var score_sound: AudioStreamPlayer2D = $ScoreSound
@onready var sound: AudioStreamPlayer = $Sound
@onready var score_label: Label = $ScoreLabel

func _ready() -> void:
	spawn_gem() # se instancia una gema nada mas arrancar el juego, sin tener que esperar los dos segundos del timer

func spawn_gem() -> void:
	var random_position:float = randf_range(
		get_viewport_rect().position.x + MARGIN, 
		get_viewport_rect().end.x - MARGIN
	)
	var new_gem:Gem = GEM.instantiate()
	new_gem.position = Vector2(random_position, -50)
	new_gem.gem_off_screen.connect(stop_all)
	add_child(new_gem)
	
func stop_all() -> void:
	spawn_timer.stop()
	paddle.set_process(false)
	sound.stop()
	sound.stream = EXPLODE
	sound.play()
	for child in get_children():
		if child is Gem:
			child.set_process(false) # se detiene la ejecucion de la funcion _process de la escena Gem

func _on_timer_timeout() -> void:
	spawn_gem()

func _on_paddle_area_entered(area: Area2D) -> void:
	score_sound.position = area.position
	if score_sound.playing == false: # nos aseguramos que dos sonidos no se solapen
		score_sound.play()
	_score += 1
	# Puntuacion formateada para que tenga siempre tres cifras
	score_label.text = "%03d" % _score
