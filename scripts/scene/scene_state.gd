extends Node

var _scene_loaded : bool = false;


func _ready():
	_scene_loaded = true;


func is_scene_loaded():
	return _scene_loaded;
