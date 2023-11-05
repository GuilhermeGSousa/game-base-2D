extends Button

func _ready():
	disabled = not SaveManager.has_save_file()

func _pressed():
	SaveManager.load_game()
