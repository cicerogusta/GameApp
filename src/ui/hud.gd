extends CanvasLayer

class_name GameHUD

var wave_label: Label
var coins_label: Label
var health_label: Label
var echoes_label: Label

func _ready():
	_setup_ui()
	GameState.wave_changed.connect(_on_wave_changed)
	GameState.coins_changed.connect(_on_coins_changed)
	GameState.health_changed.connect(_on_health_changed)

func _setup_ui():
	wave_label = Label.new()
	wave_label.text = "Wave: 0"
	wave_label.add_theme_font_size_override("font_size", 24)
	wave_label.position = Vector2(10, 10)
	add_child(wave_label)

	coins_label = Label.new()
	coins_label.text = "Coins: 0"
	coins_label.add_theme_font_size_override("font_size", 20)
	coins_label.position = Vector2(10, 40)
	add_child(coins_label)

	health_label = Label.new()
	health_label.text = "Health: 3"
	health_label.add_theme_font_size_override("font_size", 20)
	health_label.position = Vector2(10, 70)
	add_child(health_label)

	echoes_label = Label.new()
	echoes_label.text = "Echoes: 0"
	echoes_label.add_theme_font_size_override("font_size", 20)
	echoes_label.position = Vector2(Constants.WINDOW_WIDTH - 200, 10)
	add_child(echoes_label)

func _on_wave_changed(wave: int):
	if wave_label:
		wave_label.text = "Wave: %d" % wave

func _on_coins_changed(coins: int):
	if coins_label:
		coins_label.text = "Coins: %d" % coins

func _on_health_changed(health: int):
	if health_label:
		health_label.text = "Health: %d" % health
