extends Control

class_name GameOverUI

@onready var title = $VBoxContainer/TitleLabel
@onready var wave_label = $VBoxContainer/StatsContainer/WaveLabel
@onready var coins_label = $VBoxContainer/StatsContainer/CoinsLabel
@onready var best_label = $VBoxContainer/StatsContainer/BestLabel
@onready var retry_button = $VBoxContainer/ButtonContainer/RetryButton
@onready var menu_button = $VBoxContainer/ButtonContainer/MenuButton

var save_manager: SaveManager

func _ready():
	save_manager = SaveManager.new()
	add_child(save_manager)

	_setup_display()
	_setup_animations()

	retry_button.pressed.connect(_on_retry_pressed)
	menu_button.pressed.connect(_on_menu_pressed)
	retry_button.mouse_entered.connect(_on_button_hover.bind(retry_button))
	menu_button.mouse_entered.connect(_on_button_hover.bind(menu_button))

func _setup_display():
	wave_label.text = "Wave Atingida: %d" % GameState.current_wave
	coins_label.text = "Moedas Ganhas: %d" % GameState.current_coins
	best_label.text = "Melhor Wave: %d" % GameState.best_wave

	title.text = "GAME OVER"
	if GameState.current_wave > GameState.best_wave:
		title.text = "NOVO RECORDE!"
		title.add_theme_color_override("font_color", Color(1, 0.84, 0, 1))

func _setup_animations():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	title.position.y = -200
	tween.tween_property(title, "position:y", title.position.y + 200, 0.8)

	var tween2 = create_tween()
	tween2.set_trans(Tween.TRANS_CUBIC)
	tween2.set_ease(Tween.EASE_OUT)
	tween2.set_delay(0.3)
	$VBoxContainer/StatsContainer.modulate.a = 0
	tween2.tween_property($VBoxContainer/StatsContainer, "modulate:a", 1.0, 0.5)

	var tween3 = create_tween()
	tween3.set_trans(Tween.TRANS_CUBIC)
	tween3.set_ease(Tween.EASE_OUT)
	tween3.set_delay(0.6)
	$VBoxContainer/ButtonContainer.modulate.a = 0
	tween3.tween_property($VBoxContainer/ButtonContainer, "modulate:a", 1.0, 0.5)

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

func _on_retry_pressed():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "modulate:a", 0.0, 0.4)
	await tween.finished
	get_tree().reload_current_scene()

func _on_menu_pressed():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "modulate:a", 0.0, 0.4)
	await tween.finished
	get_tree().change_scene_to_file("res://src/scenes/main_menu.tscn")
