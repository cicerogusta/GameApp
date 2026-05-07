extends CharacterBody2D

class_name EnemyBase

@export var speed: float = 100.0
@export var health: int = 1
@export var damage: int = 1
@export var echo_reward: int = 1

var direction: Vector2 = Vector2.ZERO
var is_alive: bool = true
var player_ref: Player = null

signal defeated
signal took_damage(health: int)

func _ready():
	add_to_group("enemy")
	player_ref = get_tree().get_first_child_in_group("player")
	var area = $Area2D
	if area:
		area.area_entered.connect(_on_area_entered)

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
		took_damage.emit(health)
		if health <= 0:
			die()

func die():
	if is_alive:
		is_alive = false
		defeated.emit()
		GameState.add_coins(echo_reward)
		await get_tree().process_frame
		queue_free()

func _on_area_entered(area):
	if area == player_ref:
		if is_alive and player_ref:
			player_ref.take_damage()
