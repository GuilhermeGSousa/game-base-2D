@tool

extends AspectRatioContainer

func _ready() -> void:
	var viewport_width = ProjectSettings.get_setting("display/window/size/viewport_width")
	var viewport_height = ProjectSettings.get_setting("display/window/size/viewport_height")
	
	size = Vector2(viewport_width, viewport_height)
