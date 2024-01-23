extends Node

signal loading_animation_finished;

@export var rotating_icon : TextureRect;
@export var rotating_speed : float = 0.0;
@export var loading_text : LineEdit;
@export var blinking_period : float = 1.0;

var transition_canvas : CanvasLayer

var timer_blinking : float = 0.0;

var loading_progress : Array[float] = [];
var loading_completed : bool = false;

func _ready():
	transition_canvas = get_node("TransitionFadeOut");
	transition_canvas.connect("transition_finished", emit_finished_loading);

func _process(delta):
	loading_animation(delta);


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


func finish_loading_animation():
	transition_canvas.show();
	transition_canvas.find_child("Animation").play("fade_out");
	

func emit_finished_loading():
	transition_canvas.hide();
	loading_animation_finished.emit();
