extends Label

#var game_manager: GameManager;

#func _ready():
	#game_manager = get_node("/root/GameManager");

func _process(_delta):
	text = "%.1d/" %GameManager.current_treasures + "%.1d"%GameManager.max_treasures;
