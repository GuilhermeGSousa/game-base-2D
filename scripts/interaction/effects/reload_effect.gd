class_name ReloadEffect extends EmptyEffect

func trigger(_node : Node):
	SaveManager.load_game()
