extends CanvasLayer

@export var delorean: Vehicle;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var revolutions = get_node("Revolutions");
	var metersSecond = get_node("Revolutions/MettersPerSeccond");
	revolutions.change_revolutions(delorean.rpm_percent);
	metersSecond.change_speed(delorean.speed_kph);
