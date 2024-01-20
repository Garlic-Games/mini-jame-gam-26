extends Node

@export var minimumSpeed : float = 30.0; # km/h
@export var explosionForce : float = 5.0;
@export var despawnTime : float = 4.0;

var timerDespawn = 0.0;

var explosionCenter : Vector3 = Vector3.ZERO;

var piecesNode : Node = null;
var modelNode : Node = null;
var pieces : Array = [];

var isDestroyed = false;

func _ready():
	FindRigidBodies(self, pieces);

	if piecesNode:
		piecesNode.set_process(false);
		piecesNode.hide();
	
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
		
		elif child.name == "Rest in Pieces":
			piecesNode = child;
			
			for pz in piecesNode.get_children():
				if pz is RigidBody3D:
					pieceContainer.append(pz);
					pz.gravity_scale = 0.0;	
