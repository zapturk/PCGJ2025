extends Node2D

@onready var rain := preload("res://Scenes/rain.tscn")
var currentGame: Node2D


func _ready() -> void:
	currentGame = rain.instantiate()
	add_child(currentGame)
