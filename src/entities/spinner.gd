extends EnemyBase

var rotation_speed: float = 5.0

func _ready():
	super._ready()
	speed = Constants.SPINNER_SPEED
	health = 1
	echo_reward = 1
	add_to_group("spinner")

func _physics_process(delta):
	rotation += rotation_speed * delta
	super._physics_process(delta)
