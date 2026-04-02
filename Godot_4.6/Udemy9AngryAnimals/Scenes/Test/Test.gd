extends Node

@onready var label: Label = $Label
@onready var rb: RigidBody2D = $RigidBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = str(rb.linear_velocity.y)
