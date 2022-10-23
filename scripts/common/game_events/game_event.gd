extends Resource
class_name GameEvent

signal on_event

func trigger():
	on_event.emit()
	
