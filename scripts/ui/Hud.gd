extends CanvasLayer

@export var delorean: Vehicle;
@export var bar_revolutions : ProgressBar = null;
@export var label_speed : Label = null;
@export var label_points : Label = null;
@export var label_nfts : Label = null;
@export var label_time : Label = null;


func _process(_delta):
	bar_revolutions.value = delorean.rpm_percent;
	label_speed.text = "%.1f Km/H" % delorean.speed_kph;
	label_nfts.text = "%.1d/" %GameManager.current_nfts + "%.1d"%GameManager.max_nfts;
	label_points.text = "%.1d"% GameManager.current_points;

	if GameManager.state == 2:
		label_time.text = "%02d:" %int(GameManager.time_remaining/60) + "%02d"%(int(GameManager.time_remaining)%60);
