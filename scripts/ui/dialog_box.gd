class_name DialogBox extends Control

@export var is_on : bool = false
@export var text : Label
@export var scroll_duration : float = 1.0

var text_scroll_tween : Tween

func _ready():
	is_on = false
	
func set_text(val : String):
	text.text = val
	
	if text_scroll_tween:
		text_scroll_tween.kill()
		
	text_scroll_tween = create_tween()
	text_scroll_tween.tween_callback(
		func():
			text.visible_ratio = 0.0
	)
	text_scroll_tween.tween_property(
		text,
		"visible_ratio",
		1.0,
		scroll_duration
	)
	
