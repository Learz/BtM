extends KinematicBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const MAX_SPEED = 20
const ACCELERATION = 5
const DECELERATION = 8
const MAX_SLOPE_ANGLE = 30

onready var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var velocity = Vector3(0,0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var dir = Vector3()
	dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	dir.z = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	
	# Limit the input to a length of 1. length_squared is faster to check.
	if dir.length_squared() > 1:
		dir /= dir.length()
	
	velocity.y -= gravity * delta
	
	var hvel = velocity
	hvel.y = 0

	var target = dir * MAX_SPEED
	var acceleration
	if dir.dot(hvel) > 0:
		acceleration = ACCELERATION
	else:
		acceleration = DECELERATION

	hvel = hvel.linear_interpolate(target, acceleration * delta)
	
	if dir.dot(hvel) == 0:
		var _vel_clamp := 0.25
		if hvel.x < _vel_clamp and hvel.x > -_vel_clamp:
			hvel.x = 0
		if hvel.z < _vel_clamp and hvel.z > -_vel_clamp:
			hvel.z = 0
	
	# Assign hvel's values back to velocity, and then move.
	velocity.x = hvel.x
	velocity.z = hvel.z
	velocity.y = move_and_slide_with_snap(velocity, Vector3.DOWN, Vector3.UP, true).y

#	$Char.look_at($Char.global_transform.origin-direction, Vector3.UP)
	if(dir):
		$Char.rotation.y = Vector2(-velocity.x,velocity.z).angle()-deg2rad(90)
		
