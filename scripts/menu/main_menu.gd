extends CanvasLayer

@export var game:PackedScene;


func _on_start_pressed():
	SceneManager.load_scene(self, game.resource_path);


func _on_exit_pressed():
	get_tree().quit();
