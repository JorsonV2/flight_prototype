extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var move_speed = 100
export var rotate_speed : float = 20
export var max_plane_rotation = 45
export var plane_rotation_speed = 2

var velocity
var plane_rotation = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	var angle = get_rotation().y   
#	velocity = Vector3(sin(angle),0, cos(angle)) * move_speed
	global_translate(transform.basis.z.normalized() * move_speed * delta)
#	rotate_object_local(Vector3.LEFT, rotate_speed * delta)
#	rotate_x(rotate_speed * delta)
#	rotate_y(rotate_speed * delta)
#	translate()
#	
	rotate_plane(delta)
	pass
	
func rotate_plane(delta):
	# get input for rotation
	var rotation_horizontal = int(Input.is_action_pressed("left")) - int(Input.is_action_pressed("right"))
	var rotation_vertical = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	
	# rotate spatial
	rotate_object_local(Vector3(0, 1, 0), rotate_speed * delta * rotation_horizontal)
	rotate_object_local(Vector3(1, 0, 0), rotate_speed * delta * rotation_vertical)
	
	# rotate plane object
	if rotation_horizontal:
		plane_rotation += -rotation_horizontal * plane_rotation_speed * delta
	elif plane_rotation != 0:
		plane_rotation = lerp(max_plane_rotation * (plane_rotation / abs(plane_rotation)), 0 , min(1, 1 - (abs(plane_rotation) / max_plane_rotation) + (delta * rotate_speed)))
		
	plane_rotation = min(max_plane_rotation, max(-max_plane_rotation, plane_rotation))
	$plane.rotation_degrees.z = plane_rotation
	pass
