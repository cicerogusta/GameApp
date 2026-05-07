extends Node

var best_wave: int = 0
var total_coins: int = 0
var current_coins: int = 0
var current_wave: int = 0
var current_health: int = 3

var permanent_upgrades: Dictionary = {
	"damage": 0,
	"speed": 0,
	"health": 0,
	"echo_duration": 0,
	"echo_spawn_rate": 0,
	"crit_chance": 0
}

var current_run_upgrades: Array = []

signal coins_changed(amount: int)
signal health_changed(health: int)
signal wave_changed(wave: int)
signal game_over

func reset_run():
	current_coins = 0
	current_wave = 0
	current_health = 3 + permanent_upgrades["health"]
	current_run_upgrades = []
	emit_signal("coins_changed", current_coins)
	emit_signal("health_changed", current_health)
	emit_signal("wave_changed", current_wave)

func add_coins(amount: int):
	current_coins += amount
	total_coins += amount
	emit_signal("coins_changed", current_coins)

func take_damage():
	current_health -= 1
	emit_signal("health_changed", current_health)
	if current_health <= 0:
		emit_signal("game_over")

func next_wave():
	current_wave += 1
	if current_wave > best_wave:
		best_wave = current_wave
	emit_signal("wave_changed", current_wave)

func add_upgrade(upgrade_name: str):
	current_run_upgrades.append(upgrade_name)
