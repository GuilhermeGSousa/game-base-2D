class_name ColorFlickerEffect extends EmptyEffect

@export var sprite_path : NodePath
@export var flicker_time : float = 1.0;

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
			sprite.material.set_shader_parameter("is_flickering", true)
	)
	tween.tween_interval(flicker_time)
	tween.tween_callback(
		func():
			sprite.material.set_shader_parameter("is_flickering", false)
	)
