class_name ValueReference extends Resource

signal on_value_changed(old, new)

var value :
	get:
		_getter()
	set(v):
		_setter(v)

func _getter():
	pass

func _setter(_v):
	pass
