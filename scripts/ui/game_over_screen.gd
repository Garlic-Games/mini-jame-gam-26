extends CanvasLayer

@export var winLabel : Label;
@export var nftLabel : Label;

var game_manager: GameManager;

func _ready():
	game_manager = get_node("/root/Gamemanager");
	game_manager.connect("game_finished", _on_game_over);
	hide();


func _on_game_over():	
	call_deferred("pause_tree");
	
	nftLabel.text = str(game_manager.current_treasures, "/", game_manager.max_treasures);
	
	if game_manager.state == game_manager.GAME_STATES.WIN:
		winLabel.show();
	
	elif game_manager.state == game_manager.GAME_STATES.GAMEOVER:
		winLabel.hide();
	
	show();
	

func pause_tree():
	get_tree().paused = true;
