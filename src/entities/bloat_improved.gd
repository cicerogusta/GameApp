extends EnemyImproved

func _ready():
	super._ready()
	speed = Constants.BLOAT_SPEED
	health = 3
	echo_reward = 2
	sprite_color = Constants.COLOR_HOT_PINK
	max_health = health
	add_to_group("bloat")

	var sprite = $Sprite2D
	sprite.texture = SpriteGenerator.generate_bloat_sprite()
