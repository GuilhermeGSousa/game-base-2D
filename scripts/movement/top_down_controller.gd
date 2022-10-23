extends CharacterBody2D

class_name TopDownController

@export var speed = 500.0

var direction : Vector2

func _process(_delta):
	pass

func _physics_process(_delta):
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
