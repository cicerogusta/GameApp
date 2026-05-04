extends Node

class_name SoundGenerator

static func generate_sine_tone(frequency: float = 440.0, duration: float = 0.1, sample_rate: int = 44100) -> AudioStreamWAV:
	var wav = AudioStreamWAV.new()
	wav.sample_rate = sample_rate

	var samples = []
	var num_samples = int(duration * sample_rate)

	for i in range(num_samples):
		var t = float(i) / sample_rate
		var sample = sin(TAU * frequency * t) * 0.3
		samples.append(sample)

	var packed_data = PackedByteArray()
	for sample in samples:
		var int_sample = int(sample * 32767)
		packed_data.append_array(int_sample.to_bytes(2, Endian.LITTLE))

	wav.data = packed_data
	return wav

static func generate_attack_sfx() -> AudioStreamWAV:
	# Sharp zap sound
	var wav = AudioStreamWAV.new()
	wav.sample_rate = 44100

	var samples = []
	var duration = 0.1
	var num_samples = int(duration * 44100)

	for i in range(num_samples):
		var t = float(i) / 44100.0
		var progress = t / duration
		var frequency = 800 - (progress * 600)  # 800Hz down to 200Hz
		var envelope = 1.0 - progress
		var sample = sin(TAU * frequency * t) * envelope * 0.4
		samples.append(sample)

	var packed_data = PackedByteArray()
	for sample in samples:
		var int_sample = int(sample * 32767)
		packed_data.append_array(int_sample.to_bytes(2, Endian.LITTLE))

	wav.data = packed_data
	return wav

static func generate_hit_sfx() -> AudioStreamWAV:
	# Impact sound
	var wav = AudioStreamWAV.new()
	wav.sample_rate = 44100

	var samples = []
	var duration = 0.15
	var num_samples = int(duration * 44100)

	for i in range(num_samples):
		var t = float(i) / 44100.0
		var progress = t / duration
		var frequency = 200
		var envelope = 1.0 - (progress * 2.0)
		envelope = max(0, envelope)
		var sample = sin(TAU * frequency * t) * envelope * 0.4
		samples.append(sample)

	var packed_data = PackedByteArray()
	for sample in samples:
		var int_sample = int(sample * 32767)
		packed_data.append_array(int_sample.to_bytes(2, Endian.LITTLE))

	wav.data = packed_data
	return wav

static func generate_pickup_sfx() -> AudioStreamWAV:
	# Sparkle/chime sound
	var wav = AudioStreamWAV.new()
	wav.sample_rate = 44100

	var samples = []
	var duration = 0.2
	var num_samples = int(duration * 44100)

	for i in range(num_samples):
		var t = float(i) / 44100.0
		var progress = t / duration
		var frequency = 800 + (progress * 400)  # 800Hz up to 1200Hz
		var envelope = 1.0 - progress
		var sample = sin(TAU * frequency * t) * envelope * 0.3
		samples.append(sample)

	var packed_data = PackedByteArray()
	for sample in samples:
		var int_sample = int(sample * 32767)
		packed_data.append_array(int_sample.to_bytes(2, Endian.LITTLE))

	wav.data = packed_data
	return wav

static func generate_levelup_sfx() -> AudioStreamWAV:
	# 3-note ascending chime
	var wav = AudioStreamWAV.new()
	wav.sample_rate = 44100

	var samples = []
	var total_duration = 0.6
	var num_samples = int(total_duration * 44100)

	# C4, E4, G4 (do, mi, sol)
	var frequencies = [262.0, 330.0, 392.0]

	for i in range(num_samples):
		var t = float(i) / 44100.0
		var note_index = int((t / total_duration) * 3)
		note_index = min(note_index, 2)

		var note_t = fmod(t, total_duration / 3.0)
		var envelope = 1.0 - (note_t / (total_duration / 3.0))
		envelope = max(0, envelope)

		var frequency = frequencies[note_index]
		var sample = sin(TAU * frequency * t) * envelope * 0.3
		samples.append(sample)

	var packed_data = PackedByteArray()
	for sample in samples:
		var int_sample = int(sample * 32767)
		packed_data.append_array(int_sample.to_bytes(2, Endian.LITTLE))

	wav.data = packed_data
	return wav
