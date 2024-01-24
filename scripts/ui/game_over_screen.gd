extends CanvasLayer

@export var winLabel : Label;
@export var nftLabel : Label;

#var game_manager: GameManager;

func _ready():
	#game_manager = get_node("/root/GameManager");
	GameManager.connect("game_finished", _on_game_over);
	hide();


func _on_game_over():	
	call_deferred("pause_tree");
	
	nftLabel.text = str(GameManager.current_treasures, "/", GameManager.max_treasures);
	
	if GameManager.state == GameManager.GAME_STATES.WIN:
		winLabel.show();
	
	elif GameManager.state == GameManager.GAME_STATES.GAMEOVER:
		winLabel.hide();
	
	show();
	

func pause_tree():
	get_tree().paused = true;
