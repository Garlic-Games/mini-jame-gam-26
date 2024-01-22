extends Label

var isEnabled : bool = false;

func _process(delta: float):	
	if isEnabled:
		text = str("%.2f" % (1.0/delta), " FPS\n", "%.2f" % (1000.0 * delta), " ms");
		
	if Input.is_action_just_pressed("show_fps"):
		isEnabled = !isEnabled;
		
		if isEnabled: 
			get_parent().show();
			
		else: 
			get_parent().hide();
