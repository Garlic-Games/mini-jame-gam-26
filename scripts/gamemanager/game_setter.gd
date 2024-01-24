extends Node

@export var play_time: float = 6 * 60;
@export var tutorial_animation_player: AnimationPlayer;
@export var fade_in_canvas : CanvasLayer;

var tutorial_started : bool = false; 


func _ready():
	GameManager.inject_play_time(play_time);
	GameManager.animation_player = tutorial_animation_player;
	
	fade_in_canvas.show();
	

func _process(delta):
	if not tutorial_started:
		set_game_loaded();


func set_game_loaded():
	fade_in_canvas.find_child("Animation").play("fade_in");
	tutorial_started = true;
	
	GameManager.set_tutorial();
	get_tree().paused = false;
