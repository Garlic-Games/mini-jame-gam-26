extends Node

signal transition_finished;


func _on_animation_animation_finished(anim_name):
	transition_finished.emit();
