class_name TopDownController extends CharacterBody2D

@export var speed = 500.0
@export var knockback_time = 0.5
@export var knockback_speed = 1000.0

var _direction : Vector2

var _kb_direction = Vector2.ZERO
var _kb_timer = 0.0

func _process(delta):
	if _kb_timer > 0:
		_kb_timer -= delta


func _physics_process(_delta):
	var motion
	
	if _kb_timer > 0:
		motion = _kb_direction * knockback_speed
	else:
		motion = Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed
	
	velocity = motion
	move_and_slide()

func set_kickback(direction):
	_kb_direction = direction
