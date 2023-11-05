class_name CameraAreaTargeter extends Node

@export var camera : Camera2D
@export var area_entered_even : CameraAreaEvent

func _enter_tree():
	area_entered_even.on_event.connect(on_camera_entered)
	
func _exit_tree():
	area_entered_even.on_event.disconnect(on_camera_entered)

func on_camera_entered(area : CameraArea):
	camera.position = area.collision_shape.position
	
