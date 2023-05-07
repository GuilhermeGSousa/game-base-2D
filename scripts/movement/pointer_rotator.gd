class_name PointerRotator extends Node2D

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	
	look_at(get_global_mouse_position())
