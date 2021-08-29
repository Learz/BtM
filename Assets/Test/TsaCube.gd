extends Spatial
class_name TsaCube

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StaticBody_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			Global.get_node("Tween").interpolate_property(self, "translation", translation, translation - Vector3(0,0,-1), 1.0, Tween.TRANS_BACK, Tween.EASE_IN)
			Global.get_node("Tween").start()
