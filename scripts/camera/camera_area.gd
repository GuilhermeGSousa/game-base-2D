class_name CameraArea extends Area2D

@export var trigger_group: String = "player"
@export var area_enter: CameraAreaEvent
@export var area_exit: CameraAreaEvent

@onready var camera = get_viewport().get_camera_2d()
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var _is_active: bool = false

func _enter_tree():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _exit_tree():
	area_entered.disconnect(_on_area_entered)
	area_exited.disconnect(_on_area_exited)

func _physics_process(_delta):
	if not _is_active: return
	
	var area_rect = collision_shape.shape.get_rect()
	var area_size = area_rect.size
	var area_center = collision_shape.global_position
	var viewport_size = _get_viewport_size()
	var cam_size = viewport_size

	var left_edge = area_center - area_size / 2.
	var right_edge = area_center + area_size / 2.

	if cam_size.x > area_size.x:
		camera.position.x = area_center.x
	else:
		camera.position.x = clamp(
			camera.position.x,
			left_edge.x + cam_size.x / 2.,
			right_edge.x - cam_size.x / 2.)
	
	if cam_size.y > area_size.y:
		camera.position.y = area_center.y
	else:
		camera.position.y = clamp(
			camera.position.y,
			left_edge.y + cam_size.y / 2.,
			right_edge.y - cam_size.y / 2.)
	
	camera.align()
	
func _on_area_entered(area: Area2D):
	if not area.is_in_group(trigger_group): return
	_is_active = true
	if area_enter: area_enter.trigger(self)
	
func _on_area_exited(area: Area2D):
	if not area.is_in_group(trigger_group): return
	_is_active = false
	if area_exit: area_exit.trigger(self)
	
func _get_viewport_size() -> Vector2:
	return get_viewport_transform().affine_inverse().basis_xform(get_viewport_rect().size)
