class_name GameEvent extends Resource

signal on_event

func trigger():
	on_event.emit()
	
