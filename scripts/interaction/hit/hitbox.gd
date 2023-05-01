class_name HitBox extends BaseHitBox

@export var hp : float = 1

func on_hit(damage : float):
	super(damage)

func _get_hp():
	return hp
	
func _set_hp(health):
	hp = health
