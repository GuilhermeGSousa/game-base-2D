class_name DestroyEffect extends EmptyEffect

@export var nodes_to_destroy : Array[NodePath]
@export var destroy_self : bool = false

func trigger(node : Node):
	
	for n in nodes_to_destroy:
		node.get_node(n).queue_free()
		
	if destroy_self:
		node.queue_free()
