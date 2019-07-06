class_name EnemyBehaviourSinus

extends EnemyBehaviour

var originalPosition
export(int) var width = 960
export(int) var height = 50
export(float) var horizontalSpeed = 3.2
export(float) var verticalSpeed = 8.1

var xTheta = 0
var yTheta = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	originalPosition = enemy.position
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	xTheta = xTheta + delta * horizontalSpeed * 0.1
	while xTheta > PI * 2:
		xTheta = xTheta - PI * 2
	yTheta = yTheta + delta * verticalSpeed * 0.1
	while yTheta > PI * 2:
		yTheta = yTheta - PI * 2 
	enemy.position.x = originalPosition.x + cos(xTheta) * width
	enemy.position.y = originalPosition.y + sin(yTheta) * height
