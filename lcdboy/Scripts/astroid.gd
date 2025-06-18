extends Node2D


func _ready() -> void:
	$AnimatedSprite2D.play("off")
	
func turnOff() -> void:
	$AnimatedSprite2D.play("off")
	
func turnOn() -> void:
	$AnimatedSprite2D.play("on")
