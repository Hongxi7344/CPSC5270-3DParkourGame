extends Node

class_name LevelBuilder 

@export var coin_scene: PackedScene
@export var enemy_scene: PackedScene
@export var platform_scene: PackedScene

@export var hud: CanvasLayer

var _coin_positions: Array[Vector3] = []
var _enemy_configs: Array[Dictionary] = []
var _platform_configs: Array[Dictionary] = []

const GlowPlatformMaterial := preload("res://Resources/GlowPlatformMaterial.tres")


func add_coin(pos: Vector3) -> LevelBuilder:
	_coin_positions.append(pos)
	return self

func add_enemy(pos: Vector3, strategy_type: String = "patrol") -> LevelBuilder:
	_enemy_configs.append({
		"pos": pos,
		"strategy": strategy_type
	})
	return self


func add_platform(c: Vector3, d: Vector3, time := 2.0, pause := 0.7, glow := false) -> LevelBuilder:
	_platform_configs.append({
		"c": c,
		"d": d,
		"time": time,
		"pause": pause,
		"glow": glow
	})
	return self

func build(parent: Node) -> void:
	# Build coins
	for pos in _coin_positions:
		var coin := coin_scene.instantiate()
		coin.position = pos
		coin.hud = hud
		parent.add_child(coin)
		
	# Build enemies
	for config in _enemy_configs:
		var enemy := enemy_scene.instantiate()
		enemy.position = config["pos"]

		var strategy_type = config.get("strategy", "patrol")
		var strategy = create_enemy_strategy(strategy_type)

		if strategy:
			enemy.strategy = strategy
			enemy.add_child(strategy)

		parent.add_child(enemy)

	# Build platforms
	for config in _platform_configs:
		var platform := platform_scene.instantiate()
		platform.position = config["c"]
		platform.c = config["c"]
		platform.d = config["d"]
		platform.time = config["time"]
		platform.pause = config["pause"]
		if config.get("glow", false):
			var glowing_mat := GlowPlatformMaterial.duplicate()
			platform.get_node("MeshInstance3D").set_surface_override_material(0, glowing_mat)
			var glow := preload("res://Scripts/GlowDecorator.gd").new()
			platform.add_child(glow)
		parent.add_child(platform)
		
# Factory Method for creating enemy strategies
func create_enemy_strategy(type: String) -> EnemyStrategy:
	match type:
		"patrol":
			return PatrolStrategy.new()
		"idle":
			return IdleStrategy.new()
		_:
			push_warning("Unknown strategy type: %s" % type)
			return PatrolStrategy.new()
