extends Label


func _process(delta):
	if GameManager.state == 2:
		text = "%02d:" %(int(GameManager.time_remaining)/60) + "%02d"%(int(GameManager.time_remaining)%60);
