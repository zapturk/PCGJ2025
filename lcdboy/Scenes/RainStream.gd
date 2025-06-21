extends Node2D

enum rainPos {
	none,
	top,
	middle,
	bottom
}

enum gameModes {
	demo,
	play
}

@onready var fallSpeed := [2.0, 1.75, 1.5, 1.25, 1.0]
@onready var timer := $Timer
@onready var currentPos := rainPos.none
@onready var currentSpeed := 1.5
@onready var sxf := $AudioStreamPlayer2D
@onready var gameMode := gameModes.demo
signal dropDone()

func newRain() -> void:
	if gameMode == gameModes.play:
		sxf.play()
	$top.play("on")
	currentPos = rainPos.top
	currentSpeed = fallSpeed[randi_range(0, 4)]
	timer.start(currentSpeed)

func _on_timer_timeout() -> void:
	if gameMode == gameModes.demo:
		allOff()
		match randi_range(0,2):
			0:
				$top.play("on")
			1:
				$middle.play("on")
			2:
				$bottom.play("on")
		timer.start()
		
	else:
		match currentPos:
			rainPos.top:
				if gameMode == gameModes.play:
					sxf.play()
				$top.play("off")
				$middle.play("on")
				currentPos = rainPos.middle
				timer.start(currentSpeed)
			rainPos.middle:
				if gameMode == gameModes.play:
					sxf.play()
				$middle.play("off")
				$bottom.play("on")
				currentPos = rainPos.bottom
				timer.start(currentSpeed)
			rainPos.bottom:
				$bottom.play("off")
				currentPos = rainPos.none
				dropDone.emit()

func allOn():
	$top.play("on")
	$middle.play("on")
	$bottom.play("on")
	
func allOff():
	$top.play("off")
	$middle.play("off")
	$bottom.play("off")
	
func startDemo():
	allOff()
	currentPos = rainPos.none
	gameMode = gameModes.demo
	timer.start()
	
func startPlay():
	allOff()
	currentPos = rainPos.none
	gameMode = gameModes.play
