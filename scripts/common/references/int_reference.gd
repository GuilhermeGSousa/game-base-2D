extends ValueReference
class_name IntReference

@export var _value : int = 0

func _getter():
	return _value
	
func _setter(v):
	on_value_changed.emit(_value, v)
	_value = v
