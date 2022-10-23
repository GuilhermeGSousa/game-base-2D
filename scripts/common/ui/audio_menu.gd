extends VBoxContainer

@onready var master_bus = AudioServer.get_bus_index('Master')
@onready var music_bus = AudioServer.get_bus_index('Music')
@onready var sfx_bus = AudioServer.get_bus_index('SFX')

func _on_master_audio_value_changed(value):
	AudioServer.set_bus_volume_db(
		master_bus,
		linear_to_db(value)
	)


func _on_sfx_audio_value_changed(value):
	AudioServer.set_bus_volume_db(
		sfx_bus,
		linear_to_db(value)
	)


func _on_music_audio_value_changed(value):
	AudioServer.set_bus_volume_db(
		music_bus,
		linear_to_db(value)
	)
