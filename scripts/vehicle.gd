class_name Vehicle
extends VehicleBody3D


const STEER_SPEED = 1.5
const STEER_LIMIT = 0.4

@export_category("Control")
@export var engine_force_value = 3000;
@export var speed_limit = 340;
@export var brake_force_multiplier = 4;
@export var reset_time_seconds = 2;

@export_category("Wheels")
@export var wheel_fr: VehicleWheel3D;
@export var wheel_br: VehicleWheel3D;
@export var wheel_fl: VehicleWheel3D;
@export var wheel_bl: VehicleWheel3D;

@export_category("Motor configuration")
@export var rpm_pitch_min = 0.8;
@export var rpm_pitch_max = 5;
@export var gear_down_percent = 10;
@export var rpm_idle = 1100;
@export var rpm_max = 9500;
@export var rpm_up = 8000;
@export var rpm_down = 4000;
@export var gears_ratio = [3.85, 2.04, 1.28, 0.951, 0.76];
@export var motorStreamPlayer: AudioStreamPlayer;

@export_category("Interaction with destroyables")
@export var xs_min_speed = 25;
@export var s_min_speed = 35;
@export var m_min_speed = 50;
@export var l_min_speed = 70;
@export var xl_min_speed = 120;
@export var hitStreamPlayer: AudioStreamPlayer;

@export_category("Interaction with collectables")
@export var collectStreamPlayer: AudioStreamPlayer;

var steer_target = 0
var speed_kph = 0;
var rpm_value = 0;
var rpm_percent = 0;
var selected_gear = 0; #index of gears_ratio

var radio_rueda_metros = 0.4;
var factor_conversion = 60;
var is_upside_down = false;

var reset_count = 0;

signal upside_down_changed(value)

var game_manager : GameManager;

func _ready():
	add_to_group("Car");
	game_manager = get_node("/root/Gamemanager");

func _process(delta):
	if(is_upside_down):
		if Input.is_action_pressed("handbrake"):
			reset_count += delta;
			if(reset_count > reset_time_seconds):
				ResetCarFlipped();	
		else:
			reset_count = 0;
	else:
		reset_count = 0;



func _physics_process(delta):
	var fwd_mps = (linear_velocity) * transform.basis.x

	steer_target = Input.get_action_strength("turn_left") - Input.get_action_strength("turn_right")
	steer_target *= STEER_LIMIT

	if Input.is_action_pressed("accelerate"):
		# Increase engine force at low speeds to make the initial acceleration faster.
		var speed = linear_velocity.length()
		if speed < 5 and speed != 0:
			engine_force = clamp(engine_force_value * brake_force_multiplier / speed, 0, engine_force_value)
		else:
			engine_force = engine_force_value
	else:
		engine_force = 0

	if Input.is_action_pressed("reverse"):
		# Increase engine force at low speeds to make the initial acceleration faster.
		if fwd_mps >= Vector3.LEFT:
			var speed = linear_velocity.length()
			if speed < 5 and speed != 0:
				engine_force = -clamp(engine_force_value * brake_force_multiplier / speed, 0, engine_force_value)
			else:
				engine_force = -engine_force_value
		else:
			brake = engine_force_value * brake_force_multiplier
	else:
		brake = 0.0

	if Input.is_action_pressed("handbrake"):
		wheel_br.brake = engine_force_value * brake_force_multiplier;
		wheel_bl.brake = engine_force_value * brake_force_multiplier;
	else:
		wheel_br.brake = 0;
		wheel_bl.brake = 0;
		
		
	steering = move_toward(steering, steer_target, STEER_SPEED * delta)
	speed_kph = linear_velocity.length() * 3.6;
	calc_rpm();
	var pichToSet =  clamp(rpm_percent * rpm_pitch_max / 100, rpm_pitch_min, rpm_pitch_max);
	# print("KPH %d Gear %d RPM %d - %d MotorPitch %f" % [speed_kph, selected_gear+1, rpm_value, rpm_percent, pichToSet])
	motorStreamPlayer.pitch_scale = pichToSet;
	var ud_count = 0;
	if (!wheel_fr.is_in_contact()):
		ud_count += 1;
	if (!wheel_fl.is_in_contact()):
		ud_count += 1;
	if (!wheel_br.is_in_contact()):
		ud_count += 1;
	if (!wheel_bl.is_in_contact()):
		ud_count += 1;
		
	var now_upside_down =  ud_count == 4 || (ud_count > 2 && speed_kph < 10);
	if(is_upside_down != now_upside_down):
		print("Upside down changed to ", now_upside_down)
		is_upside_down = now_upside_down;
		upside_down_changed.emit(now_upside_down);
	
	set_collision_mask_value(10, xs_min_speed > speed_kph);
	set_collision_mask_value(11, s_min_speed > speed_kph);
	set_collision_mask_value(12, m_min_speed > speed_kph);
	set_collision_mask_value(13, l_min_speed > speed_kph);
	set_collision_mask_value(14, xl_min_speed > speed_kph);

func calc_rpm():
	var selectedRatio = gears_ratio[selected_gear];
	rpm_value = (speed_kph * 1000) / (radio_rueda_metros / selectedRatio * factor_conversion)
	if(rpm_value > rpm_up && selected_gear < gears_ratio.size() -1):
		selected_gear += 1;
	elif (rpm_value < rpm_down && selected_gear > 0):
		selected_gear -= 1;
	
	if(rpm_value < rpm_idle && selected_gear == 0):
		rpm_value = rpm_idle;
	rpm_percent = rpm_value  / rpm_max * 100;
		

func ResetCarFlipped():
	transform.basis = Basis();
	translate(Vector3(0, 0.03, 0));



func _on_body_entered(body):
	if body.is_in_group("Destroyable"):
		hitStreamPlayer.play();

	if body.is_in_group("Collectable"):
		collectStreamPlayer.play();
		
		body.get_parent().queue_free();
		game_manager.add_treasure();
		
	pass; # Replace with function body.
	
