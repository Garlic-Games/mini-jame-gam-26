extends TextureRect

@export var duration: float = 1;

var last: float = 0;
var is_active: bool = false;


func _ready():
	GameManager.connect("points_added", _on_points_added);


func _process(delta):
	if is_active:
		last = last + delta;
		if last >= duration:
			is_active = false;
			material.set_shader_parameter("doeet", false);


func _on_points_added():
	material.set_shader_parameter("doeet", true);
	last = 0.0;
	is_active = true;
