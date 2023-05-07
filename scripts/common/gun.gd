class_name Gun extends Node2D

@export var bullet_scene : PackedScene

@export_group("Effects") 
@export var shoot_effects : Array[EmptyEffect]

func _input(event):
	if not event.is_action_pressed("shoot") : return
	if bullet_scene == null: return
	
	var bullet : Node2D = bullet_scene.instantiate() as Node2D
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = global_position
	bullet.global_rotation = get_parent().global_rotation
	
	for effect in shoot_effects:
		if effect == null: continue
		effect.trigger(self)
