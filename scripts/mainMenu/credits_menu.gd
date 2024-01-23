extends MarginContainer

func _ready():
	hide();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func open_link(link):
	OS.shell_open(link);

