class_name BaseHitBox extends Area2D

@export var damage_effects: Array[EmptyEffect]
@export var death_effects: Array[EmptyEffect]
@export var is_imune: bool = false

signal on_damaged(damage: float, damager: Node2D)
signal on_killed()

func _ready() -> void:
	body_shape_entered.connect(_on_body_shape_entered)
	
func on_hit(damage_amount: float, damager: Node2D):
	damage(damage_amount, damager)

func damage(damage_amount: float, damager: Node2D):
	if is_dead(): return ;
	if is_imune: return ;
	
	on_damaged.emit(damage_amount, damager)
	_set_hp(_get_hp() - damage_amount)
	for e in damage_effects:
		if e == null: return
		e.trigger(self)
		
	if is_dead():
		on_killed.emit()
		for e in death_effects:
			if e == null: return
			e.trigger(self)

func is_dead() -> bool:
	return _get_hp() <= 0.0

func _get_hp() -> float:
	return 0.0

func _set_hp(_hp: float):
	pass
	
func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int):
	if body is not TileMap:
		return

	var tilemap: TileMap = body as TileMap
	var tile_coords : Vector2i = tilemap.get_coords_for_body_rid(body_rid)
	
	var tile_data : TileData = tilemap.get_cell_tile_data(0, tile_coords)

	var damage_value = tile_data.get_custom_data("damage")
	damage(damage_value, body)
