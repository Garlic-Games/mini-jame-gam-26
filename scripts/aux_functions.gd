extends Node

@export var brakeResistance : float = 4.5;

func speedAfterCollision(playerSpeed : float, minimumSpeed : float):
	var finalSpeed : float;
	
	if playerSpeed < minimumSpeed:
		finalSpeed = 0;
	
	else:
		finalSpeed = playerSpeed * (1.0 - exp(-brakeResistance * (playerSpeed/minimumSpeed - 1.0)));

	return finalSpeed;
