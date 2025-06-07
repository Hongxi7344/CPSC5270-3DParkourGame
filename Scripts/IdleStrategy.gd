class_name IdleStrategy

extends EnemyStrategy

func act(enemy: CharacterBody3D, delta: float) -> void:
	enemy.velocity = Vector3.ZERO
	enemy.move_and_slide()
