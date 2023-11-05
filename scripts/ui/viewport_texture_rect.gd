class_name ViewportTextureRect extends TextureRect


@export var viewport : SubViewport

func _ready():
	texture = viewport.get_texture()
