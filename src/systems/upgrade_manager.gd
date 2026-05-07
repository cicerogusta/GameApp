extends Node

class_name UpgradeManager

var available_upgrades: Array = [
	{"name": "Damage Boost", "stat": "damage", "description": "+20% Damage"},
	{"name": "Speed Boost", "stat": "speed", "description": "+15% Movement Speed"},
	{"name": "Health Boost", "stat": "health", "description": "+1 Health"},
	{"name": "Echo Duration", "stat": "echo_duration", "description": "+50% Echo Duration"},
	{"name": "Echo Spawn Rate", "stat": "echo_spawn_rate", "description": "+30% Echo Spawn"},
	{"name": "Critical Hit", "stat": "crit_chance", "description": "20% Crit x2 Damage"},
]

signal upgrade_offered(upgrades: Array)
signal upgrade_selected(upgrade: Dictionary)

func _ready():
	pass

func offer_upgrades():
	var selected: Array = []
	var indices: Array = []

	for i in range(3):
		var idx = randi() % available_upgrades.size()
		while idx in indices:
			idx = randi() % available_upgrades.size()
		indices.append(idx)
		selected.append(available_upgrades[idx])

	upgrade_offered.emit(selected)
	return selected

func apply_upgrade(upgrade: Dictionary):
	if upgrade in available_upgrades:
		GameState.add_upgrade(upgrade["name"])
		upgrade_selected.emit(upgrade)

		# Play level-up sound
		var audio_mgr = get_tree().root.get_node("Game/AudioManager")
		if audio_mgr:
			audio_mgr.play_sfx("levelup", 0.0)

		return true
	return false

func get_upgrade_effect(upgrade_name: String) -> float:
	match upgrade_name:
		"Damage Boost":
			return 1.2
		"Speed Boost":
			return 1.15
		"Echo Duration":
			return 1.5
		"Echo Spawn Rate":
			return 1.3
		_:
			return 1.0
