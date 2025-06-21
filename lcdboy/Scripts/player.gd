extends Node2D

enum gameStates {
	restart,
	pause, 
	demo,
	play
}

enum playerStates {
	dump,
	left,
	middle,
	right
}

@onready var dump := $Dump 
@onready var left := $Left 
@onready var middle := $Middle 
@onready var right := $Right 

@onready var playerState := playerStates.middle
@onready var gameState := gameStates.restart
@onready var bucketFillLevel := 0
@onready var demoBuffer := 1.0
@onready var buffer := 0.0
@onready var sfx := $Move
@onready var sfxEmpty := $Empty
@onready var sfxBucket := $Bucket
@onready var sfxMiss := $Miss

signal getPoints(points: int)
signal loseLife()


func _ready() -> void:
	allOn()

func _process(delta: float) -> void:
	buffer += delta
	if gameState == gameStates.demo && buffer >= demoBuffer:
		if randi_range(0, 1) == 0:
			moveLeft()
		else:
			moveRight()
		buffer = 0.0
	elif gameState == gameStates.play:
		if Input.is_action_just_pressed("Right"):
			moveRight()
		elif Input.is_action_just_pressed("Left"):
			moveLeft()

func startPlay() -> void:
	gameState = gameStates.play
	playerState = playerStates.middle
	bucketFillLevel = 0
	playCurrentPlayer()
	
func allOn() -> void:
	dump.play("on")
	left.play("3")
	middle.play("3")
	right.play("3")
	gameState = gameStates.restart

func allOff() -> void:
	dump.play("off")
	left.play("off")
	middle.play("off")
	right.play("off")

func startDemo() -> void:
	bucketFillLevel = 0
	gameState = gameStates.demo
	playCurrentPlayer()
	
func playDump() -> void:
	dump.play("on")
	left.play("off")
	middle.play("off")
	right.play("off")
	
	if bucketFillLevel != 0:
		sfxEmpty.play()
	
	match bucketFillLevel:
		1:
			getPoints.emit(2)
		2:
			getPoints.emit(6)
		3: 
			getPoints.emit(10)
	
	bucketFillLevel = 0

func playLeft() -> void:
	dump.play("off")
	left.play(str(bucketFillLevel))
	middle.play("off")
	right.play("off")
	
func playMiddle() -> void:
	dump.play("off")
	left.play("off")
	middle.play(str(bucketFillLevel))
	right.play("off")
	
func playRight() -> void:
	dump.play("off")
	left.play("off")
	middle.play("off")
	right.play(str(bucketFillLevel))

func playCurrentPlayer() -> void:
	match playerState:
		playerStates.dump:
			playDump()
		playerStates.left:
			playLeft()
		playerStates.middle:
			playMiddle()
		playerStates.right:
			playRight()
			
	

func moveLeft() -> void:
	if gameState == gameStates.play:
		sfx.pitch_scale = randf_range(.9, 1.1)
		sfx.play()
	match playerState:
		playerStates.left:
			playerState = playerStates.dump
		playerStates.middle:
			playerState = playerStates.left
		playerStates.right:
			playerState = playerStates.middle
		
	playCurrentPlayer()
	
func moveRight() -> void:
	if gameState == gameStates.play:
		sfx.pitch_scale = randf_range(.9, 1.1)
		sfx.play()
	match playerState:
		playerStates.dump:
			playerState = playerStates.left
		playerStates.left:
			playerState = playerStates.middle
		playerStates.middle:
			playerState = playerStates.right
		
	playCurrentPlayer()

func _on_rain_stream_left_drop_done() -> void:
	if playerState == playerStates.left && bucketFillLevel < 3:
		if gameState == gameStates.play:
			sfxBucket.pitch_scale = randf_range(.9, 1.1)
			sfxBucket.play()
		bucketFillLevel += 1
		playCurrentPlayer()
		getPoints.emit(1)
	else:
		if gameState == gameStates.play:
			sfxMiss.play()
		loseLife.emit()

func _on_rain_stream_middle_drop_done() -> void:
	if playerState == playerStates.middle && bucketFillLevel < 3:
		if gameState == gameStates.play:
			sfxBucket.pitch_scale = randf_range(.9, 1.1)
			sfxBucket.play()
		bucketFillLevel += 1
		playCurrentPlayer()
		getPoints.emit(1)
	else:
		if gameState == gameStates.play:
			sfxMiss.play()
		loseLife.emit()
		

func _on_rain_stream_right_drop_done() -> void:
	if playerState == playerStates.right && bucketFillLevel < 3:
		if gameState == gameStates.play:
			sfxBucket.pitch_scale = randf_range(.9, 1.1)
			sfxBucket.play()
		bucketFillLevel += 1
		playCurrentPlayer()
		getPoints.emit(1)
	else:
		if gameState == gameStates.play:
			sfxMiss.play()
		loseLife.emit()


func _on_left_btn_button_down() -> void:
	if gameState == gameStates.play:
		moveLeft()


func _on_right_btn_button_down() -> void:
	if gameState == gameStates.play:
		moveRight()
