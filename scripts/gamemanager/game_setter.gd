extends Node

@export var play_time: float = 6 * 60;
@export var tutorial_animation_player: AnimationPlayer;
@export var fade_in_canvas : CanvasLayer;

var game_manager: GameManager;

var tutorial_started : bool = false; 


func _ready():
	game_manager = get_node("/root/Gamemanager");
	game_manager.inject_play_time(play_time);
	game_manager.animation_player = tutorial_animation_player;
	
	fade_in_canvas.show();
	

func _process(delta):
	if not tutorial_started:
		set_game_loaded();


func set_game_loaded():
	fade_in_canvas.find_child("Animation").play("fade_in");
	tutorial_started = true;
	
	game_manager.set_tutorial();
	get_tree().paused = false;
