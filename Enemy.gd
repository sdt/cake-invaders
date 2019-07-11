class_name Enemy

extends Sprite

const gameObjectType = "Enemy"

const missileClass = {
	"HomingMissile": preload("res://HomingMissile.tscn"),
	"Bomb": preload("res://Bomb.tscn"),
}

export(int) var health = 10
export(float) var missileTime = 2
export(Vector2) var missileOffset = Vector2(0, 40)
export(String, "HomingMissile", "Bomb") var missileType = "HomingMissile"
var timeUntilMissile = rand_range(missileTime/4, missileTime)
var player
var damageTime = 0
var healthBar
var currentHealth

func _enter_tree():
	var behaviour = find_node("EnemyBehaviour*", true, false)
	behaviour.enemy = self
	
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/Game/Player")
	$Area2D.connect("area_entered", self, "hit")
	printt("ENEMY HEALTHBAR=", $HealthBar)
	currentHealth = health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateDamageState(delta)
	updateMissile(delta)

func fire(target):
	var missile = missileClass.get(missileType).instance()
	missile.position = position + missileOffset
	missile.target = target
	get_parent().add_child(missile)
	
func makeMissile():
	pass

func hit(object):
	var thing = object.get_parent()
	if thing is Bullet:
		currentHealth = currentHealth - thing.damage
		if currentHealth < 0:
			currentHealth = 0
		healthBar.setValue(currentHealth, health)
		printt("Health = ", currentHealth)
	printt(object)
	damageTime = 0.33
	modulate.g = 0.5
	modulate.b = 0.5
	
func updateMissile(delta):
	timeUntilMissile = timeUntilMissile - delta
	if timeUntilMissile < 0:
		timeUntilMissile = timeUntilMissile + missileTime
		fire(player)
	
func updateDamageState(delta):
	if damageTime > 0:
		damageTime = damageTime - delta
	elif damageTime < 0:
		damageTime = 0
		modulate = Color(1, 1, 1)
