extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var open := false
onready var inventory = get_node("Backpack/InvMask")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var cam = get_viewport().get_camera()
	var screen_pos = cam.unproject_position(translation)
	inventory.set_position(Vector2(screen_pos.x-inventory.rect_size.x/2,screen_pos.y-270))

func _on_StaticBody_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and !$Tween.is_active():
			var movement = 0.5 if open else -0.5
			var speed = 0.4 if open else 0.78
			$Tween.interpolate_property(self, "translation", translation, translation - Vector3(0,0,movement), 0.75, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
			$Tween.interpolate_property(inventory, "rect_size", Vector2(340, float(open)*270), Vector2(340, float(!open)*270), speed)
			$Tween.start()
			open = !open
			if open:
				$AnimationPlayer.play("Open", -1, 0.85)
			else:
				$AnimationPlayer.play_backwards("Open")
