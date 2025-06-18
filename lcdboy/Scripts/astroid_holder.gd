extends Node2D

var astroids := []
var currentSpot := 0

func _ready() -> void:
	astroids = get_children()
	$Timer.start()



func _on_timer_timeout() -> void:
	if currentSpot == 0:
		currentSpot += 1
		astroids[currentSpot].turnOn()
		$Timer.start()
		return
		
	astroids[currentSpot].turnOff()
	
	if currentSpot == get_child_count() -1:
		currentSpot = 0
	else:
		currentSpot += 1
		astroids[currentSpot].turnOn()
		
	
	$Timer.start()
