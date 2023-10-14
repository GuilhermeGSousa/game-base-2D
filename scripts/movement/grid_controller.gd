class_name GridController extends Area2D

@export var tilemap : TileMap

@export var move_time = 0.2

var _inputs = {
	"move_right": Vector2.RIGHT,
	"move_left": Vector2.LEFT,
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN
	}

@onready var _ray : RayCast2D = ScriptUtilities.find_child(self, "RayCast2D")
@onready var _tile_size = tilemap.tile_set.tile_size.x

var _is_moving_or_pushing = false
var _dir = ""

func _ready():
	# Snap to the center of a tile
	var local_pos = tilemap.to_local(global_position)
	var map_pos = tilemap.local_to_map(local_pos)
	local_pos = tilemap.map_to_local(map_pos)
	global_position = tilemap.to_global(local_pos)

func _process(delta):
	if _is_moving_or_pushing:
		return
	
	_dir = ""
	for dir in _inputs.keys():
		if Input.is_action_pressed(dir):
			_dir = dir

	_move()

func _move():
	if _dir == "":
		return

	_ray.target_position = _inputs[_dir] * _tile_size
	_ray.force_raycast_update()
	
	if !_ray.is_colliding():
		var tween = create_tween()
		tween.tween_property(
			self, "position",
			position + _inputs[_dir] * _tile_size,
			move_time
		).set_trans(Tween.TRANS_SINE)
		_is_moving_or_pushing = true
		await tween.finished
		_is_moving_or_pushing = false
	else:
		var col = _ray.get_collider()
		if col is GridPushObject:
			_is_moving_or_pushing = true
			await col.push(_inputs[_dir], move_time)
			_is_moving_or_pushing = false

func _get_configuration_warnings():
	var warnings : PackedStringArray = super._get_configuration_warnings()
	
	# Check hand for mesh instance
	if not ScriptUtilities.find_child(self, "Raycast2D"):
		warnings.append("Node does not have a Raycast2D")
	
	return warnings
