class_name EnemyBehaviourSinus

extends EnemyBehaviour

var originalPosition
export(int) var width = 960
export(int) var height = 50
export(float) var horizontalSpeed = 3.2
export(float) var verticalSpeed = 8.1

var xTheta = rand_range(0, PI * 2)
var yTheta = rand_range(0, PI * 2)

# Called when the node enters the scene tree for the first time.
func _ready():
	originalPosition = enemy.position
	_process(0)
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
