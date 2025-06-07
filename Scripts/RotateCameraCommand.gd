extends Command
class_name RotateCameraCommand

var direction := 1

func _init(dir := 1):
	direction = dir

func execute(actor: Node) -> void:
	var camera = actor.get_node("Camera_Controller")
	camera.rotate_y(deg_to_rad(30 * direction))
