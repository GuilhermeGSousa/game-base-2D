extends Button

@onready var master_bus = AudioServer.get_bus_index('Master')

func _enter_tree():
	toggled.connect(toggle_mute)
	
func _exit_tree():
	toggled.disconnect(toggle_mute)
	
func toggle_mute(value : bool):
	AudioServer.set_bus_mute(master_bus, value)
