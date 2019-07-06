class_name EnemyBehaviourSinus

extends EnemyBehaviour

var originalPosition
export(int) var xRadius = 450
export(int) var yRadius = 50
export(float) var timeScale = 3.0

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
	xTheta = xTheta + delta * 0.13 * timeScale
	while xTheta > PI * 2:
		xTheta = xTheta - PI * 2
	yTheta = yTheta + delta * 0.57 * timeScale
	while yTheta > PI * 2:
		yTheta = yTheta - PI * 2 
	enemy.position.x = originalPosition.x + sin(xTheta) * xRadius
	enemy.position.y = originalPosition.y + sin(yTheta) * yRadius
