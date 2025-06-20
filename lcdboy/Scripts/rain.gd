extends Node2D

enum state {
	restart,
	demo,
	play,
	pause
}

@onready var currentState := state.restart
@onready var player := $WaterPlayer
@onready var rainLeft := $RainStreamLeft
@onready var rainMiddle := $RainStreamMiddle
@onready var rainRight := $RainStreamRight
@onready var playDemo := $PlayDemo
@onready var points := 0
@onready var lives := 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	allOn()
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Score.text = str(points).pad_zeros(4)
	
	if currentState == state.demo && Input.is_action_just_pressed("ui_accept"):
		startPlay()
	
	if currentState == state.play && Input.is_action_just_pressed("restart"):
		allOn()
		currentState = state.restart
		points = 0
		$Timer.start()


func _on_timer_timeout() -> void:
	if currentState == state.restart:
		allDemo()
	
	elif currentState == state.play:
		match randi_range(0, 2):
			0:
				if rainLeft.currentPos == rainLeft.rainPos.none:
					rainLeft.newRain()
			1:
				if rainMiddle.currentPos == rainMiddle.rainPos.none:
					rainMiddle.newRain()
			2:
				if rainRight.currentPos == rainRight.rainPos.none:
					rainRight.newRain()

func allOn() -> void:
	player.allOn()
	rainLeft.allOn()
	rainMiddle.allOn()
	rainRight.allOn()
	playDemo.text = "8888"
	points = 8888

func allDemo() -> void:
	player.startDemo()
	rainLeft.startDemo()
	rainMiddle.startDemo()
	rainRight.startDemo()
	playDemo.text = "DEMO"
	currentState = state.demo
	points = 0

func startPlay() -> void:
	player.startPlay()
	rainLeft.startPlay()
	rainMiddle.startPlay()
	rainRight.startPlay()
	playDemo.text = "PLAY"
	points = 0
	currentState = state.play
	$Timer.start(1.5)


func _on_water_player_get_points(newPoints: int) -> void:
	points += newPoints
