extends Node

class_name SaveManager

func save_game():
	var data = {
		"best_wave": GameState.best_wave,
		"total_coins": GameState.total_coins,
		"permanent_upgrades": GameState.permanent_upgrades,
		"last_played": Time.get_ticks_msec()
	}

	var json_string = JSON.stringify(data)
	var file = FileAccess.open(Constants.SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(json_string)
		return true
	return false

func load_game() -> Dictionary:
	if FileAccess.file_exists(Constants.SAVE_PATH):
		var file = FileAccess.open(Constants.SAVE_PATH, FileAccess.READ)
		if file:
			var json_string = file.get_as_text()
			var json = JSON.new()
			if json.parse(json_string) == OK:
				return json.data
	return get_default_save()

func get_default_save() -> Dictionary:
	return {
		"best_wave": 0,
		"total_coins": 0,
		"permanent_upgrades": {
			"damage": 0,
			"speed": 0,
			"health": 0,
			"echo_duration": 0,
			"echo_spawn_rate": 0,
			"crit_chance": 0
		}
	}

func auto_save():
	save_game()
