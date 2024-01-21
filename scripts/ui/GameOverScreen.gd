extends CanvasLayer

var game_manager: GameManager;

func _ready():
	game_manager = get_node("/root/Gamemanager");
	game_manager.connect("game_finished", _on_game_over);
	hide();


func _on_game_over():
	get_tree().paused = true;
	show();
