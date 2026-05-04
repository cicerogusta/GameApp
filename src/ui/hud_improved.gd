extends CanvasLayer

class_name GameHUDImproved

var wave_label: Label
var coins_label: Label
var health_label: Label
var wave_icon: Label
var coins_icon: Label
var health_icon: Label

var player_ref: Player

func _ready():
	player_ref = get_tree().get_first_child_in_group("player")
	_setup_ui()
	GameState.wave_changed.connect(_on_wave_changed)
	GameState.coins_changed.connect(_on_coins_changed)
	GameState.health_changed.connect(_on_health_changed)

func _setup_ui():
	# Wave Display
	wave_icon = Label.new()
	wave_icon.text = "〰"
	wave_icon.add_theme_font_size_override("font_size", 32)
	wave_icon.add_theme_color_override("font_color", Color(0, 0.85, 1, 1))
	wave_icon.position = Vector2(20, 15)
	add_child(wave_icon)

	wave_label = Label.new()
	wave_label.text = "Wave: 0"
	wave_label.add_theme_font_size_override("font_size", 20)
	wave_label.add_theme_color_override("font_color", Color(0, 0.85, 1, 0.9))
	wave_label.position = Vector2(65, 20)
	add_child(wave_label)

	# Coins Display
	coins_icon = Label.new()
	coins_icon.text = "◆"
	coins_icon.add_theme_font_size_override("font_size", 28)
	coins_icon.add_theme_color_override("font_color", Color(1, 1, 0, 1))
	coins_icon.position = Vector2(20, 55)
	add_child(coins_icon)

	coins_label = Label.new()
	coins_label.text = "Coins: 0"
	coins_label.add_theme_font_size_override("font_size", 18)
	coins_label.add_theme_color_override("font_color", Color(1, 1, 0, 0.9))
	coins_label.position = Vector2(65, 60)
	add_child(coins_label)

	# Health Display
	health_icon = Label.new()
	health_icon.text = "❤"
	health_icon.add_theme_font_size_override("font_size", 28)
	health_icon.add_theme_color_override("font_color", Color(1, 0, 0.4, 1))
	health_icon.position = Vector2(20, 95)
	add_child(health_icon)

	health_label = Label.new()
	health_label.text = "Health: 3"
	health_label.add_theme_font_size_override("font_size", 18)
	health_label.add_theme_color_override("font_color", Color(1, 0, 0.4, 0.9))
	health_label.position = Vector2(65, 100)
	add_child(health_label)

	# Pause Hint
	var pause_hint = Label.new()
	pause_hint.text = "ESC para pausar"
	pause_hint.add_theme_font_size_override("font_size", 14)
	pause_hint.add_theme_color_override("font_color", Color(0.5, 0.5, 0.5, 0.6))
	pause_hint.position = Vector2(Constants.WINDOW_WIDTH - 200, Constants.WINDOW_HEIGHT - 30)
	add_child(pause_hint)

func _on_wave_changed(wave: int):
	if wave_label:
		wave_label.text = "Wave: %d" % wave
		_pulse_label(wave_label)

func _on_coins_changed(coins: int):
	if coins_label:
		coins_label.text = "Coins: %d" % coins
		_pulse_label(coins_icon, 0.3)

func _on_health_changed(health: int):
	if health_label:
		health_label.text = "Health: %d" % health
		_pulse_label(health_label, 0.2)

func _pulse_label(label: Label, duration: float = 0.2):
	var original_color = label.modulate
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)

	tween.tween_property(label, "scale", Vector2(1.2, 1.2), duration / 2.0)
	tween.tween_property(label, "scale", Vector2(1.0, 1.0), duration / 2.0)
