extends EnemyBase

func _ready():
	super._ready()
	speed = Constants.BLOAT_SPEED
	health = 3
	echo_reward = 2
	add_to_group("bloat")
