extends Node

signal game_finished();
signal points_added();
signal on_nft_added;

enum GAME_STATES {
	MAIN_MENU,
	LOADING,
	TUTORIAL,
	PLAYING,
	GAMEOVER,
	WIN,
}

var state: GAME_STATES = GAME_STATES.MAIN_MENU;
var tutorial_played: bool = false;
var time_remaining: float;
var max_nfts: int = 10;


func _process(delta):
	if state == GAME_STATES.PLAYING:
		time_remaining -= delta;
		if time_remaining < 0:
			state = GAME_STATES.GAMEOVER;
			game_finished.emit();

		if GameStats.current_nfts >= max_nfts:
			state = GAME_STATES.WIN;
			game_finished.emit();


func start_playing():
	state = GAME_STATES.PLAYING;
	GameStats.current_points = 0;
	GameStats.current_nfts = 0;


func add_points(points: int):
	GameStats.current_points += points;
	emit_signal("points_added");


func add_nft():
	GameStats.current_nfts += 1;
	on_nft_added.emit();


func inject_play_time(game_time):
	time_remaining = game_time;
