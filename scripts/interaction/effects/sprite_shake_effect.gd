class_name ShakeEffect extends EmptyEffect

@export var sprite_path : NodePath
@export var max_amplitude : float = 5.0;
@export var shake_time : float = 1.0;

var tween : Tween

func trigger(node : Node):
	super(node)
	
	var sprite = node.get_node(sprite_path)
	
	if sprite == null or not sprite is Sprite2D: 
		return
	
	if tween:
		tween.kill()
		
	tween = node.get_tree().root.create_tween()
	tween.tween_callback(
		func():
			sprite.material.set_shader_parameter("amplitude", max_amplitude)
	)
	tween.tween_property(
		sprite.material,
		"shader_parameter/amplitude",
		0.0,
		shake_time
	)
	
	
	
