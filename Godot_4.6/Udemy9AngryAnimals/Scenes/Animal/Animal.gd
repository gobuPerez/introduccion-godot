class_name Animal

extends RigidBody2D

@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = "Freeze: %s\nContacts: %s\nSleeping: %s" % [freeze, get_contact_count(), sleeping]
	
