extends Label

func _process(delta: float):
	text = str("%.2f" % (1.0/delta), " FPS\n", "%.2f" % (1000.0 * delta), " ms");
