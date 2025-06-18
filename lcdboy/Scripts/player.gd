extends Node2D

enum gameStates {
	start, 
	demo,
	inGame
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
@onready var timer := $Timer

@onready var playerState := playerStates.middle
@onready var gameState := gameStates.start


func _ready() -> void:
	allOn()

func _process(delta: float) -> void:
	if gameState == gameStates.demo:
		playCurrentPlayer()
	

func gameStart() -> void:
	allOff()
	timer.start()
	await $Timer.timeout
	gameState = gameStates.start
	
func allOn() -> void:
	dump.play("on")
	left.play("3")
	middle.play("3")
	middle.play("3")

func allOff() -> void:
	dump.play("off")
	left.play("off")
	middle.play("off")
	middle.play("off")

func startDemo() -> void:
	timer.start()
	await $Timer.timeout
	gameState = gameStates.demo
	
func playDump() -> void:
	dump.play("on")
	left.play("off")
	middle.play("off")
	middle.play("off")

func playLeft() -> void:
	dump.play("on")
	left.play("off")
	middle.play("off")
	middle.play("off")
	
func playCurrentPlayer() -> void:
	match playerState:
		playerStates.dump:
			playDump()
			
	
