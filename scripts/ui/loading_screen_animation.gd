extends Node

@export var scene_to_load : PackedScene = null;

@export var rotating_icon : TextureRect;
@export var rotating_speed : float = 0.0;
@export var loading_text : LineEdit;
@export var blinking_period : float = 1.0;

var timer_blinking : float = 0.0;

var loading_progress : Array[float] = [];
var loading_completed : bool = false;


func _ready():
	if scene_to_load:
		ResourceLoader.load_threaded_request(scene_to_load.resource_path);


func _process(delta):
	loading_animation(delta);
	print (loading_completed);
	if not loading_completed:
		check_loading_status();


func check_loading_status():
	var loading_status = ResourceLoader.load_threaded_get_status(scene_to_load.resource_path, loading_progress);
	
	match loading_status:
		ResourceLoader.THREAD_LOAD_LOADED:
			loading_completed = true;
			get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(scene_to_load.resource_path));


func loading_animation(delta):
	rotating_icon.rotation_degrees += delta * rotating_speed;
	
	if rotating_icon.rotation_degrees > 360:
		rotating_icon.rotation_degrees -= 360;
		
	timer_blinking += delta;
	
	if timer_blinking < blinking_period / 2.0:
		loading_text.show();
	elif timer_blinking < blinking_period:
		loading_text.hide();
	else:
		timer_blinking = 0.0;
