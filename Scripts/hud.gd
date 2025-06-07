extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CoinsLabel.text = str(0)
	Global.connect("coins_updated", Callable(self, "_on_coins_updated"))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# $CoinsLabel.text = str(Global.coins)
	pass
	
func update_coins_display(new_value: int) -> void:
	$CoinsLabel.text = str(new_value)
	$CoinsLabel/CoinsLabelAnimator.play("flash_and_scale")
	
	
func _on_coins_updated(new_value: int) -> void:
	update_coins_display(new_value)
