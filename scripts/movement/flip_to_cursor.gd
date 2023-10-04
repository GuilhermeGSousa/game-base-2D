class_name FlipToCursor extends Node2D

func _process(_delta):
	var mouse_pos = get_global_mouse_position()
	var angle = abs(global_position.angle_to_point(mouse_pos))
	if angle >= PI / 2:
		scale.x = -1 * abs(scale.x)
	elif angle < PI / 2:
		scale.x = abs(scale.x)
