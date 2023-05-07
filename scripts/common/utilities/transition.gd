class_name Transition extends CanvasLayer

@export var animation : AnimationPlayer

signal on_fade_in
signal on_fade_out

func _ready():
	animation.animation_finished.connect(_on_animation_finished)
	fade_out()

func _on_animation_finished(animation_name : String):
	if animation_name == "FadeIn":
		on_fade_in.emit()
	elif animation_name == "FadeOut":
		on_fade_out.emit()

func fade_in():
	animation.play("FadeIn")
	
func fade_out():
	animation.play("FadeOut")
