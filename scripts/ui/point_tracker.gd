extends Label


#var game_manager: GameManager;
func _ready():
	#game_manager = get_node("/root/GameManager");
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = "%.1d"% GameManager.current_points;
