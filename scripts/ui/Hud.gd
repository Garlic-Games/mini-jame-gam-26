extends CanvasLayer

@export var bar_revolutions : ProgressBar = null;
@export var label_speed : Label = null;
@export var label_points : Label = null;
@export var label_nfts : Label = null;
@export var label_time : Label = null;
@export var icon_nft : TextureRect = null;

func _ready():
	GameManager.connect("on_nft_added", animate_nft);
	
func _process(_delta):
	bar_revolutions.value = GameStats.rpm_percent;
	label_speed.text = "%.1f km/h" % GameStats.speed_kph;
	label_nfts.text = "%.1d/" % GameStats.current_nfts + "%.1d" % GameManager.max_nfts;
	label_points.text = "%.1d" % GameStats.current_points;

	if GameManager.state == GameManager.GAME_STATES.PLAYING:
		label_time.text = "%02d:" % int(GameManager.time_remaining / 60) + "%02d" % (int(GameManager.time_remaining) % 60);
		label_time.get_parent();

func animate_nft():
	icon_nft.find_child("Animation").play("bounce");
