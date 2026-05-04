extends EnemyBase

func _ready():
	super._ready()
	speed = Constants.SPECTER_SPEED
	health = 1
	echo_reward = 1
	add_to_group("specter")
