extends CanvasLayer

@export var game:PackedScene;


func _on_start_pressed():
	get_tree().change_scene_to_packed(game);


func _on_exit_pressed():
	get_tree().quit();
