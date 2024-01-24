extends Node

var current_scene : Node = null;

var current_scene_path : String = "";
var loading_progress : Array[float] = [];
var is_scene_loading : bool = false;

var loading_scene_instance : Node = null;

@onready var loading_scene = preload("res://prefabs/ui/loading_screen.tscn");


func _process(delta):
	if is_scene_loading:
		check_loading_status();


func load_scene(caller_scene, scene_path):
	is_scene_loading = true;
	
	loading_scene_instance = loading_scene.instantiate();
	loading_scene_instance.connect("loading_animation_finished", instantiate_scene);
	
	get_tree().get_root().call_deferred("add_child", loading_scene_instance);
	
	current_scene_path = scene_path;
	ResourceLoader.load_threaded_request(current_scene_path);
	
	caller_scene.queue_free();


func restart_scene():
	is_scene_loading = true;
	
	current_scene.queue_free();
	current_scene = null;
	
	loading_scene_instance = loading_scene.instantiate();
	loading_scene_instance.connect("loading_animation_finished", instantiate_scene);
	
	get_tree().get_root().call_deferred("add_child", loading_scene_instance);
	
	ResourceLoader.load_threaded_request(current_scene_path);


func check_loading_status():
	var loading_status = ResourceLoader.load_threaded_get_status(current_scene_path, loading_progress);

	match loading_status:
		ResourceLoader.THREAD_LOAD_LOADED:
			loading_scene_instance.finish_loading_animation();


func instantiate_scene():
	current_scene = ResourceLoader.load_threaded_get(current_scene_path).instantiate();
	get_tree().get_root().add_child(current_scene);
	
	loading_scene_instance.queue_free();
