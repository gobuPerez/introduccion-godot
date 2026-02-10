@tool
extends EditorScript


# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
	var ring_bearer:String = "Frodo"
	
	if (ring_bearer == "Sam"):
		print("Sam")
	elif (ring_bearer == "Sauron"):
		print("Sauron")
	else:
		print("Frodo")
		
	var arrows:int = 10
	
	while arrows > 0:
		print("Quedan flechas")
		arrows -= 1
		# break busca el primer bucle y finaliza su ejecución
		
	var fellowship: Array[String] = [
		"Frodo", "Sam", "Aragorn"
	]
	
	for character in fellowship:
		print(character)
		
	for i in range(10): # es lo mismo que range(0,10) = [0,10)
		print(i)
		
	print("---------------------------------")
	for i in range(2,10,2): # del 2 al 9 en saltos de 2
		print(i)
		
	print("---------------------------------")
	for i in range(10, 0,-2): # cuenta regresiva
		print(i)
