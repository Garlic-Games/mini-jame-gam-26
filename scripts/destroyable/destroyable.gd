extends Node3D

enum Building_size {XS = 10, S = 11, M = 12 , L = 13, XL = 14}

@export var buildingSize : Building_size = Building_size.XS;
@export var explosionForce : float = 5.0;
@export var despawnTime : float = 4.0;

@export var audioPlayer: AudioStreamPlayer;
@export var pitchMin = 0.6;
@export var pitchMax = 0.9;

@export var destroyedForceMultiplier = 50000;
@export var pointMultiplier = 50;

var timerDespawn = 0.0;

var explosionCenter : Vector3 = Vector3.ZERO;

var piecesNode : Node = null;
var modelNode : Node = null;
var slowHitBoxNode : StaticBody3D = null;
var pieces : Array = [];
var game_manager: GameManager;

var isDestroyed = false;

func _ready():
	add_to_group("Destroyables");
	FindRigidBodies(self, pieces);
	#print(slowHitBoxNode, buildingSize)
	slowHitBoxNode.set_collision_layer_value(buildingSize, true)
	game_manager = get_node("/root/Gamemanager");

	if piecesNode:
		piecesNode.set_process(false);
		piecesNode.hide();
		pass;
		
func _process(delta):
	if isDestroyed:
		timerDespawn += delta;

		if timerDespawn >= despawnTime:
			queue_free();
			
func Explode():
	if isDestroyed:
		return;
		
	var forceDirection : Vector3;
	var randomVector : Vector3;
	
	isDestroyed = true;

	modelNode.set_process(false);
	modelNode.hide();
	modelNode.queue_free();
	
	piecesNode.set_process(true);
	piecesNode.show();
		
	for piece in pieces:
		forceDirection = explosionCenter.direction_to(piece.position);
		randomVector = Vector3(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1)) * forceDirection;
		piece.apply_impulse(randomVector, forceDirection * explosionForce * 100.0);

func FindRigidBodies(node : Node, pieceContainer : Array):
	for child in node.get_children():
		if child.name == "Model":
			modelNode = child;
			slowHitBoxNode = modelNode.get_child(2)
		
		elif child.name == "Rest in Pieces":
			piecesNode = child;

			for pz in piecesNode.get_children():
				if pz is RigidBody3D:
					pz.gravity_scale = 0.0;	
					
					pieceContainer.append(pz);
		

func _on_body_entered(body):
	print("Destroyable body entered");
	if body.is_in_group("Car"):
		Explode();
		if audioPlayer.playing == false:
			var pitch = randf_range(pitchMin, pitchMax);
			audioPlayer.pitch_scale = pitch;
			audioPlayer.play();
		if body is Vehicle:
			var direction = (body.global_transform.origin - global_transform.origin).normalized();
			body.apply_force(direction * buildingSize * destroyedForceMultiplier)
			game_manager.add_points(buildingSize + ((body.speed_kph - buildingSize) * pointMultiplier))
		pass

