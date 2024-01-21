extends Label

var game_manager: GameManager;
func _ready():
	game_manager = get_node("/root/Gamemanager");

func _process(_delta):
	if game_manager.state == GameManager.GAME_STATES.PLAYING:
		text = "%.1d/" %game_manager.current_treasures + "%.1d"%game_manager.max_treasures;
