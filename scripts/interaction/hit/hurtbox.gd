extends Area2D

class_name HurtBox

@export var damage : float = 1

func _ready():
	area_entered.connect(on_hit);
	
func on_hit(area : Area2D):
	if area is HitBox:
		area.on_hit(damage)
