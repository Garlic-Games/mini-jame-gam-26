extends Button


func _pressed():
	get_tree().paused = false;
	SceneManager.restart_scene("res://scenes/gameplay.tscn");
