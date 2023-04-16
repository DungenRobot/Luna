extends CharacterBody3D

var point_gravity = Vector3.ZERO
var gravity = 2

var grav_accel = Vector3()

const DEFAULT_SPEED = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var vec_to_point = (position - point_gravity).normalized()
	up_direction = vec_to_point
	rotation = vec_to_point
	
	pass

func _physics_process(delta):
	
	var vec_to_point = (position - point_gravity).normalized()
	
	if is_on_floor():
		grav_accel = vec_to_point * -gravity
	else:
		grav_accel += vec_to_point * -gravity * delta
		
	velocity += grav_accel
	
	#print(vec_to_point * -gravity)
	
	move_and_slide()
