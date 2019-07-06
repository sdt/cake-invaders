extends Enemy

# Declare member variables here. Examples:
# var a = 2
var damageTime = 0
const gameObjectType = "Enemy"
const HomingMissile = preload("res://HomingMissile.tscn")
const missileTime = 2
var timeUntilMissile = 1

var player

func _enter_tree():
	var behaviour = find_node("EnemyBehaviour*", true, false)
	behaviour.enemy = self


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("area_entered", self, "hit")
	player = get_node("/root/Game/Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):		
	if damageTime > 0:
		damageTime = damageTime - delta
	elif damageTime < 0:
		damageTime = 0
		modulate.g = 1
		modulate.b = 1
		
	timeUntilMissile = timeUntilMissile - delta
	if timeUntilMissile < 0:
		timeUntilMissile = timeUntilMissile + missileTime
		fire(player)

func hit(object):
	damageTime = 0.33
	modulate.g = 0.5
	modulate.b = 0.5
	
func fire(target):
	var missile = HomingMissile.instance();
	missile.position = position
	missile.position.y = missile.position.y + 40
	missile.target = target
	get_parent().add_child(missile)