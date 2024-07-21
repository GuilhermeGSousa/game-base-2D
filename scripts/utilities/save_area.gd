class_name SaveArea extends Area2D

func _enter_tree():
	area_entered.connect(_on_area_entered)

func _exit_tree():
	area_entered.disconnect(_on_area_entered)
	
func _on_area_entered(area: Area2D):
	SaveManager.save_game()
