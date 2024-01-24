extends Control

@export var vehicle: VehicleBody3D 
@export var progress_bar : ProgressBar


func _process(_delta):
	var reset_count = vehicle.reset_count;
	if (reset_count > 0.1):
		var percent = reset_count * 100 / vehicle.reset_time_seconds;
		progress_bar.value = percent;
		show();
	else:
		hide();
