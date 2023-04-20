extends Node3D

var sun_dir = Vector3()

var last_sun_angle: float

const NIGHT_STAGE = -0.4
const DAY_STAGE = 0.2
const FLASH_ON = -0.2
const SUN_RANGE = DAY_STAGE - NIGHT_STAGE


# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#$Player.point_gravity = Vector3.ZERO
	
	sun_dir = $SunLight.transform.basis.z
	
	#$MoonLight.look_at_from_position($Moon.position, $Planet.position)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	
	var sun_angle = -$Player.position.direction_to(Vector3.ZERO).dot(sun_dir)
	
	var time_trans = clampf(sun_angle - NIGHT_STAGE, 0, SUN_RANGE) / SUN_RANGE
	
	#print(sun_angle)
	#print(time_trans)
	
	#var temp = ((sun_angle + 1) / 2) * SUN_RANGE
	
	#var lerpV = clampf(temp + BLACK_STAGE, 0, 1)
	var sky_color = Color.BLACK.lerp(Color.SKY_BLUE, time_trans)
	$WorldEnvironment.environment.fog_density = time_trans * -0.02
	$WorldEnvironment.environment.background_color = sky_color
	$Moon.material_override.albedo_color.a = ((1 - time_trans)  * 0.93) + 0.07
	
	$Sun.position = $Player.position + (sun_dir * 10)
	
	$Player/OmniLight3D.light_energy = (1 - time_trans)
	
#	if sign(sun_angle - NIGHT_STAGE) != sign(last_sun_angle - NIGHT_STAGE):
#		if sign(sun_angle - NIGHT_STAGE) == 1:
#			$Player._flashlight(false)
#		else:
#			$Player._flashlight(true)
	
	last_sun_angle = sun_angle

#	if sun_angle < 0:
#		$WorldEnvironment.environment.background_color = Color.SKY_BLUE
#		$WorldEnvironment.environment.fog_enabled = true
#	else:
#		$WorldEnvironment.environment.background_color = Color.BLACK
#		$WorldEnvironment.environment.fog_enabled = false




func _on_play_button_button_up():
	$Player.can_move = 1
	$"UI/Main Menu".hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED



func _on_exit_button_button_up():
	get_tree().quit()
