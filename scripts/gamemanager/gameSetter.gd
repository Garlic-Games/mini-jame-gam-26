extends Node

@export var play_time: float = 6 * 60;
@export var animation_player: AnimationPlayer;

var game_manager: GameManager;

var tutorial_started : bool = false; 


func _ready():
	game_manager = get_node("/root/Gamemanager");
	game_manager.injectPlayTime(play_time);
	game_manager.animation_player = animation_player;


func _process(delta):
	if not tutorial_started and get_parent().is_scene_loaded():
		set_game_loaded();


func set_game_loaded():
	tutorial_started = true;
	game_manager.set_tutorial();
	get_tree().paused = false;
