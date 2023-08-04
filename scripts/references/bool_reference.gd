class_name FloatReference extends ValueReference

@export var _value : float = 0

func _getter():
	return _value
	
func _setter(v):
	on_value_changed.emit(_value, v)
	_value = v
