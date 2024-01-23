extends Button

func _pressed():
	get_tree().paused = false;
	get_tree().reload_current_scene();
