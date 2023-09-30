class_name RotationFlipSprite extends Sprite2D

func _process(_delta):
	flip_v = cos(deg_to_rad(get_parent().rotation_degrees)) < 0.0
