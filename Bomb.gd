class_name Bomb

extends Projectile

var velocity = Vector2(0, 30)
var accel    = Vector2(0, 175)
var life     = 3
const gameObjectType = "EnemyBullet"

var target # unused

func _process(delta):
	if position.y >= 1080:
		die()
	velocity = velocity + accel * delta
	position = position + velocity * delta
	
func hit(object):
	var what = object.get_parent().gameObjectType
	if what == "PlayerBullet":
		life = life - 1
	elif what == "Player":
		life = 0
	if life <= 0:
		die()