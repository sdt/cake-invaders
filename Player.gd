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
var maxHealth = 100
var health = maxHealth
var pausedMode = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("area_entered", self, "hit")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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

func fire():
	if pausedMode:
		return
	var bullet = Bullet.instance()
	bullet.position = position
	bullet.position.y = bullet.position.y - 40
	get_parent().add_child(bullet)

func hit(object):
	var what = object.get_parent()
	if what is HomingMissile:
		updateHealth(5)
	elif what is Bomb:
		updateHealth(12)
		
func updateHealth(damage):
	health -= damage
	if health < 0:
		health = 0
	healthBar.setValue(health, maxHealth, damage == 0)
	
func setPausedMode(isPausedMode):
	pausedMode = isPausedMode
	