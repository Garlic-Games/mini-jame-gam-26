extends Node3D

@export var rotationSpeed : float = 4.0;
@export var floatingAmplitude : float = 5.5;
@export var floatingPeriod : float = 2.0;

var initialPositionY : float;
var timer : float = 0.0;

func _ready():
	initialPositionY = position.y;
	
func _process(delta):
	rotate_y(4 * delta);
	
	timer += delta;
	
	if timer > floatingPeriod:
		timer -= floatingPeriod;
	
	position.y = initialPositionY + floatingAmplitude * sin(2.0 * PI / floatingPeriod * timer);
