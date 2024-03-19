class_name DialogInteractable extends Interactable

@export var dialog_box : DialogBox
@export var dialog_lines : Array[String]

var _current_line_index = -1

func _on_area_exited(area : Area2D):
	super._on_area_exited(area)
	_reset_dialog()

func _on_interact(interactor : Interactor):
	super._on_interact(interactor)
	_advance_dialog()
	
func _advance_dialog():
	if(_current_line_index == -1):
		dialog_box.is_on = true
	
	if(_current_line_index >= dialog_lines.size() - 1):
		dialog_box.is_on = false
		_current_line_index = -1
		return
	
	_current_line_index += 1
	dialog_box.set_text(dialog_lines[_current_line_index])
	
func _reset_dialog():
	_current_line_index = -1
	dialog_box.is_on = false
