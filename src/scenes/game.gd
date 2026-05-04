extends Node2D

var player: Player = null
var hud: GameHUD = null
var wave_manager: WaveManager = null
var echo_system: EchoSystem = null
var upgrade_manager: UpgradeManager = null
var save_manager: SaveManager = null

var game_active: bool = false
var wave_timer: float = 0.0

func _ready():
	player = $Player
	if player:
		player.attack_performed.connect(_on_player_attack)
		player.died.connect(_on_player_died)

	wave_manager = $WaveManager
	echo_system = $EchoSystem
	upgrade_manager = $UpgradeManager

	save_manager = SaveManager.new()
	add_child(save_manager)

	game_active = true
	GameState.reset_run()

	wave_timer = 2.0

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		_toggle_pause()

	if game_active:
		wave_timer -= delta
		if wave_timer <= 0 and not wave_manager.wave_active:
			wave_manager.start_wave()
			wave_timer = 30.0

func _on_player_attack(position: Vector2, direction: Vector2):
	if not game_active:
		return

	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		if enemy and not enemy.is_queued_for_deletion():
			var dist = position.distance_to(enemy.global_position)
			if dist < 150 and _is_in_attack_direction(position, direction, enemy):
				enemy.take_damage(player.get_damage())
				break

func _is_in_attack_direction(from: Vector2, direction: Vector2, target: Node2D) -> bool:
	var to_target = (target.global_position - from).normalized()
	return direction.dot(to_target) > 0.5

func _on_player_died():
	game_active = false
	save_manager.save_game()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://src/scenes/game_over.tscn")

func _toggle_pause():
	get_tree().paused = !get_tree().paused
