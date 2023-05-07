class_name BaseHitBox extends Area2D

@export var damage_effects : Array[EmptyEffect]
@export var is_imune : bool = false

signal on_damaged(damage : float)
signal on_killed()

func on_hit(damage_amount : float):
	damage(damage_amount)

func damage(damage_amount : float):
	if is_dead() : return;
	if is_imune : return;
	
	on_damaged.emit(damage_amount)
	_set_hp(_get_hp() - damage_amount)
	for e in damage_effects:
		if e == null : return
		e.trigger(self)
		
	if is_dead():
		on_killed.emit()

func is_dead() -> bool:
	return _get_hp() <= 0.0

func _get_hp() -> float:
	return 0.0

func _set_hp(hp : float):
	pass
	
