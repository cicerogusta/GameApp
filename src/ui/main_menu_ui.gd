extends Control

class_name MainMenuUI

@onready var title = $PanelContainer/VBoxContainer/TitleLabel
@onready var stats = $PanelContainer/VBoxContainer/StatsLabel
@onready var start_button = $PanelContainer/VBoxContainer/ButtonContainer/StartButton
@onready var quit_button = $PanelContainer/VBoxContainer/ButtonContainer/QuitButton
@onready var version_label = $VersionLabel
@onready var glow_timer = 0.0

var save_manager: SaveManager

func _ready():
	save_manager = SaveManager.new()
	add_child(save_manager)

	var save_data = save_manager.load_game()
	GameState.best_wave = save_data["best_wave"]
	GameState.total_coins = save_data["total_coins"]
	GameState.permanent_upgrades = save_data["permanent_upgrades"]

	_update_stats_display()
	_setup_animations()

	start_button.pressed.connect(_on_start_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	start_button.mouse_entered.connect(_on_button_hover.bind(start_button))
	quit_button.mouse_entered.connect(_on_button_hover.bind(quit_button))

func _process(delta):
	glow_timer += delta
	_update_title_glow()

func _update_title_glow():
	var glow_intensity = 0.5 + sin(glow_timer * 2.0) * 0.3
	title.add_theme_color_override("font_color", Color(0, 0.85, 1, glow_intensity + 0.4))

func _update_stats_display():
	var best_wave = GameState.best_wave
	var total_coins = GameState.total_coins

	stats.text = "Melhor Wave: %d | Moedas Totais: %d" % [best_wave, total_coins]

	if best_wave > 0:
		var permanent_upgrades_count = GameState.permanent_upgrades.values().reduce(func(a, b): return a + b, 0)
		stats.text += "\nUpgrades Permanentes: %d" % permanent_upgrades_count

func _setup_animations():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	title.position.y = -100
	tween.tween_property(title, "position:y", title.position.y + 100, 0.8)

	var tween2 = create_tween()
	tween2.set_trans(Tween.TRANS_CUBIC)
	tween2.set_ease(Tween.EASE_OUT)
	stats.modulate.a = 0
	tween2.tween_property(stats, "modulate:a", 1.0, 0.6)

func _on_button_hover(button: Button):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(button, "scale", Vector2(1.1, 1.1), 0.2)

	button.mouse_exited.connect(func():
		var tween2 = create_tween()
		tween2.set_trans(Tween.TRANS_CUBIC)
		tween2.set_ease(Tween.EASE_OUT)
		tween2.tween_property(button, "scale", Vector2(1.0, 1.0), 0.2)
	)

func _on_start_pressed():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "modulate:a", 0.0, 0.4)
	await tween.finished
	get_tree().change_scene_to_file("res://src/scenes/game.tscn")

func _on_quit_pressed():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "modulate:a", 0.0, 0.4)
	await tween.finished
	get_tree().quit()
