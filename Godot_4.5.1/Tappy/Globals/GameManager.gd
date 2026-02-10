extends Node

const GAME = preload("uid://bwf4dqilj5ml4")
const MAIN = preload("uid://cxt5x3kdbarw8")

func load_game_scene() -> void:
	get_tree().change_scene_to_packed(GAME)
	
func load_main_scene() -> void:
	get_tree().change_scene_to_packed(MAIN)
