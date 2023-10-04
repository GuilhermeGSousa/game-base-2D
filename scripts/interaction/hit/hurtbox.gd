class_name HurtBox extends Area2D

@export var damage : float = 1

signal on_hit()

func _ready():
	area_entered.connect(_on_hit);
	
func _on_hit(area : Area2D):
	if area is HitBox:
		area.on_hit(damage, self)
		on_hit.emit()
