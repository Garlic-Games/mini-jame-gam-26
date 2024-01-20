extends Node

@export var minimumSpeed : float = 20.0;
@export var explosionForce : float = 15.0;

var pieces : Array;
var explosionCenter : Vector3 = Vector3.ZERO;

func _ready():
	FindRigidBodies(get_tree().get_root(), pieces);
	
func Explode():
	var forceDirection : Vector3;
	var randomVector : Vector3;
	
	for piece in pieces:
		forceDirection = explosionCenter.direction_to(piece.position);
		
		randomVector = Vector3(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1)) * forceDirection;
		piece.apply_force(randomVector, forceDirection * explosionForce * 1000.0);

func FindRigidBodies(node : Node, pieceContainer : Array):
	for child in node.get_children():
		if child is RigidBody3D:
			pieceContainer.append(child);
			child.gravity_scale=0;

		if child.get_child_count() > 0:
			FindRigidBodies(child, pieces);
