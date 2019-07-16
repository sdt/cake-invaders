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
var behaviour
var firePoints = [ ]

func _enter_tree():
	behaviour = find_node("EnemyBehaviour*", true, false)
	behaviour.enemy = self
	
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/Game/Player")
	$Area2D.connect("area_entered", self, "hit")
	currentHealth = health
	for child in get_children():
		if child is FirePoint:
			firePoints.push_back(child)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateDamageState(delta)
	if !isDead():
		updateMissile(delta)

func fire(target):
	var offset = missileOffset
	var type = missileType
	var rotation = 0
	if firePoints.size() > 0:
		var firePoint = firePoints[ randi() % firePoints.size() ]
		offset = firePoint.position
		type = firePoint.missileType
		rotation = firePoint.rotation
		
	var missile = missileClass.get(type).instance()
	missile.position = position + offset
	missile.target = target
	missile.rotation = rotation
	get_parent().add_child(missile)
	
func makeMissile():
	pass

func hit(object):
	if isDead():
		return
	var thing = object.get_parent()
	if thing is Bullet:
		currentHealth = currentHealth - thing.damage
		if currentHealth < 0:
			currentHealth = 0
		healthBar.setValue(currentHealth, health)
		if isDead():
			die()
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
		
func isDead():
	return currentHealth == 0
		
func die():
	remove_child(behaviour)
	behaviour.queue_free()
	behaviour = EnemyBehaviourDeath.new()
	behaviour.enemy = self
	add_child(behaviour)
	get_tree().call_group("ProjectilesGroup", "die")