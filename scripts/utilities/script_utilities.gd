class_name ScriptUtilities extends Object

static func find_child(node : Node, type : String) -> Node:
	# Iterate through all children
	for child in node.get_children():
		# If the child is a match then return it
		if child.is_class(type):
			return child

		# Recurse into child
		var found := find_child(child, type)
		if found:
			return found

	# No child found matching type
	return null
