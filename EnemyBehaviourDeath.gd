class_name EnemyBehaviourDeath

extends EnemyBehaviour

var velocity = Vector2(0.0, -650)
var rotationSpeed = rand_range(2, 5) * PI

func _ready():
	if randi() & 1 == 0:
		rotationSpeed *= -1

func _process(delta):
	enemy.rotate(rotationSpeed * delta)
	enemy.position += velocity * delta