extends Node

var scene_resource : Resource = null; 
var current_scene : Node = null;

var current_scene_path : String = "";
var loading_progress : Array[float] = [];
var is_scene_loading : bool = false;

var loading_scene_instance : Node = null;

@onready var loading_scene = preload("res://prefabs/ui/loading_screen.tscn");


func _process(_delta):
	if is_scene_loading:
		check_loading_status();


func load_scene(caller_scene, scene_path):
	is_scene_loading = true;
	
	if current_scene:
		current_scene.queue_free();
	
	GameManager.state = GameManager.GAME_STATES.LOADING;
	
	current_scene_path = scene_path;
	ResourceLoader.load_threaded_request(current_scene_path);
	
	loading_scene_instance = loading_scene.instantiate();
	get_tree().get_root().call_deferred("add_child", loading_scene_instance);
	loading_scene_instance.connect("loading_animation_finished", instantiate_scene);

	caller_scene.queue_free();


func restart_scene():
	current_scene.queue_free();
	instantiate_scene();


func check_loading_status():
	var loading_status = ResourceLoader.load_threaded_get_status(current_scene_path, loading_progress);

	match loading_status:
		ResourceLoader.THREAD_LOAD_LOADED:
			loading_scene_instance.progress_bar.value = 100.0;
			scene_resource = ResourceLoader.load_threaded_get(current_scene_path);
			loading_scene_instance.finish_loading_animation();
		
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			loading_scene_instance.progress_bar.value = loading_progress[0] * 100;


func instantiate_scene():
	current_scene = scene_resource.instantiate();
	get_tree().get_root().add_child(current_scene);
			
	if current_scene_path == "res://scenes/main.tscn":
		GameManager.state = GameManager.GAME_STATES.MAIN_MENU;
		
	if is_scene_loading:
		loading_scene_instance.queue_free();
		is_scene_loading = false;
