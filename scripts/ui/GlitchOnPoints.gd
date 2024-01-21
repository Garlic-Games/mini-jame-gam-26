extends TextureRect


var game_manager: GameManager;

var last: float = 0;
@export var duration: float = 1;
var isActive: bool = false;

func _ready():
	game_manager = get_node("/root/Gamemanager");
	game_manager.connect("points_added", _on_points_added);

func _process(delta):
	if isActive:
		last = last + delta;
		if last >= duration:
			isActive = false;
			material.set_shader_parameter("doeet", false);
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_points_added():
	material.set_shader_parameter("doeet", true);
	last = 0.0;
	isActive = true;

	
