extends CanvasLayer

var game_manager: GameManager;

@export var winLabel : Label;

func _ready():
	game_manager = get_node("/root/Gamemanager");
	game_manager.connect("game_finished", _on_game_over);
	game_manager.connect("game_won", _on_game_won);
	hide();


func _on_game_over():
	get_tree().paused = true;
	show();

func _on_game_won():
	get_tree().paused = true;
	winLabel.show();
	show();
