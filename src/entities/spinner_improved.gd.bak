extends EnemyImproved

var rotation_speed: float = 5.0

func _ready():
	super._ready()
	speed = Constants.SPINNER_SPEED
	health = 1
	echo_reward = 1
	sprite_color = Constants.COLOR_CYAN
	max_health = health
	add_to_group("spinner")

	var sprite = $Sprite2D
	sprite.texture = SpriteGenerator.generate_spinner_sprite()

func _physics_process(delta):
	rotation += rotation_speed * delta
	super._physics_process(delta)
