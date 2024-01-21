extends Label

var game_manager: GameManager;
func _ready():
	game_manager = get_node("/root/Gamemanager");

func _process(_delta):
	if game_manager.state == GameManager.GAME_STATES.PLAYING:
		text = "%.1d:" %(int(game_manager.time_remaining)/60) + "%.1d"%(int(game_manager.time_remaining)%60);
