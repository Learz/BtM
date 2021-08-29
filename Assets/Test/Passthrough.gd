extends ViewportContainer

onready var node_viewport : Viewport = get_node("Viewport")

func _on_ViewportContainer_gui_input(event):
	if event is InputEventMouseButton:
		node_viewport.input(event)
