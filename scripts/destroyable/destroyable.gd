extends Node

@export var minimumSpeed : float = 20.0;
@export var explosionForce : float = 15.0;

var explosionCenter : Vector3 = Vector3.ZERO;

var piecesNode : Node = null;
var modelNode : Node = null;

var pieces : Array = [];

func _ready():
	FindRigidBodies(self, pieces);

	if piecesNode:
		piecesNode.set_process(false);
		piecesNode.hide();
	
	set_process_input(true) 
	
func _input(ev):
	if Input.is_key_pressed(KEY_K):
		Explode();
		
func Explode():
	var forceDirection : Vector3;
	var randomVector : Vector3;
	
	piecesNode.set_process(true);
	piecesNode.show();
	
	modelNode.set_process(false);
	modelNode.hide();
	
	for piece in pieces:
		forceDirection = explosionCenter.direction_to(piece.position);
		
		randomVector = Vector3(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1)) * forceDirection;
		piece.apply_force(randomVector, forceDirection * explosionForce * 1000.0);

func FindRigidBodies(node : Node, pieceContainer : Array):
	for child in node.get_children():
		if child is RigidBody3D:
			pieceContainer.append(child);
			child.gravity_scale=0;
			
			if piecesNode == null:
				piecesNode = node;

		if child.get_child_count() > 0:
			FindRigidBodies(child, pieces);
		
		elif modelNode == null:
			modelNode = node;
