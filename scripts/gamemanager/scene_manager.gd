extends Node

var target_scene_path : String = "";
var loading_progress : Array[float] = [];

var loading_scene_instance : Node = null;

@onready var loading_scene = preload("res://prefabs/ui/loading_screen.tscn");


func _process(delta):
	if target_scene_path:
		check_loading_status();


func load_scene(caller_scene, scene_path):
	loading_scene_instance = loading_scene.instantiate();
	loading_scene_instance.connect("loading_animation_finished", instantiate_scene);
	get_tree().get_root().call_deferred("add_child", loading_scene_instance);
	
	target_scene_path = scene_path;
	ResourceLoader.load_threaded_request(target_scene_path);
	
	caller_scene.queue_free();


func check_loading_status():
	var loading_status = ResourceLoader.load_threaded_get_status(target_scene_path, loading_progress);

	match loading_status:
		ResourceLoader.THREAD_LOAD_LOADED:
			loading_scene_instance.finish_loading_animation();


func instantiate_scene():
	get_tree().get_root().add_child(await ResourceLoader.load_threaded_get(target_scene_path).instantiate());
	loading_scene_instance.queue_free();
	target_scene_path = "";
