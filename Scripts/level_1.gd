extends Node3D

@onready var hud := $HUD 
@onready var builder := preload("res://Scripts/LevelBuilder.gd").new()


func _ready() -> void:
	Global.coins = 0
	builder.coin_scene = preload("res://Scenes/coin.tscn")
	builder.enemy_scene = preload("res://Scenes/enemy.tscn")
	builder.platform_scene = preload("res://Scenes/platform_3x_2.tscn")
	builder.hud = hud

	# Add Coin, Enemy, and Platform configurations
	builder.add_coin(Vector3(2, 1, 0)).add_coin(Vector3(4, 1, 0))
	
	builder.add_enemy(Vector3(6, 0, 0), "idle")
	builder.add_enemy(Vector3(10, 6.5, 22), "idle")
	builder.add_enemy(Vector3(14, 0, 0), "idle")
	builder.add_enemy(Vector3(14, 0, 14), "idle")
	#builder.add_enemy(Vector3(2, 0, 0), "patrol")

	builder.add_platform(Vector3(-56, -7, -52), Vector3(-56, 7, -52), 2.0, 0.8, true)

	# Build the level
	builder.build(self)



func _process(delta: float) -> void:
	pass
