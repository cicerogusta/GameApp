extends Node

class_name AudioManagerPro

# Audio players
var music_player: AudioStreamPlayer
var sfx_players: Dictionary = {}
var master_volume: float = 0.8

# Loaded audio streams
var loaded_music: Dictionary = {}
var loaded_sfx: Dictionary = {}

signal volume_changed(new_volume: float)
signal music_started(track_name: String)
signal sfx_played(sfx_name: String)

func _ready():
	_create_audio_buses()
	_create_players()
	_load_all_audio()

func _create_audio_buses():
	# Create Master bus
	if AudioServer.get_bus_index("Master") == -1:
		AudioServer.add_bus(AudioServer.bus_count)
		AudioServer.get_bus(AudioServer.bus_count - 1).name = "Master"

	# Create Music bus
	if AudioServer.get_bus_index("Music") == -1:
		AudioServer.add_bus(AudioServer.bus_count)
		AudioServer.get_bus(AudioServer.bus_count - 1).name = "Music"

	# Create SFX bus
	if AudioServer.get_bus_index("SFX") == -1:
		AudioServer.add_bus(AudioServer.bus_count)
		AudioServer.get_bus(AudioServer.bus_count - 1).name = "SFX"

func _create_players():
	# Music player
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Music"
	add_child(music_player)

	# SFX player pool
	var sfx_names = [
		"attack",
		"hit",
		"echo_collect",
		"levelup",
		"boss_appear",
		"death"
	]

	for sfx_name in sfx_names:
		var player = AudioStreamPlayer.new()
		player.bus = "SFX"
		add_child(player)
		sfx_players[sfx_name] = player

func _load_all_audio():
	# Try to load music
	var music_path = "res://assets/music/bg_music_loop.ogg"
	if ResourceLoader.exists(music_path):
		loaded_music["background"] = load(music_path)
		print("✅ Loaded background music")
	else:
		print("⚠️ Background music not found: " + music_path)

	# Try to load SFX
	var sfx_dir = "res://assets/sounds/"
	var sfx_files = {
		"attack": "attack_sfx.wav",
		"hit": "hit_sfx.wav",
		"echo_collect": "echo_collect_sfx.wav",
		"levelup": "levelup_sfx.wav",
		"boss_appear": "boss_appear_sfx.wav",
		"death": "death_sfx.wav"
	}

	for sfx_name in sfx_files.keys():
		var full_path = sfx_dir + sfx_files[sfx_name]
		if ResourceLoader.exists(full_path):
			loaded_sfx[sfx_name] = load(full_path)
			print("✅ Loaded SFX: " + sfx_name)
		else:
			print("⚠️ SFX not found: " + full_path)

func play_music(track_name: String = "background", volume_db: float = -5.0):
	if track_name not in loaded_music:
		print("❌ Music track not found: " + track_name)
		return

	# Fade out current music
	if music_player.playing:
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(music_player, "volume_db", -80.0, 0.5)
		await tween.finished

	# Load and play new music
	music_player.stream = loaded_music[track_name]
	music_player.volume_db = volume_db
	music_player.play()

	# Fade in
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(music_player, "volume_db", volume_db, 0.5)

	emit_signal("music_started", track_name)

func stop_music(fade_time: float = 0.5):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(music_player, "volume_db", -80.0, fade_time)
	await tween.finished
	music_player.stop()

func play_sfx(sfx_name: String, volume_db: float = 0.0):
	# Try loaded first
	if sfx_name in loaded_sfx:
		var player = sfx_players[sfx_name]
		player.stream = loaded_sfx[sfx_name]
		player.volume_db = volume_db
		player.play()
		emit_signal("sfx_played", sfx_name)
		return

	# Fallback to procedural
	if sfx_name == "attack":
		var sound = SoundGenerator.generate_attack_sfx()
		sfx_players[sfx_name].stream = sound
		sfx_players[sfx_name].play()
	elif sfx_name == "hit":
		var sound = SoundGenerator.generate_hit_sfx()
		sfx_players[sfx_name].stream = sound
		sfx_players[sfx_name].play()
	elif sfx_name == "echo_collect":
		var sound = SoundGenerator.generate_pickup_sfx()
		sfx_players[sfx_name].stream = sound
		sfx_players[sfx_name].play()
	elif sfx_name == "levelup":
		var sound = SoundGenerator.generate_levelup_sfx()
		sfx_players[sfx_name].stream = sound
		sfx_players[sfx_name].play()

	emit_signal("sfx_played", sfx_name)

func set_master_volume(volume: float):
	master_volume = clamp(volume, 0.0, 1.0)
	var db = linear2db(master_volume)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), master_volume < 0.01)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), db)
	emit_signal("volume_changed", master_volume)

func set_music_volume(volume: float):
	var db = linear2db(clamp(volume, 0.0, 1.0))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), db)

func set_sfx_volume(volume: float):
	var db = linear2db(clamp(volume, 0.0, 1.0))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), db)

func get_loaded_sfx_list() -> Array:
	return loaded_sfx.keys()

func get_loaded_music_list() -> Array:
	return loaded_music.keys()

func print_audio_status():
	print("\n=== AUDIO STATUS ===")
	print("🎵 Music Tracks: " + str(loaded_music.keys()))
	print("🔊 SFX Loaded: " + str(loaded_sfx.keys()))
	print("🎚️ Master Volume: " + str(master_volume))
	print("====================\n")
