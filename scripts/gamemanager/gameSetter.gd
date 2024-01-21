extends Node

@export var play_time: float = 3 * 60;
@export var game_over_screen: CanvasLayer;
var game_manager: GameManager;
# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager = get_node("/root/Gamemanager");
	call_deferred("setGameLoaded");
	game_manager.connect("game_finished", _on_game_over);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func setGameLoaded():
	game_manager.set_playing(play_time)

func _on_game_over():
	game_over_screen.show();
