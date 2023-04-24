extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	look_at(Vector3.ZERO)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	var dir = $Sprite.global_position.direction_to($"../Player".position)
#	#print(dir)
#
#	$Sprite.global_transform = $Sprite.global_transform.orthonormalized()
#	if $Sprite.transform.basis.y.normalized().cross(-dir) != Vector3():
#		look_at(dir, $Sprite.global_transform.basis.y)
#	elif $Sprite.global_transform.basis.x.normalized().cross(-dir) != Vector3():
#		look_at(dir, $Sprite.global_transform.basis.x)
	
	
	#dir *= $Sprite.
	#$Sprite.rotation.y = dir.y
	
	#$Sprite.look_at($"../Player".position, $Sprite.global_transform.basis.y)
	#$Sprite.rotate_object_local(Vector3.FORWARD, PI/2)
	pass
