class_name CameraShakeEffect extends EmptyEffect

@export var camera_trauma : float = 10.0

func trigger(node : Node):
	super(node)
	CameraShakeManager.on_trauma.emit(camera_trauma)
