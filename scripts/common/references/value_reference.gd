extends Resource
class_name ValueReference

signal on_value_changed(old, new)

var value :
	get:
		_getter()
	set(v):
		_setter(v)

func _getter():
	pass

func _setter(v):
	pass
