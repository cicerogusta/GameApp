extends Control

@onready var wave_label = $VBoxContainer/WaveLabel
@onready var coins_label = $VBoxContainer/CoinsLabel
@onready var stats_label = $VBoxContainer/StatsLabel
@onready var retry_button = $VBoxContainer/RetryButton
@onready var menu_button = $VBoxContainer/MenuButton

func _ready():
	wave_label.text = "Wave Reached: %d" % GameState.current_wave
	coins_label.text = "Coins Earned: %d" % GameState.current_coins
	stats_label.text = "Best Wave: %d" % GameState.best_wave

	retry_button.pressed.connect(_on_retry_pressed)
	menu_button.pressed.connect(_on_menu_pressed)

func _on_retry_pressed():
	get_tree().reload_current_scene()

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://src/scenes/main_menu.tscn")
