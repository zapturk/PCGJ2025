extends Node2D

enum state {
	start,
	demo,
	inGame
}

@onready var currentState := state.start
@onready var player := $WaterPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.allOn()
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if currentState == state.start:
		player.startDemo()
		
