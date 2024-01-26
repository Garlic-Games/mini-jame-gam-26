extends Node

@export var play_time: float = 6 * 60;
@export var vehicle : Vehicle = null;
@export var tutorial_animation_player: AnimationPlayer;
@export var fade_in_canvas : CanvasLayer;

var skip_tutorial_seconds : float = 2.0;
var skip_tutorial_count : float = 0.0;

var tutorial_started : bool = false;
var is_skip_pressed : bool = false;


func _ready():
	GameManager.inject_play_time(play_time);

	InputManager.on_handbrake_input.connect(func(value): is_skip_pressed = value);

	if fade_in_canvas:
		fade_in_canvas.show();


func _process(_delta):
	if not tutorial_started:
		set_game_loaded();

	if GameManager.state == GameManager.GAME_STATES.TUTORIAL:
		if is_skip_pressed:
			skip_tutorial_count += _delta;

			if(skip_tutorial_count > skip_tutorial_seconds):
				if fade_in_canvas:
					fade_in_canvas.find_child("Animation").play("fade_in");
					call_deferred("end_animation");

		else:
			skip_tutorial_count = 0;


func end_animation():
	tutorial_animation_player.play("RESET");
	GameManager.start_playing();
	
func animation_finished(_algo):
	GameManager.tutorial_played = true;

	if fade_in_canvas:
		fade_in_canvas.find_child("Animation").play("fade_in");

	tutorial_animation_player.disconnect("animation_finished", animation_finished);

	call_deferred("end_animation");
	

func set_tutorial():
	tutorial_started = true;

	if (GameManager.tutorial_played):
		GameManager.start_playing();
		return;

	GameManager.state = GameManager.GAME_STATES.TUTORIAL;
	
	tutorial_animation_player.play("tutorial");
	tutorial_animation_player.connect("animation_finished", animation_finished);


func set_game_loaded():
	set_tutorial();
	get_tree().paused = false;

	if fade_in_canvas:
		fade_in_canvas.find_child("Animation").play("fade_in");
