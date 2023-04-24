extends Node3D

var sun_dir = Vector3()
var moon_dir = Vector3()

var last_sun_angle: float

const NIGHT_STAGE = -0.4
const DAY_STAGE = 0.2
const FLASH_ON = -0.2
const SUN_RANGE = DAY_STAGE - NIGHT_STAGE

var sun_onscreen = 1
var moon_onscreen = 1

var detected_joypad = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#print(Input.get_connected_joypads())
	#if !Input.get_connected_joypads().is_empty(): $"UI/Main Menu/Sidebar/Buttons/PlayButton".grab_focus()
	
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#$Player.point_gravity = Vector3.ZERO
	
	sun_dir = $SunLight.transform.basis.z
	moon_dir = Vector3.ZERO.direction_to($Moon.position)
	
	#$MoonLight.look_at_from_position($Moon.position, $Planet.position)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("menu"):
		
		if $UI/Credits.visible: 
			$UI/Credits.hide()
			$UI/Credits/ComfortaLicense.hide()
			return
		if $"UI/Main Menu".visible: 
			get_tree().quit()
			return
		
		if $UI/Gameplay.visible:
			$UI/Gameplay.hide()
			$Player.can_move = 1
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			$UI/Gameplay.show()
			$Player.can_move = 0
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
		
		#get_tree().quit()
	
	var sun_angle = -$Player.position.direction_to(Vector3.ZERO).dot(sun_dir)
	var moon_angle = -$Player.position.direction_to(Vector3.ZERO).dot(moon_dir)
	
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
	
	var sound_trans = clampf(sun_angle + 0.6, 0, 0.6) / 0.6
	
	$Day1.volume_db = clampf(sound_trans - 0.9, -0.5, 0) / 0.5 * 80
	$Day2.volume_db = clampf(sound_trans - 0.7, -0.5, 0) / 0.5 * 80
	$Day3.volume_db = clampf(sound_trans - 0.5, -0.5, 0) / 0.5 * 80
	
	$SunTrack.volume_db = clampf(sun_angle, -0.2, 0) / 0.2 * 80 + (sun_onscreen * -80)
	#$MoonTrack.volume_db = clampf(sun_angle, -0.3, 0) / 0.4 * 80 + (moon_onscreen * -80)
	
	$Crickets.volume_db = time_trans * -80
	
	if moon_angle > -0.25 and moon_onscreen:
		$MoonTrack.volume_db = clampf(sun_angle, -0.3, 0) / 0.4 * 80
	else: 
		$MoonTrack.volume_db = -80
	# NEEDS CRICKETS AND FIREFLIES
	
	
	#print((clampf(time_trans - 0.5, -0.5, 0) / 0.5) * 80)
	#print(sun_angle)
	
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

func _on_sun_visibility_screen_entered():
	sun_onscreen = 0
func _on_sun_visibility_screen_exited():
	sun_onscreen = 1

func _on_moon_visiblity_screen_entered():
	moon_onscreen = true
func _on_moon_visiblity_screen_exited():
	moon_onscreen = false


func _on_play_button_button_up():
	$Player.can_move = 1
	$"UI/Main Menu".hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED



func _on_exit_button_button_up():
	get_tree().quit()

func _input(event):
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED: return
	if event is InputEventJoypadButton or (event is InputEventJoypadMotion and event.axis_value > 0.2):
	#if event is InputEventJoypadMotion:
		if not detected_joypad: 
			$"UI/Main Menu/Sidebar/Buttons/PlayButton".grab_focus()
			detected_joypad = true
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	if event is InputEventMouse: Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	


func _on_return_botton_button_up():
	$UI/Gameplay.hide()


func _on_credits_button_button_down():
	$UI/Credits.show()

func _on_back_button_down():
	$UI/Credits/ComfortaLicense.hide()


func _on_comforta_button_down():
	$UI/Credits/ComfortaLicense.show()


func _on_backC_button_down():
	$UI/Credits.hide()
