@tool
extends EditorScript

# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
	var age:int = 10
	var degrees := 2 # godot deduce el tipo de dato
	var name:String = "Juan"
	@warning_ignore("unused_variable")
	var health:float = 100.5
	var _is_alive:bool = true
	var is_dead:bool = !_is_alive
	
	print("Age: ", type_string(typeof(age)))
	print("Degress:", type_string(typeof(degrees)))
	print(name)
	print(is_dead)
