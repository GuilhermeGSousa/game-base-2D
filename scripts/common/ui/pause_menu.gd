class_name PauseMenu extends CanvasLayer

func _ready():
	resume()

func _input(event : InputEvent):
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused: resume()
		else : pause()

func pause():
	get_tree().paused = true
	visible = true
	
func resume():
	get_tree().paused = false
	visible = false
