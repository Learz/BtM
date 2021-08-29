extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func _physics_process(delta):
#	if Input.is_mouse_button_pressed(BUTTON_LEFT):
#		var obj = get_object_under_mouse()
			

func _unhandled_input(event):
	if event is InputEventMouseButton:
		var obj = get_object_under_mouse(event.position)
		var collider = obj.get("collider") as CollisionObject
		if collider:
			get_tree().set_input_as_handled()
			collider.emit_signal("input_event", self, event, obj.get("position"), obj.get("normal"), obj.get("shape"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_object_under_mouse(mouse_pos : Vector2):
#	var mouse_pos = get_viewport().get_mouse_position()
	var ray_from = self.project_ray_origin(mouse_pos)
	var RAY_LENGTH = 100
	var ray_to = ray_from + self.project_ray_normal(mouse_pos) * RAY_LENGTH
	var space_state = get_world().direct_space_state
	var selection = space_state.intersect_ray(ray_from, ray_to)
#	if(selection.size()!=0):
#		print(selection)
	return selection
