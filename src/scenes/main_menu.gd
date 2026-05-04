extends Control

@onready var start_button = $VBoxContainer/StartButton
@onready var stats_label = $VBoxContainer/StatsLabel
@onready var quit_button = $VBoxContainer/QuitButton

var save_manager: SaveManager

func _ready():
	save_manager = SaveManager.new()
	add_child(save_manager)

	var save_data = save_manager.load_game()
	GameState.best_wave = save_data["best_wave"]
	GameState.total_coins = save_data["total_coins"]
	GameState.permanent_upgrades = save_data["permanent_upgrades"]

	_update_stats_display()

	start_button.pressed.connect(_on_start_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

func _update_stats_display():
	stats_label.text = "Best Wave: %d\nTotal Coins: %d" % [
		GameState.best_wave,
		GameState.total_coins
	]

func _on_start_pressed():
	get_tree().change_scene_to_file("res://src/scenes/game.tscn")

func _on_quit_pressed():
	get_tree().quit()
