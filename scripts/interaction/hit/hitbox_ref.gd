extends BaseHitBox

class_name HitBoxRef

@export var hp : FloatReference

func _get_hp():
	return hp.value
	
func _set_hp(health : float):
	hp.value = health
