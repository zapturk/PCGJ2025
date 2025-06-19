extends Node2D

enum state {
	restart,
	demo,
	play,
	pause
}

@onready var currentState := state.restart
@onready var player := $WaterPlayer
@onready var demoPlay := $DemoPlay

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	allOn()
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if currentState == state.demo && Input.is_action_just_pressed("ui_accept"):
		startPlay()
	
	if currentState == state.play && Input.is_action_just_pressed("restart"):
		allOn()
		currentState = state.restart
		$Timer.start()


func _on_timer_timeout() -> void:
	if currentState == state.restart:
		allDemo()
		

func allOn() -> void:
	player.allOn()
	demoPlay.allOn()

func allDemo() -> void:
	player.startDemo()
	demoPlay.startDemo()
	currentState = state.demo

func startPlay() -> void:
	player.startPlay()
	demoPlay.startPlay()
	currentState = state.play
