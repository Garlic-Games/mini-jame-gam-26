extends MarginContainer

func _ready():
	hide();

func set_fullscreen(full: bool):
	var window = get_window();
	var screen_size = DisplayServer.screen_get_size()
	if(full):
		window.mode = Window.MODE_FULLSCREEN;
	else:
		window.mode = Window.MODE_WINDOWED
		window.size = Vector2i(screen_size.x - 66, screen_size.y - 1)
		window.position = Vector2i(
			(screen_size.x - window.size.x)*0.5, 
			(screen_size.y - window.size.y) + 200);

