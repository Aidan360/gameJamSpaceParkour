extends CharacterBody3D
func _physics_process(_delta):
	move_and_slide()
	velocity = Vector3(0,0,0)
	var inputDirection = Input.get_vector("left","right","forward","back")
	var direction = (transform.basis * Vector3(inputDirection.x, 0, inputDirection.y)).normalized()
	if direction:
		velocity.x = direction.x * speedMult
		velocity.z = direction.z * speedMult
	else:
		velocity = Vector3(0,0,0)
	
#	vel2D = input_direction * speedMult
	#if Input.is_action_pressed("forward"):
		#vel.z = -speedMult
	#elif Input.is_action_pressed("back"):
		#vel.z = speedMultww
	#if Input.is_action_pressed("left"):
		#vel.x = -speedMult
	#elif Input.is_action_pressed("right"):
		#vel.x = speedMult
	if Input.is_action_pressed("up"):
		velocity.y = speedMult
	elif Input.is_action_pressed("down"):
		velocity.y = -speedMult
	#vel.rotated(rotate_object_local(Vecotr3(0,1,0)))
	##velocity = Vector3(100,100,100)
var rot_x = 0
var rot_y = 0

func _input(event):
	if event is InputEventMouseMotion:
		# modify accumulated mouse rotation
		rot_x += event.relative.x * -0.025
		rot_y += event.relative.y * -0.025
		transform.basis = Basis() # reset rotation
		rotate_object_local(Vector3(0, 1, 0), rot_x) # first rotate in Y
		rotate_object_local(Vector3(1, 0, 0), rot_y) # then rotate in X
	
	
	
var speedMult = 10
