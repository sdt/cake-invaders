class_name Enemy

extends Sprite

export(int) var health = 10
export(float) var missileTime = 2
export(Vector2) var missileOffset = Vector2(0, 40)
var timeUntilMissile = rand_range(0, missileTime)
var player

func _enter_tree():
	var behaviour = find_node("EnemyBehaviour*", true, false)
	behaviour.enemy = self
	
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/Game/Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeUntilMissile = timeUntilMissile - delta
	if timeUntilMissile < 0:
		timeUntilMissile = timeUntilMissile + missileTime
		fire(player)
#
func fire(target):
	var missile = makeMissile()
	missile.position = position + missileOffset
	missile.target = target
	get_parent().add_child(missile)
	
func makeMissile():
	pass
