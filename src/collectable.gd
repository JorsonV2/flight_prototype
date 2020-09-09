extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var rotation_speed = Vector3(1, 2, 3)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation_degrees += rotation_speed * delta

func _on_Area_area_entered(area):
	if area.is_in_group("plane"):
		collect()
	
func collect():
	visible = false
	$collect_sound.play()
	yield($collect_sound, "finished")
	queue_free()
