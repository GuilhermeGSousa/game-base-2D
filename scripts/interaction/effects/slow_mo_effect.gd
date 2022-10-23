class_name SlowMoEffect extends Effect

@export var slowmo_time = 0.5
@export var slowmo_scale = 0.5

func trigger():
	super()
	var t = create_tween()
	var original_timescale = Engine.time_scale
	
	t.tween_callback(
		func ():
			Engine.time_scale = slowmo_scale
	)
	t.tween_interval(slowmo_time * slowmo_scale)
	t.tween_callback(
		func ():
			Engine.time_scale = original_timescale
	)
