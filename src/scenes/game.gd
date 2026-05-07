extends Node2D

var player: PlayerImproved = null
var hud: GameHUDImproved = null
var wave_manager: WaveManager = null
var echo_system: EchoSystem = null
var upgrade_manager: UpgradeManager = null
var pause_menu: PauseMenu = null
var wave_indicator: WaveIndicator = null
var upgrade_selection: UpgradeSelection = null
var save_manager: SaveManager = null
var audio_manager: AudioManagerPro = null

var game_active: bool = false
var wave_timer: float = 0.0

func _ready():
	player = $Player
	if player:
		player.attack_performed.connect(_on_player_attack)
		player.died.connect(_on_player_died)
		player.took_damage.connect(_on_player_took_damage)

	wave_manager = $WaveManager
	echo_system = $EchoSystem
	upgrade_manager = $UpgradeManager
	pause_menu = $PauseMenu
	wave_indicator = $WaveIndicator
	upgrade_selection = $UpgradeSelection
	hud = $HUD
	audio_manager = $AudioManager

	save_manager = SaveManager.new()
	add_child(save_manager)

	if pause_menu:
		pause_menu.pause_toggled.connect(_on_pause_toggled)

	if wave_manager and wave_indicator:
		wave_manager.wave_started.connect(wave_indicator.show_wave)

	if wave_manager and upgrade_manager and upgrade_selection:
		wave_manager.upgrade_time.connect(func():
			var upgrades = upgrade_manager.offer_upgrades()
			upgrade_selection.show_upgrades(upgrades)
		)
		upgrade_selection.upgrade_selected.connect(_on_upgrade_selected)

	if echo_system:
		echo_system.echo_spawned.connect(func(_pos):
			if audio_manager:
				audio_manager.play_sfx("echo_collect", 0.0)
		)
		echo_system.echo_consumed.connect(func(echo):
			GameState.add_coins(5)
		)

	if audio_manager:
		audio_manager.play_music("background", -5.0)

	game_active = true
	GameState.reset_run()

	wave_timer = 2.0

func _process(delta):
	if game_active and not get_tree().paused:
		wave_timer -= delta
		if wave_timer <= 0 and not wave_manager.wave_active:
			wave_manager.start_wave()
			wave_timer = 30.0

func _on_player_attack(position: Vector2, direction: Vector2):
	if not game_active or get_tree().paused:
		return

	if audio_manager:
		audio_manager.play_sfx("attack", 0.0)

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

func _on_pause_toggled(paused: bool):
	if paused:
		game_active = false
	else:
		game_active = true

func _on_player_took_damage():
	if audio_manager:
		audio_manager.play_sfx("hit", -3.0)

func _on_upgrade_selected(upgrade: Dictionary):
	upgrade_manager.apply_upgrade(upgrade)

func _on_player_died():
	if audio_manager:
		audio_manager.play_sfx("death", 0.0)
	game_active = false
	save_manager.save_game()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://src/scenes/game_over.tscn")
