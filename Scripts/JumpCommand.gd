extends Command
class_name JumpCommand

func execute(actor: Node) -> void:
	if actor.is_on_floor():
		actor.velocity.y = actor.JUMP_VELOCITY
		actor.can_double_jump = true
		actor.get_node("AudioStreamPlayer_Jump").play()
		actor.get_node("AnimationPlayer").play("jump")
	elif actor.can_double_jump:
		actor.velocity.y = actor.JUMP_VELOCITY
		actor.can_double_jump = false
		actor.get_node("AudioStreamPlayer_Jump").play()
		actor.get_node("AnimationPlayer").play("jump")
