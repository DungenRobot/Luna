extends Node3D

var sun_dir = Vector3()

const NIGHT_STAGE = -0.1
const DAY_STAGE = 0.3
const SUN_RANGE = DAY_STAGE - NIGHT_STAGE


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#$Player.point_gravity = Vector3.ZERO
	
	sun_dir = $SunLight.transform.basis.z
	
	$MoonLight.look_at_from_position($Moon.position, $Planet.position)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	
	var sun_angle = -$Player.position.direction_to(Vector3.ZERO).dot(sun_dir)
	
	var time_trans = clampf(sun_angle - NIGHT_STAGE, 0, SUN_RANGE) / SUN_RANGE
	
	print(sun_angle)
	print(time_trans)
	
	#var temp = ((sun_angle + 1) / 2) * SUN_RANGE
	
	#var lerpV = clampf(temp + BLACK_STAGE, 0, 1)
	var sky_color = Color.BLACK.lerp(Color.SKY_BLUE, time_trans)
	$WorldEnvironment.environment.fog_light_color = sky_color
	$WorldEnvironment.environment.background_color = sky_color
	
#	if sun_angle < 0:
#		$WorldEnvironment.environment.background_color = Color.SKY_BLUE
#		$WorldEnvironment.environment.fog_enabled = true
#	else:
#		$WorldEnvironment.environment.background_color = Color.BLACK
#		$WorldEnvironment.environment.fog_enabled = false
		
	
