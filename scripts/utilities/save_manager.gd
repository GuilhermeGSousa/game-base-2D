extends Node

const IGNORED_PROPERTIES = [
]

const SAVE_GROUP = "Saveable"

@export var load_transition : PackedScene
@export var is_paused : BoolReference

func has_save_file() -> bool:
	return FileAccess.file_exists("user://save_game.dat")

func save_game():
	var save_nodes : Array[Node] = get_tree().get_nodes_in_group(SAVE_GROUP)
	var current_scene = get_tree().current_scene.scene_file_path
	var data : Dictionary = {} # Load instead
	data["current_scene"] = current_scene
	
	for node in save_nodes:
		_save_node(data, node)
	
	var file = FileAccess.open("user://save_game.dat", FileAccess.WRITE)
	file.store_var(data)
	
func load_game():
	is_paused.value = false
	var file = FileAccess.open("user://save_game.dat", FileAccess.READ)
	
	if not file:
		return
	
	var data = file.get_var()
	var current_scene = data["current_scene"]
	
	# We transition to the new scene first
	var new_scene : PackedScene = load(current_scene)
	SceneTransitionManager.change_scene_with_transition(new_scene, load_transition)
	SceneTransitionManager.on_scene_changed.connect(_on_scene_changed.bind(data))
	
func _save_node(data : Dictionary, node : Node):
	var node_data = {}
	
	for p in node.get_property_list():
		var property_name = p["name"]
		if property_name in IGNORED_PROPERTIES:
			continue
		
		var property_usage = p["usage"]
		if not (property_usage & PROPERTY_USAGE_STORAGE):
			continue
			
		var property_type = p["type"]
		if property_type == TYPE_OBJECT:
			# Object type properties can't be saved for now
			continue

		var property_data = node.get(property_name)
		
		if property_data:
			node_data[property_name] = property_data
		
	data[node.get_path()] = node_data

func _load_node(data : Dictionary, node : Node):
	is_paused.value = false
	
	var node_data = data[node.get_path()]	
	for property in node_data:
		node.set(property, node_data[property])

func _on_scene_changed(data):
	# We load everything up once the transition is done and the scene is loaded
	var save_nodes : Array[Node] = get_tree().get_nodes_in_group(SAVE_GROUP)
	for node in save_nodes:
		_load_node(data, node)
	
	SceneTransitionManager.on_scene_changed.disconnect(_on_scene_changed)
