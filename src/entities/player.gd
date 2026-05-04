extends CharacterBody2D

class_name Player

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

func _ready():
	add_to_group("player")
	health = 3 + GameState.permanent_upgrades.get("health", 0)
	speed = Constants.PLAYER_SPEED * (1.0 + GameState.permanent_upgrades.get("speed", 0) * 0.15)
	damage = Constants.PLAYER_DAMAGE + GameState.permanent_upgrades.get("damage", 0) * 2

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

func take_damage():
	if is_alive:
		health -= 1
		emit_signal("health_changed", health)
		if health <= 0:
			die()

func die():
	is_alive = false
	emit_signal("died")

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
