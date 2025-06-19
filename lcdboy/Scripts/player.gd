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
		if Input.is_action_just_pressed("ui_right"):
			moveRight()
		elif Input.is_action_just_pressed("ui_left"):
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
	gameState = gameStates.demo
	playCurrentPlayer()
	
func playDump() -> void:
	dump.play("on")
	left.play("off")
	middle.play("off")
	right.play("off")
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
	match playerState:
		playerStates.left:
			playerState = playerStates.dump
		playerStates.middle:
			playerState = playerStates.left
		playerStates.right:
			playerState = playerStates.middle
		
	playCurrentPlayer()
	
func moveRight() -> void:
	match playerState:
		playerStates.dump:
			playerState = playerStates.left
		playerStates.left:
			playerState = playerStates.middle
		playerStates.middle:
			playerState = playerStates.right
		
	playCurrentPlayer()
