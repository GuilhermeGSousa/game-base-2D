extends Control

enum Menu { MAIN_MENU, SETTINGS_MENU }

@export var start_scene_path : String
@export var transition_path : String

var current_menu : Menu = Menu.MAIN_MENU

func _on_start_button_pressed():
	SceneTransitionManager.change_scene_with_transition(
		start_scene_path,
		transition_path
	)

func _on_exit_pressed():
	get_tree().quit()


func _on_settings_pressed():
	current_menu = Menu.SETTINGS_MENU


func _on_return_main_menu_button_pressed():
	current_menu = Menu.MAIN_MENU
