extends Node

signal transition_finished;


func _on_animation_animation_finished(_algo):
	transition_finished.emit();
