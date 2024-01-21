class_name GameManager;
extends Node

enum GAME_STATES {
	LOADING,
	PLAYING,
	GAMEOVER
}

var time_remaining: float;
var current_points: int = 0;
var state: GAME_STATES = GAME_STATES.LOADING;
signal game_finished();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(state == GAME_STATES.PLAYING):
		time_remaining -= delta;
		if time_remaining < 0:
			state = GAME_STATES.GAMEOVER;
			game_finished.emit();

func set_playing(game_time:float):
	state = GAME_STATES.PLAYING;
	current_points = 0;
	time_remaining = game_time;
	
func set_gameOver():
	state = GAME_STATES.GAMEOVER;

func add_points(points: int):
	current_points = current_points + points;
