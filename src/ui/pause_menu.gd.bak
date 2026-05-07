extends CanvasLayer

class_name PauseMenu

@onready var panel = $PanelContainer
@onready var resume_button = $PanelContainer/VBoxContainer/ResumeButton
@onready var settings_button = $PanelContainer/VBoxContainer/SettingsButton
@onready var menu_button = $PanelContainer/VBoxContainer/MenuButton

var is_paused: bool = false

signal pause_toggled(paused: bool)

func _ready():
	modulate.a = 0
	panel.visible = false

	resume_button.pressed.connect(_on_resume_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	menu_button.pressed.connect(_on_menu_pressed)

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		toggle_pause()

func toggle_pause():
	is_paused = !is_paused
	get_tree().paused = is_paused

	if is_paused:
		_show_pause_menu()
	else:
		_hide_pause_menu()

	emit_signal("pause_toggled", is_paused)

func _show_pause_menu():
	panel.visible = true
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate:a", 1.0, 0.3)

func _hide_pause_menu():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate:a", 0.0, 0.3)
	await tween.finished
	panel.visible = false

func _on_resume_pressed():
	toggle_pause()

func _on_settings_pressed():
	# Placeholder for settings
	pass

func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://src/scenes/main_menu.tscn")
