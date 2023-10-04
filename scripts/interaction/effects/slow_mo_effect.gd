class_name SlowMoEffect extends EmptyEffect

@export var slowmo_time = 0.5
@export var slowmo_scale = 0.5

var original_timescale = -1
var tween : Tween

func trigger(node : Node):
	super(node)

	
	if tween:
		tween.kill()
		
	if original_timescale == -1:
		original_timescale = Engine.time_scale
	
	tween = node.get_tree().root.create_tween()

	tween.tween_callback(
		func ():
			Engine.time_scale = slowmo_scale
	)
	tween.tween_interval(slowmo_time * slowmo_scale)
	tween.tween_callback(
		func ():
			Engine.time_scale = original_timescale
	)
