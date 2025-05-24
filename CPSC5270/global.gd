extends Node


signal coins_updated(new_value: int)
var coins := 0

const NUM_COINS_TO_WIN = 65

func add_coin():
	coins += 1
	emit_signal("coins_updated", coins)

func save_game():
	var save = FileAccess.open("user://savegame.dat", FileAccess.WRITE)
	save.store_var(coins)
	
	
func load_game():
	if FileAccess.file_exists("user://savegame.dat"):
		var save = FileAccess.open("user://savegame.dat", FileAccess.READ)
		coins = save.get_var()
