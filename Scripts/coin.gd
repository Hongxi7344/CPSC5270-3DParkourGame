extends Area3D

# number of degrees the coin rotates every frame
const ROT_SPEED = 3 
@export var hud : CanvasLayer
@onready var PickupCoinAudioSteam = $AudioStreamPlayer_PickupCoin


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	if hud == null:
		push_warning("⚠️ HUD reference not set for Coin!")
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(deg_to_rad(ROT_SPEED))
	

func _on_body_entered(body: Node3D) -> void:
	Global.add_coin()
	PickupCoinAudioSteam.play()
	if Global.coins >= Global.NUM_COINS_TO_WIN:
		get_tree().change_scene_to_file("res://Scenes/menu_win.tscn")
	set_collision_layer_value(3, false)
	set_collision_mask_value(1, false)
	$AnimationPlayer.play("bounce")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
