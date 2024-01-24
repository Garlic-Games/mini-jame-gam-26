class_name Destroyable
extends Node3D

enum BuildingSize {XS = 10, S = 11, M = 12 , L = 13, XL = 14}

@export var building_size : BuildingSize = BuildingSize.XS;
@export var explosion_force : float = 5.0;
@export var despawn_time : float = 4.0;

@export var audio_player: AudioStreamPlayer;
@export var pitch_min = 0.6;
@export var pitch_max = 0.9;

@export var destroyed_force_multiplier = 50000;
@export var point_multiplier = 50;

var timer_despawn = 0.0;

var explosion_center : Vector3 = Vector3.ZERO;

var pieces_node : Node = null;
var model_node : Node = null;
var slow_hitbox_node : StaticBody3D = null;
var pieces : Array = [];

var is_destroyed = false;

func _ready():	
	add_to_group("Destroyables");
	FindRigidBodies(self, pieces);

	slow_hitbox_node.set_collision_layer_value(building_size, true);

	if pieces_node:
		pieces_node.set_process(false);
		pieces_node.hide();
		pass;
		
func _process(delta):
	if is_destroyed:
		timer_despawn += delta;

		if timer_despawn >= despawn_time:
			queue_free();
			
func Explode():
	if is_destroyed:
		return;
		
	var force_direction : Vector3;
	var random_vector : Vector3;
	
	is_destroyed = true;

	model_node.set_process(false);
	model_node.hide();
	model_node.queue_free();
	
	pieces_node.set_process(true);
	pieces_node.show();
		
	for piece in pieces:
		force_direction = explosion_center.direction_to(piece.position);
		random_vector = Vector3(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1)) * force_direction;
		piece.apply_impulse(random_vector, force_direction * explosion_force * 100.0);
		
	if audio_player.playing == false:
		var pitch = randf_range(pitch_min, pitch_max);
		audio_player.pitch_scale = pitch;
		audio_player.play();

func FindRigidBodies(node : Node, pieceContainer : Array):
	for child in node.get_children():
		if child.name == "Model":
			model_node = child;
			slow_hitbox_node = model_node.get_child(2);
		
		elif child.name == "Rest in Pieces":
			pieces_node = child;

			for pz in pieces_node.get_children():
				if pz is RigidBody3D:
					pz.gravity_scale = 0.0;
					
					pieceContainer.append(pz);
