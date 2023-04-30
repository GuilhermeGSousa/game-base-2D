class_name CameraAreaEvent extends Resource

signal on_event(CameraArea)

func trigger(area : CameraArea):
	on_event.emit(area)
	
