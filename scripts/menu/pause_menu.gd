extends CanvasLayer

const main_menu_path = "res://scenes/main.tscn";

var is_paused = false;


func _process(_delta):
	if GameManager.state == GameManager.GAME_STATES.PLAYING || GameManager.state == GameManager.GAME_STATES.TUTORIAL:
		if Input.is_action_just_pressed("pause"):
			call_deferred("toggle_pause");


func _on_continue_pressed():
	call_deferred("toggle_pause");
	self.hide();


func _on_restart_pressed():
	call_deferred("toggle_pause");
	SceneManager.restart_scene();


func _on_main_menu_pressed():
	call_deferred("toggle_pause");
	GameManager.state = GameManager.GAME_STATES.LOADING;
	SceneManager.load_scene(self, main_menu_path);


func toggle_pause():
	is_paused = !is_paused;
	get_tree().paused = is_paused;
			
	if is_paused:
		self.show();
	else:
		self.hide();
