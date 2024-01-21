extends Button


var vehicle;
func _ready():
	vehicle = get_parent().vehicle;

func _process(_delta):
	
	text = "Speed: " + ("%.0f" % vehicle.speed_kph) + " km/h"

