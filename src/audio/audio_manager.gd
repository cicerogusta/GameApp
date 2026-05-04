extends Node

class_name AudioManager

var sfx_players: Dictionary = {}
var music_player: AudioStreamPlayer
var master_volume: float = 0.8
var sfx_volume: float = 0.7
var music_volume: float = 0.6

signal volume_changed(new_volume: float)

func _ready():
	# Create audio stream players
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Master"
	add_child(music_player)

	# Create SFX player pool
	for sfx_name in ["attack", "hit", "echo_collect", "levelup", "boss_appear", "death"]:
		var player = AudioStreamPlayer.new()
		player.bus = "Master"
		add_child(player)
		sfx_players[sfx_name] = player

	_setup_buses()

func _setup_buses():
	# Create audio buses if they don't exist
	var master_bus = AudioServer.get_bus_index("Master")
	if master_bus == -1:
		AudioServer.add_bus(AudioServer.bus_count)
		var new_bus = AudioServer.get_bus(AudioServer.bus_count - 1)
		new_bus.name = "Master"

func play_sfx(sfx_name: String, volume_db: float = 0.0):
	if sfx_name not in sfx_players:
		return

	var player = sfx_players[sfx_name]
	player.volume_db = volume_db
	player.play()

func play_music(audio_stream: AudioStream, volume_db: float = -5.0):
	if music_player.playing:
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(music_player, "volume_db", -80.0, 0.5)
		await tween.finished

	music_player.stream = audio_stream
	music_player.volume_db = volume_db
	music_player.play()

	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(music_player, "volume_db", volume_db, 0.5)

func stop_music(fade_time: float = 0.5):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(music_player, "volume_db", -80.0, fade_time)
	await tween.finished
	music_player.stop()

func set_master_volume(volume: float):
	master_volume = clamp(volume, 0.0, 1.0)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), master_volume < 0.01)
	emit_signal("volume_changed", master_volume)

func set_sfx_volume(volume: float):
	sfx_volume = clamp(volume, 0.0, 1.0)

func set_music_volume(volume: float):
	music_volume = clamp(volume, 0.0, 1.0)

func create_test_audio() -> AudioStream:
	# Generate a simple sine wave tone
	var audio = AudioStreamGenerator.new()
	audio.sample_rate = 44100
	audio.max_polyphony = 1

	return audio

func get_sfx_available() -> Array:
	return sfx_players.keys()
