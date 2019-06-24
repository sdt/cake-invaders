extends Sprite

# Declare member variables here. Examples:
var speed = 0
var maxSpeed = 6
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
