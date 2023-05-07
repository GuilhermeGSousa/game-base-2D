class_name CameraShaker extends Node

@export_range(0, 10) var decay_rate = 1
@export var max_offset = Vector2(100, 100) 
@export var max_roll = 0.1
@export var power : float = 2

@onready var camera : Camera2D = get_viewport().get_camera_2d()

var noise : FastNoiseLite = FastNoiseLite.new()

var noise_y = 0
var trauma = 0.0

func _enter_tree():
	CameraShakeManager.on_trauma.connect(add_trauma)

func _exit_tree():
	CameraShakeManager.on_trauma.disconnect(add_trauma)
	
func _ready():
	randomize()
	noise.seed = randi()
	noise.frequency = 0.5
	noise.domain_warp_fractal_octaves = 2
	
func _process(delta):
	if trauma:
		trauma = max(trauma - decay_rate * delta, 0)
		_shake()


func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)

func _shake():
	var amount = pow(trauma, power)
	
	var s = camera.offset
	camera.rotation = max_roll * amount * noise.get_noise_2dv(s)
	camera.offset.x = max_offset.x * amount * noise.get_noise_2dv(s)
	camera.offset.y = max_offset.y * amount * noise.get_noise_2dv(s + Vector2.ONE)
