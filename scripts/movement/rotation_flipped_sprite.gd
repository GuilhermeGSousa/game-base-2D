extends Sprite2D

var parent_node : Node2D

func _ready():
	parent_node = get_parent()
	
func _process(_delta):
	
	if cos(deg_to_rad(parent_node.rotation_degrees)) < 0.0:
		scale.y = -1 * abs(scale.y)
	else :
		scale.y = 1  * abs(scale.y)
