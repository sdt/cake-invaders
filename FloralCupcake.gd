extends Sprite

# Declare member variables here. Examples:
# var a = 2
var damageTime = 0
var originalPosition
var xRadius = 450
var yRadius = 50
var xTheta = 0
var yTheta = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	originalPosition = position
	$Area2D.connect("area_entered", self, "hit")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	xTheta = xTheta + delta * 0.13
	while xTheta > PI * 2:
		xTheta = xTheta - PI * 2
	yTheta = yTheta + delta * 0.57
	while yTheta > PI * 2:
		yTheta = yTheta - PI * 2 
	position.x = originalPosition.x + sin(xTheta) * xRadius
	position.y = originalPosition.y + sin(yTheta) * yRadius
		
	if damageTime > 0:
		damageTime = damageTime - delta
	elif damageTime < 0:
		damageTime = 0
		modulate.g = 1
		modulate.b = 1

func hit(object):
	damageTime = 0.33
	modulate.g = 0.5
	modulate.b = 0.5