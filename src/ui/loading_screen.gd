extends CanvasLayer

class_name LoadingScreen

@onready var progress_bar: ProgressBar = ProgressBar.new()
@onready var label: Label = Label.new()

func _ready():
	self.modulate.a = 0

func show_loading():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate:a", 1.0, 0.3)

func hide_loading():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate:a", 0.0, 0.3)
	await tween.finished
