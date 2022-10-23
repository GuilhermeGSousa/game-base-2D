extends Node

func change_scene_with_transition(scene : PackedScene, transition : PackedScene ):
	var transition_instance : Transition = transition.instantiate()
	
	transition_instance.on_fade_out.connect(_on_fade_out.bind(scene, transition_instance))
	transition_instance.on_fade_in.connect(_on_fade_in.bind(scene, transition_instance))
	
	add_child(transition_instance)

func _on_fade_out(new_scene : PackedScene, transition_instance : Transition):
	get_tree().change_scene_to_packed(new_scene)
	transition_instance.fade_in()
	
func _on_fade_in(new_scene : PackedScene, transition_instance : Transition):
	transition_instance.queue_free()
