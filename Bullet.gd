class_name Bullet

extends Projectile

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 12.0
const gameObjectType = "PlayerBullet"
var damage = 1

func _process(delta):
	position.y = position.y - speed * 30 * delta
	if position.y < 0:
		queue_free()

func hit(object):
	die()
