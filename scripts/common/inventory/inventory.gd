class_name Inventory extends Resource

@export var item_list : Array[Item] = []

signal on_item_added(item : Item)
signal on_item_removed(item : Item)

func has_item(item : Item):
	return item_list.has(item)

func add_item(item : Item):
	if has_item(item) : return

	item_list.append(item)
	on_item_added.emit(item)

func remove_item(item : Item):
	if not has_item(item) : return
	
	item_list.erase(item)
	on_item_removed.emit(item)

func remove_items():
	for item in item_list:
		on_item_removed.emit(item)
	item_list = []
