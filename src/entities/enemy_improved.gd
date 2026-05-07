extends CharacterBody2D

class_name EnemyImproved

@export var speed: float = 100.0
@export var health: int = 1
@export var damage: int = 1
@export var echo_reward: int = 1
@export var sprite_color: Color = Color.WHITE

var direction: Vector2 = Vector2.ZERO
var is_alive: bool = true
var player_ref: Player
var max_health: int

signal defeated
signal took_damage(health: int)

func _ready():
	add_to_group("enemy")
	player_ref = get_tree().get_first_child_in_group("player")
	max_health = health

	var area = $Area2D
	if area:
		area.area_entered.connect(_on_area_entered)

	_setup_sprite()

func _setup_sprite():
	if not has_node("Sprite2D"):
		var sprite = Sprite2D.new()
		add_child(sprite)
	var sprite = $Sprite2D
	sprite.centered = true
	sprite.modulate = sprite_color

func _physics_process(delta):
	if not is_alive or not player_ref:
		return

	_update_direction()
	velocity = direction * speed
	move_and_slide()

func _update_direction():
	if player_ref and is_alive:
		direction = (player_ref.global_position - global_position).normalized()

func take_damage(amount: int = 1):
	if is_alive:
		health -= amount
		emit_signal("took_damage", health)

		# Hit feedback
		_play_hit_feedback()

		if health <= 0:
			die()

func _play_hit_feedback():
	# Flash white
	var original_color = modulate
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)

	modulate = Color.WHITE
	tween.tween_property(self, "modulate", original_color, 0.1)

	# Screen shake on hit
	var feedback = get_tree().root.get_node("Game/VisualFeedback")
	if feedback:
		feedback.screen_shake(0.15, 0.05)

	# Play hit SFX
	var audio_mgr = get_tree().root.get_node("Game/AudioManager")
	if audio_mgr:
		audio_mgr.play_sfx("hit", -3.0)

func die():
	if is_alive:
		is_alive = false
		emit_signal("defeated")
		GameState.add_coins(echo_reward)

		# Death effect
		_play_death_animation()

		await get_tree().process_frame
		queue_free()

func _play_death_animation():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN)

	tween.tween_property(self, "modulate:a", 0.0, 0.3)
	tween.set_parallel(true)
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.3)

	# Particle burst
	var feedback = get_tree().root.get_node("Game/VisualFeedback")
	if feedback:
		feedback.particle_burst(global_position, sprite_color, 12)

func _on_area_entered(area):
	if area == player_ref:
		if is_alive and player_ref:
			player_ref.take_damage()
