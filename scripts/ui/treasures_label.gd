extends Label


func _process(_delta):
	text = "%.1d/" %GameManager.current_treasures + "%.1d"%GameManager.max_treasures;
