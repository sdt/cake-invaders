extends Sprite

# Declare member variables here. Examples:
var speed = 0
const maxSpeed = 6
var fireButtonDown = false
const Bullet = preload("res://Bullet.tscn")
const gameObjectType = "Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var fireButtonPrev = fireButtonDown
	fireButtonDown = Input.is_key_pressed(KEY_SPACE)
	if fireButtonDown and not fireButtonPrev:
		fire()
	if Input.is_key_pressed(KEY_LEFT):
		if speed > 0:
			speed = -1
		elif -speed <= maxSpeed:
			speed = speed - 1
	elif Input.is_key_pressed(KEY_RIGHT):
		if speed < 0:
			speed = 1
		elif speed <= maxSpeed:
			speed = speed + 1
	elif speed < 0:
		speed = speed + 1
	elif speed > 0:
		speed = speed - 1
		
	self.position.x = self.position.x + speed

func fire():
	var bullet = Bullet.instance()
	bullet.position = self.position
	bullet.position.y = bullet.position.y - 40
	self.get_parent().add_child(bullet)