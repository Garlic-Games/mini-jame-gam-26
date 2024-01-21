extends Camera3D


@export var min_distance = 2.0
@export var max_distance = 4.0
@export var angle_v_adjust = 0.0

@export var height = 1.5

@export var min_fov = 75;
@export var max_fov = 100;
var car: Vehicle;

var collision_exception = []


func _ready():
	# Find collision exceptions for ray.
	var node = self
	while(node):
		if (node is RigidBody3D):
			collision_exception.append(node.get_rid())
			break
		else:
			node = node.get_parent()

	# This detaches the camera transform from the parent spatial node.
	set_as_top_level(true)
	car = get_node("../..");

func _process(_delta):
	fov = min_fov + ((max_fov-min_fov) * (car.speed_kph / 144.0));

func _physics_process(_delta):
	var target = get_parent().get_global_transform().origin
	var pos = get_global_transform().origin

	var from_target = pos - target

	# Check ranges.
	if from_target.length() < min_distance:
		from_target = from_target.normalized() * min_distance
	elif from_target.length() > max_distance:
		from_target = from_target.normalized() * max_distance

	from_target.y = height

	pos = target + from_target

	look_at_from_position(pos, target, Vector3.UP)

	# Turn a little up or down
	var t = get_transform()
	t.basis = Basis(t.basis[0], deg_to_rad(angle_v_adjust)) * t.basis
	set_transform(t)
