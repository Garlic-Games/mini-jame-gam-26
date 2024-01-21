class_name GameManager;
extends Node

enum GAME_STATES {
	LOADING,
	TUTORIAL,
	PLAYING,
	GAMEOVER
}

var time_remaining: float;
var current_points: int = 0;
var current_treasures: int = 0;
var max_treasures: int = 10;
var state: GAME_STATES = GAME_STATES.LOADING;
var animationPlayer: AnimationPlayer;
var tutorialPlayed = false;

signal game_finished();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(state == GAME_STATES.PLAYING):
		time_remaining -= delta;
		if time_remaining < 0:
			state = GAME_STATES.GAMEOVER;
			game_finished.emit();
			

func set_tutorial():
	if (tutorialPlayed): 
		set_playing();
		return;
	state = GAME_STATES.TUTORIAL;
	animationPlayer.play("tutorial")
	animationPlayer.connect("animation_finished", AnimationFinished);
	
func AnimationFinished(algo):
	tutorialPlayed = true;
	animationPlayer.disconnect("animation_finished", AnimationFinished);
	set_playing();
	
func set_playing():
	state = GAME_STATES.PLAYING;
	current_points = 0;
	
func set_gameOver():
	state = GAME_STATES.GAMEOVER;

func add_points(points: int):
	current_points = current_points + points;

func add_treasure():
	current_treasures = current_treasures + 1;
	
func injectPlayTime(game_time):
	time_remaining = game_time;
	
