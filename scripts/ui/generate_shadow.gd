extends Control

var text_label : Label = null;
var shadow_label : Label = null;


func _ready():
	shadow_label = get_child(0);
	text_label = shadow_label.duplicate();

	self.add_child(text_label);
	
	shadow_label.add_theme_color_override("font_color", Color("000000"));
	
	text_label.position = Vector2(shadow_label.position.x - 4, shadow_label.position.y - 4);
	text_label.add_theme_color_override("font_color", Color("ffffff"));


func _process(_delta):
	text_label.text = shadow_label.text;
