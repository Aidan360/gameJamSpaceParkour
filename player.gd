extends RigidBody3D

var sensitivity:=0.001
var twist:=0.0
var pitch:=0.0
var previous_frame_force=0.0
var previous_raycast_cords=Vector3.ZERO
var raycast_length=0.0
var tilt=0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input:=Vector3.ZERO
	input.x=Input.get_axis("left", "right")
	if get_contact_count()>0:
		input.y=Input.get_action_strength("jump")*5
	input.z=Input.get_axis("forward", "back")
	var current_force=$twist_pivot.basis*input*1200*delta
	var current_raycast=Vector3.ZERO
	if Input.is_action_pressed("grapple"):
		
		pass
		
		#if Input.is_action_just_pressed("grapple"):
			#current_raycast=$player_raycast.get_target_position()
			#raycast_length=sqrt((current_raycast.x-global_position.x)**2 + (current_raycast.y-global_position.y)**2 + (current_raycast.z-global_position.z)**2)
		#if Input.is_action_pressed("grapple_pull"):
			#raycast_length=raycast_length*.99
		#var current_length=sqrt(($player_raycast.get_target_position().x-global_position.x)**2 + ($player_raycast.get_target_position().y-global_position.y)**2 + ($player_raycast.get_target_position().z-global_position.z)**2)
		#if current_length<raycast_length:
			#var normalized_raycast=raycast_length.normalized()
			#var correction=normalized_raycast*(raycast_length-current_length)
			#var new_transform=transform
			#new_transform.origin+=correction
			#transform=new_transform
			#var current_velocity=linear_velocity
			#var velocity_dot_normal=current_velocity.dot(normalized_raycast)
			#if velocity_dot_normal<0:
				#linear_velocity-=normalized_raycast*velocity_dot_normal
	elif Input.is_action_pressed("slide"):
		current_force=previous_frame_force
		if get_contact_count()>0:
			current_force=current_force*.99
		apply_central_force(current_force)
		# TODO: have character actually tilt when sliding
		#if tilt<45:
			#tilt=tilt+.01
		#rotate_x(deg_to_rad(tilt)*delta)
	else:
		apply_central_force(current_force)
		# TODO: untilt character once they're done sliding
		#if tilt>0:
			#tilt=tilt-.01
		#rotate_x(deg_to_rad(tilt)*delta)
	if Input.is_action_just_pressed("close_game"):
		if Input.get_mouse_mode()==Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$twist_pivot.rotate_y(twist)
	$twist_pivot/pitch_pivot.rotate_x(pitch)
	twist=0.0
	pitch=0.0
	previous_frame_force=current_force
	previous_raycast_cords=current_raycast
	
	
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		twist=-event.relative.x*sensitivity
		pitch=-event.relative.y*sensitivity
