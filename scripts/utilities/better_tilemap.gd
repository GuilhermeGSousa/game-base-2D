extends TileMap

var layer_areas: Dictionary = {}
var colliding_areas: Dictionary = {}

func _ready() -> void:
	var layer = 0
	var cells = get_used_cells(layer)

	for c in cells:
		var data: TileData = get_cell_tile_data(layer, c)

		if not data.get_custom_data("is_area"):
			continue
		
		for physics_layer_index in range(tile_set.get_physics_layers_count()):
			if data.get_collision_polygons_count(physics_layer_index) == 0:
				continue
				
			var points = data.get_collision_polygon_points(physics_layer_index, layer)

			if points.is_empty():
				continue
			
			var layer_area = layer_areas.get(physics_layer_index)
			if not layer_area:
				layer_area = Area2D.new()
				var collision_layer = tile_set.get_physics_layer_collision_layer(physics_layer_index)
				var collision_mask = tile_set.get_physics_layer_collision_mask(physics_layer_index)
				layer_area.collision_layer = collision_layer
				layer_area.collision_mask = collision_mask
				layer_area.area_exited.connect(_on_area_exited)
				layer_area.area_shape_entered.connect(_on_area_shape_entered.bind(data))
				
				layer_areas[physics_layer_index] = layer_area
				add_child(layer_area)
				
			var collision_shape = CollisionPolygon2D.new()
			
			for i in range(len(points)):
				points[i] *= Vector2(tile_set.tile_size)
			
			collision_shape.polygon = points
			collision_shape.position = c * tile_set.tile_size + tile_set.tile_size / 2

			layer_area.add_child(collision_shape)

func _on_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int, tile_data: TileData):
	if colliding_areas.has(area) and colliding_areas[area]:
		return
	
	if area is HitBox:
		area.damage(tile_data.get_custom_data("damage"), self)
	
	colliding_areas[area] = true

func _on_area_exited(area: Area2D):
	colliding_areas[area] = false
