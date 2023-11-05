@tool
class_name CameraTargeter extends Node

## Affected camera. Will attempt to find a camera if none is provided
@export var camera : Camera2D

## Camera zoom lerp speed
@export_range(0.0, 1.0, 0.01) var zoom_speed = 0.25  

## Camera position lerp speed
@export_range(0.0, 1.0, 0.01)  var position_smoothing_speed = 0.1

## Camera won't zoom farther than this
@export var min_zoom : float = 0.5

## Camera won't zoom closer than this
@export var max_zoom : float = 1.0

## Include some buffer area around targets
@export var margin = Vector2(100, 100)  

@export var targets : Array[NodePath] = []

var _screen_size : Vector2

func _ready():
	if not camera:
		camera = ScriptUtilities.find_child(get_tree().root, "Camera2D") if Engine.is_editor_hint() else get_viewport().get_camera_2d()
	camera.position_smoothing_enabled = false
	_screen_size = camera.get_viewport_rect().size


func _physics_process(_delta):
	if targets != null and !len(targets):
		return
	
	# Keep the camera centered between the targets
	var target := get_target_point()
	var target_dir := target - camera.position
	camera.position = Tween.interpolate_value(
		camera.position, 
		target_dir, 
		position_smoothing_speed, 
		1.0, 
		Tween.TRANS_LINEAR, 
		Tween.EASE_IN_OUT)

	_update_camera_zoom()
	
func add_target(t):
	if not t in targets:
		targets.append(t)

func remove_target(t):
	if t in targets:
		targets.erase(t)

func get_target_point() -> Vector2:
	var p = Vector2.ZERO
	for target in targets:
		var t = get_node(target)
		p += t.position
	p /= targets.size()
	return p

func _update_camera_zoom():
	# Find the zoom that will contain all targets
	var r = Rect2(camera.position, Vector2.ONE)
	for target in targets:
		var t = get_node(target)
		r = r.expand(t.position)
	r = r.grow_individual(margin.x, margin.y, margin.x, margin.y)
	var z
	var aspect_ratio = _screen_size.x / _screen_size.y
	if r.size.x > r.size.y * aspect_ratio :
		z = clamp(_screen_size.x / r.size.x, min_zoom, max_zoom)
	else:
		z = clamp(_screen_size.y / r.size.y, min_zoom, max_zoom)
	camera.zoom = lerp(camera.zoom, Vector2.ONE * z, zoom_speed)
