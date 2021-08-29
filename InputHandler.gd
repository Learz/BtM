extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var touchStart = Vector2()
var joyLength = 128
onready var player = get_node("/root/Spatial/3DViewportContainer/Game/char")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if !touchStart:
				touchStart = event.global_position
				$TouchFeedback.visible = true
				$TouchFeedbackOrigin.visible = true
				$TouchFeedback.rect_position = (event.position-($TouchFeedback.rect_size/2))
				$TouchFeedbackOrigin.rect_position = (event.position-($TouchFeedbackOrigin.rect_size/2))
		if !event.is_pressed():
			get_tree().set_input_as_handled()
			touchStart = Vector2.ZERO
			$TouchFeedback.visible = false
			$TouchFeedbackOrigin.visible = false
	if event is InputEventMouseMotion and touchStart:
		var tempDir = ((event.global_position-touchStart)/joyLength).clamped(1)
		player.dir = Vector3(tempDir.x,0,tempDir.y)
		$TouchFeedback.rect_position = (touchStart+tempDir*joyLength)-($TouchFeedback.rect_size/2)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !touchStart:
		player.dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		player.dir.z = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
