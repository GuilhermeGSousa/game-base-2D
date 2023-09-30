class_name Projectile extends Node2D

@export var speed : float = 10.0
@export var hurtbox : HurtBox

@export var hit_effects : Array[EmptyEffect]

func _enter_tree():
	if not hurtbox:
		return
	
	hurtbox.on_hit.connect(_on_hit)

func _exit_tree():
	if not hurtbox:
		return
	
	hurtbox.on_hit.disconnect(_on_hit)
	
func _process(delta):
	global_position += get_global_transform().x * speed * delta
	
func _on_hit():
	for effect in hit_effects:
		if effect:
			effect.trigger(self)
