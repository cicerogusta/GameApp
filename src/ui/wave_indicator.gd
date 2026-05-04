extends CanvasLayer

class_name WaveIndicator

var label: Label
var tween: Tween

func _ready():
	label = Label.new()
	label.text = "WAVE 1"
	label.add_theme_font_size_override("font_size", 48)
	label.add_theme_color_override("font_color", Color(0, 0.85, 1, 1))
	label.position = Vector2(Constants.WINDOW_WIDTH / 2 - 100, 300)
	add_child(label)

func show_wave(wave: int):
	label.text = "WAVE %d" % wave
	label.position.y = 100

	if tween:
		tween.kill()

	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(label, "modulate:a", 1.0, 0.2)
	tween.tween_callback(func(): pass)
	await get_tree().create_timer(1.5).timeout
	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(label, "modulate:a", 0.0, 0.4)
