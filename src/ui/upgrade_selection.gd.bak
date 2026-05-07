extends CanvasLayer

class_name UpgradeSelection

@onready var panel = $PanelContainer
@onready var title = $PanelContainer/VBoxContainer/TitleLabel
@onready var container = $PanelContainer/VBoxContainer/UpgradesContainer

var upgrade_buttons: Array = []
var selected_upgrade: Dictionary = {}

signal upgrade_selected(upgrade: Dictionary)

func _ready():
	modulate.a = 0
	panel.visible = false
	container.columns = 3

func show_upgrades(upgrades: Array):
	panel.visible = true
	selected_upgrade = {}
	upgrade_buttons.clear()

	for child in container.get_children():
		child.queue_free()

	for upgrade in upgrades:
		var button = _create_upgrade_button(upgrade)
		container.add_child(button)
		upgrade_buttons.append(button)

	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate:a", 1.0, 0.4)

	get_tree().paused = true

func _create_upgrade_button(upgrade: Dictionary) -> Button:
	var button = Button.new()
	button.text = "%s\n%s" % [upgrade["name"], upgrade["description"]]
	button.custom_minimum_size = Vector2(250, 100)
	button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	button.size_flags_vertical = Control.SIZE_SHRINK_CENTER

	button.add_theme_font_size_override("font_size", 16)
	button.pressed.connect(_on_upgrade_selected.bind(upgrade))
	button.mouse_entered.connect(_on_upgrade_hover.bind(button))

	return button

func _on_upgrade_selected(upgrade: Dictionary):
	get_tree().paused = false
	selected_upgrade = upgrade
	emit_signal("upgrade_selected", upgrade)

	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "modulate:a", 0.0, 0.3)
	await tween.finished
	panel.visible = false

func _on_upgrade_hover(button: Button):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(button, "scale", Vector2(1.05, 1.05), 0.2)

	button.mouse_exited.connect(func():
		var tween2 = create_tween()
		tween2.set_trans(Tween.TRANS_CUBIC)
		tween2.set_ease(Tween.EASE_OUT)
		tween2.tween_property(button, "scale", Vector2(1.0, 1.0), 0.2)
	)
