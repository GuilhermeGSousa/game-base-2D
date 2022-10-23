extends Control

enum Menu { MAIN_MENU, SETTINGS_MENU }

@export var start_button : Button
@export var settings_button : Button
@export var exit_button : Button

@export var start_scene_path : PackedScene
@export var transition_path : PackedScene

var current_menu : Menu = Menu.MAIN_MENU

func _enter_tree():
	start_button.pressed.connect(_on_start_button_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	exit_button.pressed.connect(_on_exit_pressed)
	
func _exit_tree():
	start_button.pressed.disconnect(_on_start_button_pressed)
	settings_button.pressed.disconnect(_on_settings_pressed)
	exit_button.pressed.disconnect(_on_exit_pressed)

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
