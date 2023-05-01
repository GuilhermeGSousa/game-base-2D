extends Node

const IGNORED_PROPERTIES = [
]

func save_game():
	var save_nodes : Array[Node] = get_tree().get_nodes_in_group("Saveable")
	
	var data : Dictionary = {} # Load instead
	
	for node in save_nodes:
		save_node(data, node)
	
	var file = FileAccess.open("user://save_game.dat", FileAccess.WRITE)
	
	file.store_var(data)
	
func load_game():
	var file = FileAccess.open("user://save_game.dat", FileAccess.READ)
	var data = file.get_var()
	
	var save_nodes : Array[Node] = get_tree().get_nodes_in_group("Saveable")
	for node in save_nodes:
		load_node(data, node)

func save_node(data : Dictionary, node : Node):
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

func load_node(data : Dictionary, node : Node):
	
	var node_data = data[node.get_path()]
	
	for property in node_data:
		node.set(property, node_data[property])
