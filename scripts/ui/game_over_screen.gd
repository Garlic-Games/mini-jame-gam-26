extends CanvasLayer

@export var game_over_music : AudioStreamPlayer
@export var label_win : Label;
@export var label_score : Label;
@export var label_nfts : Label;

func _ready():
	GameManager.connect("game_finished", on_game_over);
	hide();


func on_game_over():
	call_deferred("pause_tree");
	
	label_nfts.text = "%.1d/" % GameStats.current_nfts + "%.1d" % GameManager.max_nfts;
	label_score.text = "%.1d"% GameStats.current_points;
	
	if GameManager.state == GameManager.GAME_STATES.WIN:
		label_win.show();
	
	elif GameManager.state == GameManager.GAME_STATES.GAMEOVER:
		label_win.hide();
	
	game_over_music.play();
	
	show();


func pause_tree():
	get_tree().paused = true;


func _on_try_again_btn_pressed():
	get_tree().paused = false;
	SceneManager.restart_scene();
