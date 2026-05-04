extends Node2D

class_name Echo

var lifetime: float = Constants.ECHO_LIFETIME
var float_height: float = Constants.ECHO_FLOAT_HEIGHT
var start_y: float
var bob_timer: float = 0.0

signal collected

func _ready():
	start_y = global_position.y
	add_to_group("echo")

func _process(delta):
	lifetime -= delta
	bob_timer += delta

	var bob_offset = sin(bob_timer * 3.0) * float_height
	global_position.y = start_y + bob_offset

	if lifetime <= 0:
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("player"):
		collect()

func collect():
	emit_signal("collected")
	queue_free()
