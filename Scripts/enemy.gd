
extends CharacterBody3D

@export var speed := 3.0
@export var direction := Vector3(-1, 0, 0)
@export var turns_around_at_edges := true
@export var strategy: EnemyStrategy

var turning := false
var has_been_hit := false

@onready var SquashAudioStream = $AudioStreamPlayer_Squash
@onready var FailAudioStream = $AudioStreamPlayer_Fail

func _ready():
	if strategy == null:
		strategy = get_node_or_null("Strategy")
	if strategy == null:
		strategy = PatrolStrategy.new()
		add_child(strategy)

func _physics_process(delta):
	if strategy:
		strategy.act(self, delta)

func turn_around():
	turning = true
	var dir = direction
	direction = Vector3.ZERO
	var turn_tween = create_tween()
	turn_tween.tween_property(self, "rotation_degrees", Vector3(0, 180, 0), 0.6).as_relative()
	await get_tree().create_timer(0.6).timeout
	direction.x = dir.x * -1
	direction.z = dir.z * -1
	turning = false

func _on_sides_checker_body_entered(body: Node3D) -> void:
	if has_been_hit:
		return
	has_been_hit = true
	FailAudioStream.play()
	await get_tree().create_timer(0.7).timeout
	get_tree().change_scene_to_file("res://Scenes/menu_game_over.tscn")

func _on_top_checker_body_entered(body: Node3D) -> void:
	if has_been_hit:
		return
	has_been_hit = true
	$AnimationPlayer.play("squash")
	SquashAudioStream.play()
	body.bounce()
	$SidesChecker.set_collision_mask_value(1, false)
	$TopChecker.set_collision_mask_value(1, false)
	direction = Vector3.ZERO
	speed = 0
	await get_tree().create_timer(1.0).timeout
	queue_free()

	
	
	
	
	
	
	
