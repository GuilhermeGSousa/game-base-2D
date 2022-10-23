extends Camera2D

@export var texture : Texture2D

func _process(_delta):
	
	var img = get_viewport().get_texture().get_image()
	texture.get_image().create_from(img)
	
