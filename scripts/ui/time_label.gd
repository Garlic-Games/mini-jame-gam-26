extends Label

#var game_manager: GameManager;
#func _ready():
#	game_manager = get_node("/root/GameManager");

func _process(_delta):
	if GameManager.state == 2:
		text = "%02d:" %(int(GameManager.time_remaining)/60) + "%02d"%(int(GameManager.time_remaining)%60);
