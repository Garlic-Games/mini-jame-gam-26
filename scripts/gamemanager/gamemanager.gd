class_name GameManager;
extends Node

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
var tutorialPlayed = false;
var skip_tutorial_seconds = 3;
var skip_tutorial_count = 0;

signal game_finished();
signal game_won();
signal points_added();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(state == GAME_STATES.PLAYING):
		time_remaining -= delta;
		if time_remaining < 0:
			state = GAME_STATES.GAMEOVER;
			game_finished.emit();

		if current_treasures >= max_treasures:
			state = GAME_STATES.WIN;
			game_finished.emit();
			
	if(state == GAME_STATES.TUTORIAL):
		if Input.is_action_pressed("handbrake"):
			skip_tutorial_count += delta;
			if(skip_tutorial_count > skip_tutorial_seconds):
				animation_player.play("RESET");
		else:
			skip_tutorial_count = 0;


func set_tutorial():
	if (tutorialPlayed):
		set_playing();
		return;
		
	state = GAME_STATES.TUTORIAL;
	
	animation_player.play("tutorial")
	animation_player.connect("animation_finished", AnimationFinished);

func AnimationFinished(algo):
	tutorialPlayed = true;
	animation_player.disconnect("animation_finished", AnimationFinished);
	set_playing();

func set_playing():
	state = GAME_STATES.PLAYING;
	current_points = 0;
	current_treasures = 0;
	
func set_gameOver():
	state = GAME_STATES.GAMEOVER;

func add_points(points: int):
	current_points = current_points + points;
	emit_signal("points_added");

func add_treasure():
	current_treasures = current_treasures + 1;

func injectPlayTime(game_time):
	time_remaining = game_time;

