class_name GridPushObject extends Area2D

@export var tilemap : TileMap

@onready var _ray : RayCast2D = ScriptUtilities.find_child(self, "RayCast2D")
@onready var _tile_size = tilemap.tile_set.tile_size.x

func _ready():
	# Snap to the center of a tile
	var local_pos = tilemap.to_local(global_position)
	var map_pos = tilemap.local_to_map(local_pos)
	local_pos = tilemap.map_to_local(map_pos)
	global_position = tilemap.to_global(local_pos)
	print(position)

func push(dir : Vector2, move_time : float):
	var move_dir = dir.normalized() * _tile_size
	_ray.target_position = move_dir
	_ray.force_raycast_update()
	
	if !_ray.is_colliding():
		var new_pos = global_position + move_dir
		var tween = create_tween()	
		tween.tween_property(
			self, "global_position",
			global_position + move_dir,
			move_time
		).set_trans(Tween.TRANS_SINE)
		await tween.finished
