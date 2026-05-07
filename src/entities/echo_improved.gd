extends Node2D

class_name EchoImproved

var lifetime: float = Constants.ECHO_LIFETIME
var float_height: float = Constants.ECHO_FLOAT_HEIGHT
var start_y: float
var bob_timer: float = 0.0
var base_scale: float = 1.0

signal collected

func _ready():
	start_y = global_position.y
	add_to_group("echo")

	_setup_sprite()
	_play_spawn_animation()

func _setup_sprite():
	if not has_node("Sprite2D"):
		var sprite = Sprite2D.new()
		add_child(sprite)

	var sprite = $Sprite2D
	sprite.texture = SpriteGenerator.generate_echo_sprite()
	sprite.centered = true
	sprite.modulate = Constants.COLOR_GOLD

func _process(delta):
	lifetime -= delta
	bob_timer += delta

	var bob_offset = sin(bob_timer * 3.0) * float_height
	global_position.y = start_y + bob_offset

	# Pulsing glow effect
	var pulse = 0.5 + sin(bob_timer * 4.0) * 0.3
	var sprite = $Sprite2D
	if sprite:
		sprite.modulate.a = pulse + 0.5

	if lifetime <= 0:
		_play_despawn_animation()

func _play_spawn_animation():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)

	scale = Vector2(0, 0)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.2)

func _play_despawn_animation():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN)

	tween.tween_property(self, "scale", Vector2(0, 0), 0.2)
	await tween.finished
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("player"):
		collect()

func collect():
	collected.emit()

	# Collection feedback
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN)

	var player = get_tree().get_first_child_in_group("player")
	if player:
		tween.tween_property(self, "global_position", player.global_position, 0.2)
		tween.set_parallel(true)
		tween.tween_property(self, "scale", Vector2(0, 0), 0.2)
		await tween.finished

	queue_free()
