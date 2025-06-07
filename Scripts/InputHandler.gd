extends Node
class_name InputHandler

const JumpCommand = preload("res://Scripts/JumpCommand.gd")
const RotateCameraCommand = preload("res://Scripts/RotateCameraCommand.gd")

var jump_command := JumpCommand.new()
var rotate_left_command := RotateCameraCommand.new(1)
var rotate_right_command := RotateCameraCommand.new(-1)

func handle_input(actor: Node) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		jump_command.execute(actor)
	if Input.is_action_just_pressed("cam_left"):
		rotate_left_command.execute(actor)
	if Input.is_action_just_pressed("cam_right"):
		rotate_right_command.execute(actor)
