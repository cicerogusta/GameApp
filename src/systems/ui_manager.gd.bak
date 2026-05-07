extends Node

class_name UIManager

var upgrade_selection: UpgradeSelection
var pause_menu: PauseMenu

signal upgrade_chosen(upgrade: Dictionary)

func _ready():
	upgrade_selection = get_tree().root.get_node("Game/UpgradeSelection")
	pause_menu = get_tree().root.get_node("Game/PauseMenu")

	if upgrade_selection:
		upgrade_selection.upgrade_selected.connect(_on_upgrade_selected)

func show_upgrade_menu(upgrades: Array):
	if upgrade_selection:
		upgrade_selection.show_upgrades(upgrades)

func _on_upgrade_selected(upgrade: Dictionary):
	emit_signal("upgrade_chosen", upgrade)
