class_name ReloadEffect extends EmptyEffect

func trigger(node : Node):
	SaveManager.load_game()
