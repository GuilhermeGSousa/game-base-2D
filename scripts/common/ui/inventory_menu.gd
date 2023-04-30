class_name InventoryMenu extends Control

@export var is_on : bool = true

func _ready():
	is_on = false

func _input(event : InputEvent):
	if event.is_action_pressed("open_inventory"):
		is_on = !is_on
