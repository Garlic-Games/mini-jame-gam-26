extends CanvasLayer

var game_manager: GameManager;

@export var winLabel : Label;
@export var nftLabel : Label;

func _ready():
	game_manager = get_node("/root/Gamemanager");
	game_manager.connect("game_finished", _on_game_over);
	hide();


func _on_game_over():
	get_tree().paused = true;
	nftLabel.text = str(game_manager.current_treasures, "/", game_manager.current_treasures);
	
	if game_manager.state == game_manager.GAME_STATES.WIN:
		winLabel.show();
	
	show();
