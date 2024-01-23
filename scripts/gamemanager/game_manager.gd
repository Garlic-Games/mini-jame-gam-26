class_name GameManager;
extends Node

signal game_finished();
signal points_added();

enum GAME_STATES {
	LOADING,
	TUTORIAL,
	PLAYING,
	GAMEOVER,
	WIN
}

var time_remaining: float;
var current_points: int = 0;
var current_treasures: int = 0;
var max_treasures: int = 10;
var state: GAME_STATES = GAME_STATES.LOADING;
var animation_player: AnimationPlayer;
var tutorial_played = false;
var skip_tutorial_seconds = 3;
var skip_tutorial_count = 0;

func _process(delta):
	if state == GAME_STATES.TUTORIAL:
		if Input.is_action_pressed("handbrake"):
			skip_tutorial_count += delta;
			if(skip_tutorial_count > skip_tutorial_seconds):
				animation_player.play("RESET");
		else:
			skip_tutorial_count = 0;
			
	elif state == GAME_STATES.PLAYING:
		time_remaining -= delta;
		if time_remaining < 0:
			state = GAME_STATES.GAMEOVER;
			game_finished.emit();

		if current_treasures >= max_treasures:
			state = GAME_STATES.WIN;
			game_finished.emit();
			

func set_tutorial():
	if (tutorial_played):
		set_playing();
		return;
		
	state = GAME_STATES.TUTORIAL;
	
	animation_player.play("tutorial");
	animation_player.connect("animation_finished", animation_finished);


func animation_finished(algo):
	tutorial_played = true;
	animation_player.disconnect("animation_finished", animation_finished);
	set_playing();


func set_playing():
	state = GAME_STATES.PLAYING;
	current_points = 0;
	current_treasures = 0;
	
	
func add_points(points: int):
	current_points = current_points + points;
	emit_signal("points_added");


func add_treasure():
	current_treasures = current_treasures + 1;


func inject_play_time(game_time):
	time_remaining = game_time;
