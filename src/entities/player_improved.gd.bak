extends CharacterBody2D

class_name PlayerImproved

@export var speed: float = Constants.PLAYER_SPEED
@export var damage: int = Constants.PLAYER_DAMAGE

var attack_timer: float = 0.0
var health: int = 3
var direction: Vector2 = Vector2.ZERO
var is_alive: bool = true
var stored_echoes: int = 0
var active_boosts: Array = []

signal health_changed(health: int)
signal attack_performed(position: Vector2, direction: Vector2)
signal echo_collected(amount: int)
signal died
signal took_damage

func _ready():
	add_to_group("player")
	health = 3 + GameState.permanent_upgrades.get("health", 0)
	speed = Constants.PLAYER_SPEED * (1.0 + GameState.permanent_upgrades.get("speed", 0) * 0.15)
	damage = Constants.PLAYER_DAMAGE + GameState.permanent_upgrades.get("damage", 0) * 2

	_setup_sprite()

func _setup_sprite():
	if not has_node("Sprite2D"):
		var sprite = Sprite2D.new()
		add_child(sprite)

	var sprite = $Sprite2D
	sprite.texture = SpriteGenerator.generate_player_sprite()
	sprite.centered = true

func _physics_process(delta):
	if not is_alive:
		return

	_handle_input()
	_handle_movement(delta)
	_handle_attack(delta)
	_update_boosts(delta)
	move_and_slide()

func _handle_input():
	direction = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	direction = direction.normalized()

func _handle_movement(delta):
	var current_speed = speed
	for boost in active_boosts:
		if boost["type"] == "speed":
			current_speed *= boost["multiplier"]
	velocity = direction * current_speed

func _handle_attack(delta):
	attack_timer -= delta
	if Input.is_action_pressed("ui_accept") and attack_timer <= 0:
		_perform_attack()
		attack_timer = Constants.PLAYER_ATTACK_COOLDOWN

func _perform_attack():
	var mouse_pos = get_global_mouse_position()
	var attack_dir = (mouse_pos - global_position).normalized()
	emit_signal("attack_performed", global_position, attack_dir)

	# Visual feedback
	_play_attack_feedback()

func _play_attack_feedback():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	scale = Vector2(1.2, 1.2)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)

func take_damage():
	if is_alive:
		health -= 1
		emit_signal("health_changed", health)
		emit_signal("took_damage")

		# Hit flash effect
		_play_hit_feedback()

		if health <= 0:
			die()

func _play_hit_feedback():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)

	modulate = Color.RED
	tween.tween_property(self, "modulate", Color.WHITE, 0.15)

	# Screen shake
	var feedback = get_tree().root.get_node("Game/VisualFeedback")
	if feedback:
		feedback.screen_shake(0.3, 0.1)

func die():
	if is_alive:
		is_alive = false
		emit_signal("died")

		# Death animation
		_play_death_feedback()

func _play_death_feedback():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN)

	tween.tween_property(self, "modulate:a", 0.0, 0.5)
	tween.set_parallel(true)
	tween.tween_property(self, "scale", Vector2(0.5, 0.5), 0.5)

	# Particle burst
	var feedback = get_tree().root.get_node("Game/VisualFeedback")
	if feedback:
		feedback.particle_burst(global_position, Constants.COLOR_PURPLE, 20)
		feedback.screen_shake(1.0, 0.3)

func collect_echo(boost_type: String = ""):
	stored_echoes += 1
	if boost_type == "speed":
		active_boosts.append({
			"type": "speed",
			"multiplier": Constants.ECHO_BOOST_SPEED_MULTIPLIER,
			"duration": Constants.ECHO_BOOST_DURATION
		})
	elif boost_type == "damage":
		active_boosts.append({
			"type": "damage",
			"multiplier": Constants.ECHO_BOOST_DAMAGE_MULTIPLIER,
			"duration": Constants.ECHO_BOOST_DURATION
		})

func _update_boosts(delta):
	for boost in active_boosts:
		boost["duration"] -= delta
	active_boosts = active_boosts.filter(func(b): return b["duration"] > 0)

func get_damage() -> int:
	var dmg = damage
	for boost in active_boosts:
		if boost["type"] == "damage":
			dmg = int(dmg * boost["multiplier"])
	return dmg
