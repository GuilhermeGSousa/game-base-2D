class_name KillEffect extends EmptyEffect

func trigger(node : Node):
	node.queue_free()
