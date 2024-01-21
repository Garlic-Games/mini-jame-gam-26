extends Area3D


var lights: Array[OmniLight3D];

func _ready():
	lights = getAllLights(self)
	print("Light count", lights.size())
	setLightsEnabled(false);
	
func setLightsEnabled(enabled: bool):
	print("Changing lights to ", enabled)
	for light in lights:
		if enabled:
			light.show()
		else:
			light.hide()

func getAllLights(node):
	var lights: Array[OmniLight3D] = []
	
	if node is OmniLight3D:
		lights.append(node)
	
	for i in range(node.get_child_count()):
		var child = node.get_child(i)
		lights += getAllLights(child)
	return lights


func _on_body_entered(body):
	if body is Vehicle:
		setLightsEnabled(true);


func _on_body_exited(body):
	if body is Vehicle:
		setLightsEnabled(false);
