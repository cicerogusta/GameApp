extends EnemyImproved

func _ready():
	super._ready()
	speed = Constants.SPECTER_SPEED
	health = 1
	echo_reward = 1
	sprite_color = Constants.COLOR_CYAN
	max_health = health
	add_to_group("specter")

	var sprite = $Sprite2D
	sprite.texture = SpriteGenerator.generate_specter_sprite()
