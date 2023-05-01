class_name BaseJump extends Resource

@export var jump_speed = 300.0

var controller : PlatformerController

func register(platformer_controller : PlatformerController):
	controller = platformer_controller
	controller.on_jump_start.connect(_start_jump)
	controller.on_jump_end.connect(_end_jump)

func unregister():
	controller.on_jump_start.disconnect(_start_jump)
	controller.on_jump_end.disconnect(_end_jump)

func _start_jump():
	controller.velocity.y = -jump_speed
	
func _end_jump():
	if controller.velocity.y <= 0:
		controller.velocity.y = 0
