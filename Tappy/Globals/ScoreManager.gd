extends Node

var _high_score:int = 0

func update_score(value:int) -> void:
	if (value > _high_score):
		_high_score = value
