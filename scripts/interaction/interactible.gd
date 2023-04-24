class_name Interactable extends Area2D

signal on_interacted(interactor : Interactor)

func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	
func _on_area_entered(area : Area2D):
	if area is Interactor:
		area.on_interact.connect(_on_interact.bind(area))
	
func _on_area_exited(area : Area2D):
	if area is Interactor:
		area.on_interact.disconnect(_on_interact)

func _on_interact(interactor : Interactor):
	on_interacted.emit(interactor)
