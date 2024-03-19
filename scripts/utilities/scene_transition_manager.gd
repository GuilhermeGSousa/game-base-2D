extends Node

signal on_scene_changed

func change_scene(scene: PackedScene):
	get_tree().change_scene_to_packed(scene)
	get_tree().tree_changed.connect(trigger_scene_changed_signal)

func change_scene_with_transition(scene: PackedScene, transition: PackedScene):
	var transition_instance: Transition = transition.instantiate()
	
	transition_instance.on_fade_out.connect(_on_fade_out.bind(scene, transition_instance))
	transition_instance.on_fade_in.connect(_on_fade_in.bind(transition_instance))
	
	add_child(transition_instance)

func _on_fade_out(new_scene: PackedScene, transition_instance: Transition):
	change_scene(new_scene)
	transition_instance.fade_in()

func _on_fade_in(transition_instance: Transition):
	transition_instance.queue_free()

func trigger_scene_changed_signal():
	on_scene_changed.emit()
	get_tree().tree_changed.disconnect(trigger_scene_changed_signal)
