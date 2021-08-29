extends Area
class_name CamArea


export var fov = 30
export var angle = Vector3(0,0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_CamArea_body_entered(body):
	if body is Character:
		body = body as Character
		Global.tween.interpolate_property(body.cam_point, "rotation", body.cam_point.rotation, angle, 4, Tween.TRANS_QUART, Tween.EASE_OUT)
		Global.tween.interpolate_property(body.player_cam, "fov", body.player_cam.fov, fov, 2, Tween.TRANS_QUART, Tween.EASE_OUT)
		Global.tween.start()


func _on_CamArea_body_exited(body):
	if body is Character:
		body = body as Character
		Global.tween.interpolate_property(body.cam_point, "rotation", body.cam_point.rotation, Vector3(0,0,0), 4, Tween.TRANS_QUART, Tween.EASE_OUT)
		Global.tween.interpolate_property(body.player_cam, "fov", body.player_cam.fov, 30, 2, Tween.TRANS_QUART, Tween.EASE_OUT)
		Global.tween.start()
