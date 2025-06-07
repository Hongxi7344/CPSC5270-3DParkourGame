class_name PatrolStrategy

extends EnemyStrategy

func act(enemy: CharacterBody3D, delta: float) -> void:

	enemy.velocity.x = enemy.speed * enemy.direction.x
	enemy.velocity.z = enemy.speed * enemy.direction.z

	if not enemy.is_on_floor():
		enemy.velocity += enemy.get_gravity() * delta

	enemy.move_and_slide()


	if enemy.is_on_wall() and not enemy.turning:
		enemy.turn_around()

	if enemy.is_on_floor() and not enemy.turning and enemy.turns_around_at_edges:
		var ray = enemy.get_node("RayCast3D")
		if ray and not ray.is_colliding():
			enemy.turn_around()
