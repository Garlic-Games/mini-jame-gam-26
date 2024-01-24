extends Label


func _process(delta):
	text = "%.1d"% GameManager.current_points;
