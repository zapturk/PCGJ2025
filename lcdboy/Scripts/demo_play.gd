extends AnimatedSprite2D


func allOn() -> void:
	play("on")
	
func allOff() -> void:
	play("off")

func startDemo() -> void:
	play("demo")

func  startPlay() -> void:
	play("play")
