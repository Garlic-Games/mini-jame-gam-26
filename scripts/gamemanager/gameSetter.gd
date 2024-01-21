extends Node

@export var play_time: float = 3 * 60;
var game_manager: GameManager;
# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager = get_node("/root/Gamemanager");
	call_deferred("setGameLoaded");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func setGameLoaded():
	game_manager.set_playing(play_time)

