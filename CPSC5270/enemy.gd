extends CharacterBody3D

var speed = 3.0

var turning := false
@export var direction := Vector3(-1, 0, 0)
@export var turns_around_at_edges := true


func _physics_process(delta: float) -> void:
	
	velocity.x = speed * direction.x
	velocity.z = speed * direction.z
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	move_and_slide()
	
	if is_on_wall() and not turning:
		turn_around()
		
	if not $RayCast3D.is_colliding() and is_on_floor() and not turning and turns_around_at_edges:
		turn_around()
		
		
func turn_around():
	# boolean: recognize current state
	turning = true
	# backup diirection 
	var dir = direction
	# set direction to 0
	direction = Vector3.ZERO
	# create tween variable
	var turn_tween = create_tween()
	turn_tween.tween_property(self, "rotation_degrees", Vector3(0, 180 ,0), 0.6).as_relative()
	# pause 0.6 secs
	await get_tree().create_timer(0.6).timeout
	
	# set changed direction
	direction.x = dir.x * -1
	direction.z = dir.z * -1
	# end turning state
	turning = false


func _on_sides_checker_body_entered(body: Node3D) -> void:
	get_tree().change_scene_to_file("res://level_1.tscn")


func _on_top_checker_body_entered(body: Node3D) -> void:
	$AnimationPlayer.play("squash")
	body.bounce()
	$SidesChecker.set_collision_mask_value(1, false)
	$TopChecker.set_collision_mask_value(1, false)
	direction = Vector3.ZERO
	speed = 0
	await get_tree().create_timer(1.0).timeout
	queue_free()
	
	
	
	
	
	
	
	
	
