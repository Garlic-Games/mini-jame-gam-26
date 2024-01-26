extends Label

var is_enabled : bool = false;


func _ready():
	InputManager.on_show_fps_pressed.connect(toggle_fps);


func _process(delta):
	if is_enabled:
		text = str("%.2f" % (1.0 / delta), " FPS\n", "%.2f" % (1000.0 * delta), " ms");


func toggle_fps():
	is_enabled = !is_enabled;

	if is_enabled:
		get_parent().show();
	else:
		get_parent().hide();
