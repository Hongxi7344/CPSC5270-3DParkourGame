extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 5
var can_double_jump := false
var xform : Transform3D

@onready var PlayerJumpAudioStream =$AudioStreamPlayer_Jump
@onready var FallIntoWaterAudioStream = $AudioStreamPlayer_FallIntoWater
@onready var input_handler := preload("res://Scripts/InputHandler.gd").new()


# Movement interface (Facade)
func move(direction2d: Vector2) -> void:
	if direction2d != Vector2.ZERO:
		var direction = ($Camera_Controller.transform.basis * Vector3(direction2d.x, 0, direction2d.y)).normalized()
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED

		# Rotate character
		$Armature.rotation_degrees.y = $Camera_Controller.rotation_degrees.y - rad_to_deg(direction2d.angle()) - 90
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

func jump() -> void:
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		PlayerJumpAudioStream.play()
		can_double_jump = true
		$AnimationPlayer.play("jump")
	elif can_double_jump:
		velocity.y = JUMP_VELOCITY
		PlayerJumpAudioStream.play()
		can_double_jump = false
		$AnimationPlayer.play("jump")

func rotate_camera_left():
	$Camera_Controller.rotate_y(deg_to_rad(30))

func rotate_camera_right():
	$Camera_Controller.rotate_y(deg_to_rad(-30))

func update_animation(input_dir: Vector2):
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$AnimationPlayer.play("jump")
	elif is_on_floor() and input_dir != Vector2.ZERO:
		$AnimationPlayer.play("run")
	elif is_on_floor():
		$AnimationPlayer.play("idle")

func handle_input():
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	update_animation(input_dir)
	move(input_dir)

	input_handler.handle_input(self)
#
	if Input.is_action_just_pressed("save_game"):
		Global.save_game()
	if Input.is_action_just_pressed("load_game"):
		Global.load_game()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	handle_input()
	align_and_interpolate()

	move_and_slide()
	$Camera_Controller.position = lerp($Camera_Controller.position, position, 0.12)

func align_and_interpolate():
	var normal = $RayCast3D.get_collision_normal() if is_on_floor() else Vector3.UP

	align_with_floor(normal)
	global_transform = global_transform.interpolate_with(xform, 0.3)


func align_with_floor(floor_normal):
	xform = global_transform
	xform.basis.y = floor_normal
	xform.basis.x = - xform.basis.z.cross(floor_normal)
	xform.basis = xform.basis.orthonormalized()
	
	

func _on_fall_zone_body_entered(body: Node3D) -> void:
	FallIntoWaterAudioStream.play()
	await get_tree().create_timer(0.4).timeout
	get_tree().change_scene_to_file("res://Scenes/menu_game_over.tscn")
	
func bounce():
	velocity.y = JUMP_VELOCITY * 0.7
	
	
