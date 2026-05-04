extends Node

class_name EchoSystem

var echo_scene: PackedScene
var active_echoes: Array = []

signal echo_spawned(position: Vector2)
signal echo_consumed(echo: EchoImproved)

func _ready():
	echo_scene = load("res://src/scenes/echo_improved.tscn")

func spawn_echo(position: Vector2):
	if echo_scene:
		var echo = echo_scene.instantiate()
		echo.global_position = position
		get_parent().add_child(echo)
		active_echoes.append(echo)
		echo.collected.connect(_on_echo_collected.bind(echo))
		emit_signal("echo_spawned", position)
		return echo
	return null

func _on_echo_collected(echo: EchoImproved):
	if echo in active_echoes:
		active_echoes.erase(echo)
		emit_signal("echo_consumed", echo)

func get_echo_count() -> int:
	return active_echoes.size()
