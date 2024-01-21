extends ProgressBar

var vehicle;
func _ready():
	vehicle = get_parent().vehicle;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var reset_count = vehicle.reset_count;
	if (reset_count > 0.1):
		var percent = reset_count * 100 / vehicle.reset_time_seconds;
		value = percent;
		show();
	else:
		hide();
