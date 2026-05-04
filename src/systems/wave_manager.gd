extends Node

class_name WaveManager

var enemy_scene: PackedScene
var current_wave: int = 0
var enemies_spawned: int = 0
var enemies_defeated: int = 0
var wave_active: bool = false
var spawn_timer: float = 0.0

signal wave_started(wave: int)
signal wave_completed(wave: int)
signal boss_approaching(wave: int)

func _ready():
	enemy_scene = load("res://src/scenes/enemy_specter.tscn")

func _process(delta):
	if wave_active and spawn_timer > 0:
		spawn_timer -= delta

func start_wave():
	current_wave += 1
	enemies_spawned = 0
	enemies_defeated = 0
	wave_active = true
	GameState.next_wave()
	emit_signal("wave_started", current_wave)
	_spawn_enemies()

func _spawn_enemies():
	var enemy_count = 3 + (current_wave - 1) * 2
	for i in range(enemy_count):
		spawn_timer = i * 0.3
		await get_tree().create_timer(spawn_timer).timeout
		_spawn_random_enemy()

func _spawn_random_enemy():
	var position = _get_random_spawn_position()
	var enemy = enemy_scene.instantiate()
	enemy.global_position = position
	get_parent().add_child(enemy)
	enemies_spawned += 1
	enemy.defeated.connect(_on_enemy_defeated)

func _get_random_spawn_position() -> Vector2:
	var x = randf_range(50, Constants.WINDOW_WIDTH - 50)
	var y = randf_range(50, Constants.WINDOW_HEIGHT - 50)
	return Vector2(x, y)

func _on_enemy_defeated():
	enemies_defeated += 1
	if enemies_defeated >= enemies_spawned and enemies_spawned > 0:
		wave_active = false
		emit_signal("wave_completed", current_wave)

func should_spawn_boss() -> bool:
	return current_wave % Constants.WAVE_BOSS_INTERVAL == 0
