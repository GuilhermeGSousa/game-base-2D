class_name PlatformerController extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Exports
@export var move_speed : float = 300.0
@export var coyote_time : float = 1.0
@export var jump_buffer_time : float = 0.5
@export var jump : BaseJump

@export var hit_box : HitBox

# Private variables
var _can_move : bool = true
var _is_coyote_time : bool = false
var _is_jump_buffered : bool = false
@onready var _coyote_time_tween : Tween = create_tween()
@onready var _jump_buffer_tween : Tween = create_tween()
@onready var _is_on_floor : bool = is_on_floor()
@onready var _is_on_wall : bool = is_on_wall()

signal on_move_ground()
signal on_jump_start()
signal on_jump_end()

func _enter_tree():
	if jump:
		jump.register(self)
	
func _exit_tree():
	if jump:
		jump.unregister()

func _ready():
	_coyote_time_tween.tween_callback(
		func() : _is_coyote_time = true
	)
	_coyote_time_tween.tween_interval(coyote_time)
	_coyote_time_tween.tween_callback(
		func() : _is_coyote_time = false
	)
	_coyote_time_tween.stop()
	
	_jump_buffer_tween.tween_callback(
		func() : _is_jump_buffered = true
	)
	_jump_buffer_tween.tween_interval(jump_buffer_time)
	_jump_buffer_tween.tween_callback(
		func() : _is_jump_buffered = false
	)
	_jump_buffer_tween.stop()
	
	if hit_box:
		hit_box.on_killed.connect(
			func(): _can_move = false
		)

func _physics_process(delta):
	_check_floor()
	_check_wall()
	
	_apply_gravity(delta)
	_apply_jump()
	_apply_movement(delta)

func _check_floor():
	if _is_on_floor and not is_on_floor():
		_on_leave_floor()
		
	if not _is_on_floor and is_on_floor():
		_on_touch_floor()
	
	_is_on_floor = is_on_floor()

func _check_wall():
	if _is_on_wall and not is_on_wall():
		_on_leave_wall()
		
	if not _is_on_wall and is_on_wall():
		_on_touch_wall()
	
	_is_on_wall = is_on_wall()

func _apply_gravity(delta):
	if not _is_on_floor:
		velocity.y += gravity * delta

func _apply_movement(_delta):
	var direction = Input.get_axis("move_left", "move_right") if _can_move else 0.0
	if direction:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)

	if _is_on_floor:
		on_move_ground.emit()
	
	move_and_slide()

func _apply_jump():
	if not _can_move: return
	
	if Input.is_action_just_pressed("jump") or (_is_jump_buffered and _is_on_floor):
		if _can_jump():
			on_jump_start.emit()
			_stop_coyote_time()
			_stop_jump_buffer()
		else:
			_start_jump_buffer()

	elif Input.is_action_just_released("jump"):
		on_jump_end.emit()

func _on_touch_floor():
	_stop_coyote_time()
	
func _on_leave_floor():
	if velocity.y >= 0.0:
		_start_coyote_time()

func _on_touch_wall():
	pass
	
func _on_leave_wall():
	pass

func _can_jump():
	return _is_coyote_time or _is_on_floor
 
func _start_coyote_time():
	_coyote_time_tween.play()
	
func _stop_coyote_time():
	_is_coyote_time = false
	_coyote_time_tween.stop()

func _start_jump_buffer():
	if _is_jump_buffered:
		return
		
	_jump_buffer_tween.play()
	
func _stop_jump_buffer():
	_is_jump_buffered = false
	_jump_buffer_tween.stop()
