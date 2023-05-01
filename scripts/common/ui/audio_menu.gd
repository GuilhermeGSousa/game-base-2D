extends Control

@export var master_slider : Slider
@export var music_slider : Slider
@export var sfx_slider : Slider

@onready var master_bus = AudioServer.get_bus_index('Master')
@onready var music_bus = AudioServer.get_bus_index('Music')
@onready var sfx_bus = AudioServer.get_bus_index('SFX')

func _enter_tree():
	master_slider.value_changed.connect(_on_master_audio_value_changed)
	music_slider.value_changed.connect(_on_music_audio_value_changed)
	sfx_slider.value_changed.connect(_on_sfx_audio_value_changed)

func _exit_tree():
	master_slider.value_changed.disconnect(_on_master_audio_value_changed)
	music_slider.value_changed.disconnect(_on_music_audio_value_changed)
	sfx_slider.value_changed.disconnect(_on_sfx_audio_value_changed)

func _ready():
	master_slider.value = db_to_linear(AudioServer.get_bus_volume_db(master_bus))
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus))
	

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
