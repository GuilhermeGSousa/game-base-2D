class_name Dialogbox extends Control

@export var is_on : bool = false
@export var text : Label

func _ready():
	is_on = false

func set_text(val : String):
	text.text = val
