class_name Player

extends Sprite

# Declare member variables here. Examples:
var speed = 0
const maxSpeed = 10.0
const accel = 1.75
var fireButtonDown = false
const Bullet = preload("res://Bullet.tscn")
const gameObjectType = "Player"
var healthBar
var maxHealth = 10 # 100
var health = maxHealth
var pausedMode = false
const edgeOffset = 40
const leftEdge = 0 - edgeOffset
const rightEdge = 1920 + edgeOffset
const Explosion = preload("res://Explosion.tscn")

export(int, 1, 25) var explosions = 10
export(float, 0.1, 0.5) var explosionTime = 0.25
export(float, 5.0, 75.0) var explosionRadius = 15.0
onready var explosionTimeRemaining = 0
onready var explosionsRemaining = explosions
var dead = false

var deathSequenceTimer
var normalScale

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("area_entered", self, "hit")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health > 0:
		processAlive(delta)
	else:
		processDead(delta)
	
func processAlive(delta):
	var fireButtonPrev = fireButtonDown
	fireButtonDown = Input.is_key_pressed(KEY_SPACE)
	if fireButtonDown and not fireButtonPrev:
		fire()
	if Input.is_key_pressed(KEY_LEFT):
		if speed > 0:
			speed = -accel
		elif -speed <= maxSpeed:
			speed = speed - accel
	elif Input.is_key_pressed(KEY_RIGHT):
		if speed < 0:
			speed = accel
		elif speed <= maxSpeed:
			speed = speed + accel
	elif speed < 0:
		speed = speed + accel
		if speed > 0:
			speed = 0
	elif speed > 0:
		speed = speed - accel
		if speed < 0:
			speed = 0

	position.x = position.x + 30 * delta * speed
	position.x = clamp(position.x, leftEdge, rightEdge)
	
func processDead(delta):
	deathSequenceTimer.update(delta)
	scale = (1.0 - deathSequenceTimer.normalised()) * normalScale
	explosionTimeRemaining -= delta
	if explosionTimeRemaining <= 0:
		explosionTimeRemaining += explosionTime
		if explosionsRemaining > 0:
			explosionsRemaining -= 1
			fireExplosion()
		else:
			dead = true
			
func fireExplosion():
	var explosion = Explosion.instance()
	explosion.position = position + Vector2(rand_range(-explosionRadius, explosionRadius), rand_range(-explosionRadius, explosionRadius))
	get_parent().add_child(explosion)

func fire():
	if pausedMode:
		return
	var bullet = Bullet.instance()
	bullet.position = position
	bullet.position.y = bullet.position.y - 40
	get_parent().add_child(bullet, true)

func hit(object):
	if health <= 0:
		return
	var what = object.get_parent()
	if what is HomingMissile:
		updateHealth(5)
	elif what is Bomb:
		updateHealth(12)
		
func updateHealth(damage):
	health -= damage
	if health < 0:
		health = 0
	if health == 0:
		startDeathSequence()
	healthBar.setValue(health, maxHealth, damage == 0)
	
func setPausedMode(isPausedMode):
	pausedMode = isPausedMode
	
func startDeathSequence():
	deathSequenceTimer = OneShotTimer.new(explosions * explosionTime)
	normalScale = scale
	explosionsRemaining = explosions
	explosionTimeRemaining = 0
	
func reset():
	dead = false
	health = maxHealth
	position.x = 1920 / 2
	speed = 0
	healthBar.setValue(health, maxHealth, true)
	scale = normalScale