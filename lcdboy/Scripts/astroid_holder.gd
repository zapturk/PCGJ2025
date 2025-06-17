extends Node2D

var astroids := []
var currentSpot := 0

func _ready() -> void:
	astroids = get_children()
	$Timer.start()



func _on_timer_timeout() -> void:
	
	
	astroids[currentSpot].on = true
	
