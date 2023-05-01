extends Area2D

class_name Interactor

@export var action : String = "use"

signal on_interact

func _process(_delta):
	if Input.is_action_just_pressed(action):
		on_interact.emit()
