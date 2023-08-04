class_name BoolReference extends ValueReference

@export var _value : bool = false

func _getter():
	return _value
	
func _setter(v):
	on_value_changed.emit(_value, v)
	_value = v
