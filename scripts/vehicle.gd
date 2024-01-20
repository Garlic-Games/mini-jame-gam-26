extends VehicleBody3D


const STEER_SPEED = 1.5
const STEER_LIMIT = 0.4

@export var engine_force_value = 40;
@export var speed_limit = 340;
@export var rpm_pitch_min = 0.05;
@export var rpm_pitch_max = 6;
@export var gear_down_percent = 10;
@export var speed_gears = [0, 20, 80, 130, 160, 240];
@export var motorStreamPlayer: AudioStreamPlayer;

var steer_target = 0
var speed_kph = 0;
var rpm_percent = 0;
var selected_gear = 0; #index of speed_gears

func _physics_process(delta):
	var fwd_mps = (linear_velocity) * transform.basis.x

	steer_target = Input.get_action_strength("turn_left") - Input.get_action_strength("turn_right")
	steer_target *= STEER_LIMIT

	if Input.is_action_pressed("accelerate"):
		# Increase engine force at low speeds to make the initial acceleration faster.
		var speed = linear_velocity.length()
		if speed < 5 and speed != 0:
			engine_force = clamp(engine_force_value * 5 / speed, 0, engine_force_value)
		else:
			engine_force = engine_force_value
	else:
		engine_force = 0

	if Input.is_action_pressed("reverse"):
		# Increase engine force at low speeds to make the initial acceleration faster.
		if fwd_mps >= Vector3.LEFT:
			var speed = linear_velocity.length()
			if speed < 5 and speed != 0:
				engine_force = -clamp(engine_force_value * 5 / speed, 0, engine_force_value)
			else:
				engine_force = -engine_force_value
		else:
			brake = 1
	else:
		brake = 0.0

	steering = move_toward(steering, steer_target, STEER_SPEED * delta)
	speed_kph = linear_velocity.length() * 3.6;
	rpm_percent = calc_rpm();
	var pichToSet =  clamp(rpm_percent * rpm_pitch_max / 100, rpm_pitch_min, rpm_pitch_max);
	print(speed_kph, " - ", selected_gear, " - " ,rpm_percent, " - ", pichToSet)
	motorStreamPlayer.pitch_scale = pichToSet;

func calc_rpm():
	var actualGearMin = speed_gears[selected_gear];
	var actualGearMax = speed_limit;
	if(selected_gear < speed_gears.size() -1):
		actualGearMax = speed_gears[selected_gear+1];
		if speed_kph > actualGearMax:
			selected_gear += 1;
	if(speed_kph < actualGearMin - (actualGearMin * gear_down_percent / 100)):
		selected_gear -= 1;
	return ((speed_kph - actualGearMin) / (actualGearMax - actualGearMin)) * 100;
