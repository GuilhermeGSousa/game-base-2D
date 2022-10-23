class_name ShakeEffect extends Effect

@export var sprite : Sprite2D
@export var max_amplitude : float = 5.0;
@export var shake_time : float = 1.0;

func trigger():
	super()
	var t = create_tween()
	
	sprite.material.set_shader_parameter("amplitude", max_amplitude)
	t.tween_property(
		sprite.material,
		"shader_parameter/amplitude",
		0.0,
		shake_time
	)
