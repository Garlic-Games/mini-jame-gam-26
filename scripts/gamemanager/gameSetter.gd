extends Node

@export var play_time: float = 6 * 60;
@export var animationPlayer: AnimationPlayer;

var game_manager: GameManager;
# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager = get_node("/root/Gamemanager");
	game_manager.injectPlayTime(play_time);
	game_manager.animationPlayer = animationPlayer;
	call_deferred("setGameLoaded");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func setGameLoaded():
	game_manager.set_tutorial();
	get_tree().paused = false;
