extends Node3D

@export var enemy_scenes: Array[PackedScene] = []
@export var spawn_positions: Array[Vector3] = []

func _ready():
	var enemies_to_spawn = [
		{ "scene": enemy_scenes[0], "pos": Vector3(-13, 2, -2) },
		{ "scene": enemy_scenes[0], "pos": Vector3(0, 3, 2) },
		{ "scene": enemy_scenes[0], "pos": Vector3(6, 1, 0) },
		{ "scene": enemy_scenes[0], "pos": Vector3(-8, 1, -14) },
		{ "scene": enemy_scenes[0], "pos": Vector3(-3, 1, 10) }
	]

	for item in enemies_to_spawn:
		var instance = item["scene"].instantiate()
		instance.global_transform.origin = item["pos"]
		add_child(instance)



func spawn_all_enemies():
	for i in spawn_positions.size():
		var index = i % enemy_scenes.size()
		var enemy = enemy_scenes[index].instantiate()
		if enemy:
			enemy.global_transform.origin = spawn_positions[i]
			get_parent().add_child(enemy)
