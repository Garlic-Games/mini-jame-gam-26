extends Node

signal on_pause_pressed();
signal on_show_fps_pressed();
signal on_handbrake_input(is_pressed);
signal on_accelerate_input(is_pressed);
signal on_reverse_input(is_pressed);
signal on_left_turn_input(is_pressed);
signal on_right_turn_input(is_pressed);

func _ready():
	process_mode = PROCESS_MODE_ALWAYS;


func _input(_event):
	if Input.is_action_just_pressed("pause"):
		on_pause_pressed.emit();
		get_viewport().set_input_as_handled();

	if Input.is_action_just_pressed("show_fps"):
		on_show_fps_pressed.emit();
		get_viewport().set_input_as_handled();

	if Input.is_action_just_pressed("handbrake"):
		on_handbrake_input.emit(true);
		get_viewport().set_input_as_handled();

	elif Input.is_action_just_released("handbrake"):
		on_handbrake_input.emit(false);
		get_viewport().set_input_as_handled();

	if Input.is_action_just_pressed("accelerate"):
		on_accelerate_input.emit(true);
		get_viewport().set_input_as_handled();
		
	elif Input.is_action_just_released("accelerate"):
		on_accelerate_input.emit(false);
		get_viewport().set_input_as_handled();

	if Input.is_action_just_pressed("reverse"):
		on_reverse_input.emit(true);
		get_viewport().set_input_as_handled();

	elif Input.is_action_just_released("reverse"):
		on_reverse_input.emit(false);
		get_viewport().set_input_as_handled();
		
	if Input.is_action_just_pressed("turn_left"):
		on_left_turn_input.emit(true);
		get_viewport().set_input_as_handled();

	elif Input.is_action_just_released("turn_left"):
		on_left_turn_input.emit(false);
		get_viewport().set_input_as_handled();

	if Input.is_action_just_pressed("turn_right"):
		on_right_turn_input.emit(true);
		get_viewport().set_input_as_handled();

	elif Input.is_action_just_released("turn_right"):
		on_right_turn_input.emit(false);
		get_viewport().set_input_as_handled();
