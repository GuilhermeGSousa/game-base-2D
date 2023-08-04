class_name Bullet extends Node2D

@export var speed : float = 10.0

func _process(delta):
	global_position += get_global_transform().x * speed * delta
