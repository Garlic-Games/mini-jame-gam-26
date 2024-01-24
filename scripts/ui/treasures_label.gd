extends Label


func _process(_delta):
	text = "%.1d/" %GameManager.current_nfts + "%.1d"%GameManager.max_nfts;
