extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var move_speed = 50

export var pitch_max_vlaue = 45
export var pitch_speed = 20

export var yaw_max_value = 45
export var yaw_speed = 20

export var roll_max_value = 45
export var roll_speed = 20

var model : MeshInstance


# Called when the node enters the scene tree for the first time.
func _ready():
	model = find_node("Plane")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_move(delta)
	var mouse_speed = _get_mouse_speed()
	_pitch(delta, mouse_speed.y)
	_yaw(delta, mouse_speed.x)
	_roll(delta)
	_yaw_and_roll_model(delta, mouse_speed.x)
	
func _move(delta):
	global_translate(-transform.basis.z * move_speed * delta)
	
func _pitch(delta, mouse_speed_y):
	rotate_object_local(Vector3.LEFT, deg2rad(mouse_speed_y * pitch_speed * delta))
	model.rotation_degrees.x = lerp(0, pitch_max_vlaue, abs(mouse_speed_y)) * sign(mouse_speed_y)
	
func _yaw(delta, mouse_speed_x):
	rotate_object_local(Vector3.DOWN, deg2rad(mouse_speed_x * yaw_speed * delta))
	
func _roll(delta):
	var roll_val = int(Input.is_action_pressed("roll_right")) - int(Input.is_action_pressed("roll_left"))
	rotate_object_local(Vector3.FORWARD, deg2rad(roll_val * roll_speed * delta))
	pass
	
func _yaw_and_roll_model(delta, mouse_speed_x):
	model.rotation_degrees.y = - lerp(0, yaw_max_value, abs(mouse_speed_x)) * sign(mouse_speed_x) + 180
	model.rotation_degrees.z = lerp(0, roll_max_value, abs(mouse_speed_x)) * sign(mouse_speed_x)
	
func _get_mouse_speed():
	var mouse_speed = Vector2()
	var mouse_position = get_viewport().get_mouse_position()
	var view_port_center = get_viewport().size / 2
	
	mouse_speed.x = (mouse_position.x - view_port_center.x) / view_port_center.x
	mouse_speed.y = (mouse_position.y - view_port_center.y) / view_port_center.y
	
	return mouse_speed
	



func _on_Area_body_entered(body):
	print_debug(body.is_in_group("terrain"))
	pass # Replace with function body.


func _on_Area_body_shape_entered(body_id, body, body_shape, area_shape):
	print_debug(body.is_in_group("terrain"))
	pass # Replace with function body.


func _on_RigidBody_body_entered(body):
	print_debug(body.is_in_group("terrain"))
	pass # Replace with function body.


func _on_Area2_body_shape_entered(body_id, body, body_shape, local_shape):
	print_debug(body.is_in_group("terrain"))
	pass # Replace with function body.
