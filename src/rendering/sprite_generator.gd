extends Node


static func generate_player_sprite() -> Texture2D:
	print("Generating player sprite...")
	var image = Image.create(64, 64, false, Image.FORMAT_RGBA8)

	# Dark background
	for y in range(64):
		for x in range(64):
			image.set_pixel(x, y, Color(0.1, 0.1, 0.18, 1))

	# Draw eye (cyan circle)
	var eye_pos = Vector2(32, 20)
	var eye_radius = 8
	for y in range(64):
		for x in range(64):
			var dist = Vector2(x, y).distance_to(eye_pos)
			if dist < eye_radius:
				image.set_pixel(x, y, Color(0, 0.85, 1, 1))

	# Draw tentacles (3 purple curves)
	for t in range(0, 360, 120):
		var angle = deg_to_rad(t)
		for i in range(1, 15):
			var x = int(32 + cos(angle) * i)
			var y = int(32 + sin(angle) * i + 8)
			if 0 <= x < 64 and 0 <= y < 64:
				image.set_pixel(x, y, Color(0.157, 0, 1, 0.8))

	var texture = ImageTexture.create_from_image(image)
	return texture

static func generate_specter_sprite() -> Texture2D:
	var image = Image.create(48, 48, false, Image.FORMAT_RGBA8)

	for y in range(48):
		for x in range(48):
			image.set_pixel(x, y, Color(0.1, 0.1, 0.18, 0))

	# Cyan sphere
	var center = Vector2(24, 24)
	var radius = 10
	for y in range(48):
		for x in range(48):
			var dist = Vector2(x, y).distance_to(center)
			if dist < radius:
				var alpha = 1.0 - (dist / radius) * 0.3
				image.set_pixel(x, y, Color(0, 0.85, 1, alpha))

	# Glow effect
	for y in range(48):
		for x in range(48):
			var dist = Vector2(x, y).distance_to(center)
			if dist > radius and dist < radius + 3:
				var alpha = 0.3 * (1.0 - (dist - radius) / 3.0)
				image.set_pixel(x, y, Color(0, 0.85, 1, alpha))

	var texture = ImageTexture.create_from_image(image)
	return texture

static func generate_bloat_sprite() -> Texture2D:
	var image = Image.create(64, 64, false, Image.FORMAT_RGBA8)

	for y in range(64):
		for x in range(64):
			image.set_pixel(x, y, Color(0.1, 0.1, 0.18, 0))

	# Pink square with outline
	var rect = Rect2i(12, 12, 40, 40)
	for y in range(64):
		for x in range(64):
			if rect.has_point(Vector2i(x, y)):
				image.set_pixel(x, y, Color(1, 0, 0.4, 1))
			elif rect.grow(2).has_point(Vector2i(x, y)):
				image.set_pixel(x, y, Color(0.5, 0, 0.2, 0.6))

	# Central dark spot
	var center = Vector2(32, 32)
	for y in range(64):
		for x in range(64):
			var dist = Vector2(x, y).distance_to(center)
			if dist < 6:
				image.set_pixel(x, y, Color(0.2, 0.05, 0.1, 1))

	var texture = ImageTexture.create_from_image(image)
	return texture

static func generate_spinner_sprite() -> Texture2D:
	var image = Image.create(48, 48, false, Image.FORMAT_RGBA8)

	for y in range(48):
		for x in range(48):
			image.set_pixel(x, y, Color(0.1, 0.1, 0.18, 0))

	# Draw 6-pointed star
	var center = Vector2(24, 24)
	var radius = 12
	for i in range(6):
		var angle = deg_to_rad(i * 60)
		var start = center + Vector2(cos(angle), sin(angle)) * 3
		var end = center + Vector2(cos(angle), sin(angle)) * radius

		# Draw line from center to point
		for t in range(0, 100):
			var pos = start.lerp(end, t / 100.0)
			var ix = int(pos.x)
			var iy = int(pos.y)
			if 0 <= ix < 48 and 0 <= iy < 48:
				var color = Color(0, 0.85, 1, 1) if i % 2 == 0 else Color(0.157, 0, 1, 1)
				image.set_pixel(ix, iy, color)

	var texture = ImageTexture.create_from_image(image)
	return texture

static func generate_echo_sprite() -> Texture2D:
	var image = Image.create(32, 32, false, Image.FORMAT_RGBA8)

	for y in range(32):
		for x in range(32):
			image.set_pixel(x, y, Color(0.1, 0.1, 0.18, 0))

	# Spinning star
	var center = Vector2(16, 16)
	var radius = 8
	for i in range(4):
		var angle = deg_to_rad(i * 90)
		var start = center
		var end = center + Vector2(cos(angle), sin(angle)) * radius

		for t in range(0, 100):
			var pos = start.lerp(end, t / 100.0)
			var ix = int(pos.x)
			var iy = int(pos.y)
			if 0 <= ix < 32 and 0 <= iy < 32:
				image.set_pixel(ix, iy, Color(1, 1, 0, 1))

	# Center glow
	for y in range(32):
		for x in range(32):
			var dist = Vector2(x, y).distance_to(center)
			if dist < 3:
				image.set_pixel(x, y, Color(1, 1, 0, 1))

	var texture = ImageTexture.create_from_image(image)
	return texture

static func generate_boss_sprite() -> Texture2D:
	var image = Image.create(128, 128, false, Image.FORMAT_RGBA8)

	for y in range(128):
		for x in range(128):
			image.set_pixel(x, y, Color(0.1, 0.1, 0.18, 0))

	var center = Vector2(64, 64)

	# Large outer circle (purple)
	for y in range(128):
		for x in range(128):
			var dist = Vector2(x, y).distance_to(center)
			if dist < 50:
				var alpha = 0.6 * (1.0 - dist / 50.0)
				image.set_pixel(x, y, Color(0.157, 0, 1, alpha))

	# Inner circle (darker)
	for y in range(128):
		for x in range(128):
			var dist = Vector2(x, y).distance_to(center)
			if dist < 30:
				image.set_pixel(x, y, Color(0.1, 0.05, 0.15, 1))

	# Large eye (cyan)
	var eye_radius = 15
	for y in range(128):
		for x in range(128):
			var dist = Vector2(x, y).distance_to(center)
			if dist < eye_radius:
				image.set_pixel(x, y, Color(0, 0.85, 1, 1))

	# Eye iris
	for y in range(128):
		for x in range(128):
			var dist = Vector2(x, y).distance_to(center)
			if dist < 8:
				image.set_pixel(x, y, Color(0, 0, 0, 1))

	# Draw tentacles (8 points)
	for i in range(8):
		var angle = deg_to_rad(i * 45)
		for j in range(1, 30):
			var x = int(center.x + cos(angle) * j * 2)
			var y = int(center.y + sin(angle) * j * 2)
			if 0 <= x < 128 and 0 <= y < 128:
				var alpha = 0.7 * (1.0 - j / 30.0)
				image.set_pixel(x, y, Color(0.157, 0, 1, alpha))

	var texture = ImageTexture.create_from_image(image)
	return texture
