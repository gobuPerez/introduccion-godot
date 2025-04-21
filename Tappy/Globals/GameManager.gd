extends Node

const GAME = preload("res://Scenes/Game.tscn")
const MAIN = preload("res://Scenes/UI/Main.tscn")

func load_game_scene() -> void:
	get_tree().change_scene_to_packed(GAME)
	
func load_main_scene() -> void:
	get_tree().change_scene_to_packed(MAIN)
