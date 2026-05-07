extends Node2D

class_name ParallaxManager

var camera: Camera2D
var parallax_layers: Array = []

func _ready():
	camera = get_tree().get_first_child_in_group("camera") or get_viewport().get_camera_2d()
	_create_parallax_layers()

func _process(delta):
	if camera:
		_update_parallax_positions()

func _create_parallax_layers():
	# Far background (moves slowest)
	var far_layer = _create_layer(0.2, Color(0.05, 0.05, 0.1, 1))
	parallax_layers.append({"node": far_layer, "speed": 0.2})

	# Mid background (moves medium)
	var mid_layer = _create_layer(0.5, Color(0.08, 0.08, 0.12, 1))
	parallax_layers.append({"node": mid_layer, "speed": 0.5})

	# Near background (moves fast)
	var near_layer = _create_layer(0.8, Color(0.1, 0.1, 0.15, 1))
	parallax_layers.append({"node": near_layer, "speed": 0.8})

func _create_layer(speed: float, color: Color) -> Node2D:
	var layer = Node2D.new()
	layer.name = "ParallaxLayer_%s" % speed
	add_child(layer)

	# Create tiles for the layer
	var tile_size = 256
	var screen_width = Constants.WINDOW_WIDTH
	var screen_height = Constants.WINDOW_HEIGHT

	for y in range(-2, int(screen_height / tile_size) + 3):
		for x in range(-2, int(screen_width / tile_size) + 3):
			var tile = ColorRect.new()
			tile.size = Vector2(tile_size, tile_size)
			tile.position = Vector2(x * tile_size, y * tile_size)
			tile.color = color
			layer.add_child(tile)

			# Add grid lines
			var line_color = Color(color.r * 1.2, color.g * 1.2, color.b * 1.2, 0.3)
			var h_line = ColorRect.new()
			h_line.size = Vector2(tile_size, 1)
			h_line.position = Vector2(0, tile_size - 1)
			h_line.color = line_color
			tile.add_child(h_line)

			var v_line = ColorRect.new()
			v_line.size = Vector2(1, tile_size)
			v_line.position = Vector2(tile_size - 1, 0)
			v_line.color = line_color
			tile.add_child(v_line)

	return layer

func _update_parallax_positions():
	if not camera:
		return

	for layer_info in parallax_layers:
		var layer = layer_info["node"]
		var speed = layer_info["speed"]
		var target_x = -camera.global_position.x * speed
		var target_y = -camera.global_position.y * speed

		layer.position = Vector2(target_x, target_y)
