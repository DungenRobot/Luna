extends CharacterBody3D

var point_gravity = Vector3.ZERO
var gravity = 2

var grav_accel = Vector3()

var look_input:= Vector2()

var can_move: int = 0

const DEFAULT_SPEED = 5
const LOOK_SPEED = Vector2(-0.6, -0.3)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		look_input = event.relative

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var vec_to_point = point_gravity.direction_to(global_position)

	up_direction = vec_to_point
	
	#print(up_direction)
	
	transform = transform.orthonormalized()
	if transform.basis.y.normalized().cross(-vec_to_point) != Vector3():
		look_at(vec_to_point, transform.basis.y)
	elif transform.basis.x.normalized().cross(-vec_to_point) != Vector3():
		look_at(vec_to_point, transform.basis.x)
	
	#var look_point = vec_to_point.rotated(Vector3.BACK, -PI/2)
	
	#look_at(look_point)
	#rotation = vec_to_point 
	
	look_input *= LOOK_SPEED * can_move
	
	#$Pivot/Camera3D.rotate_object_local($Pivot/Camera3D.transform.basis.x, deg_to_rad(look_input.y))
	$Pivot/Camera3D.rotation_degrees.x += look_input.y
	$Pivot/Camera3D.rotation_degrees.x = clampf($Pivot/Camera3D.rotation_degrees.x, 10, 170)
	$Pivot.rotation_degrees.z += look_input.x
	#$Pivot.rotate_object_local($Pivot.transform.basis.z, deg_to_rad(look_input.x))
	#$Camera3D.rotate_object_local($Camera3D.transform.basis.z, -deg_to_rad(look_input.x))
	#$Camera3D.rotation_degrees.x = clampf($Camera3D.rotation_degrees.x, 0, 180)

	look_input = Vector2.ZERO

func _flashlight(on):
	$OmniLight3D.visible = on

func _physics_process(delta):
	
	velocity = $Pivot.global_transform.basis.y * (Input.get_action_strength("Forward") - Input.get_action_strength("Back"))
	velocity += $Pivot.global_transform.basis.x * (Input.get_action_strength("Right") - Input.get_action_strength("Left"))
	
	velocity *= DEFAULT_SPEED * can_move
	
	var vec_to_point = (global_position - point_gravity).normalized()
	
	
	
	if is_on_floor():
		#print("grounded")
		grav_accel = vec_to_point * -gravity
	else:
		grav_accel += vec_to_point * -gravity * delta
		
	velocity += grav_accel
	
	#print(vec_to_point * -gravity)
	
	move_and_slide()
