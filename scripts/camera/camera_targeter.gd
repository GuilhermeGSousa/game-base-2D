class_name CameraTargeter extends Node

@export var zoom_speed = 0.25  # camera zoom lerp speed
@export var min_zoom : float = 1.5  # camera won't zoom closer than this
@export var max_zoom : float = 5.0  # camera won't zoom farther than this
@export var margin = Vector2(400, 200)  # include some buffer area around targets

@export var targets : Array[NodePath] = []

@onready var camera : Camera2D = get_viewport().get_camera_2d()
@onready var screen_size = camera.get_viewport_rect().size

func _process(_delta):
	if targets != null and !len(targets):
		return
	# Keep the camera centered between the targets
	var p = get_target_point()
	camera.position = p
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
	var aspect_ratio = screen_size.x / screen_size.y
	if r.size.x > r.size.y * aspect_ratio :
		z = clamp(r.size.x / screen_size.x, min_zoom, max_zoom)
	else:
		z = clamp(r.size.y / screen_size.y, min_zoom, max_zoom)
	camera.zoom = lerp(camera.zoom, Vector2.ONE * z, zoom_speed)
