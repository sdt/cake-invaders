class_name Bomb

extends Sprite

var velocity = Vector2(0, 0)
var accel    = Vector2(0, 2.25)
var life     = 2
const gameObjectType = "EnemyBullet"

var target # unused

func _ready():
	$Area2D.connect("area_entered", self, "hit")

func _process(delta):
	if position.y >= 1080:
		die()
	velocity = velocity + accel * delta
	position = position + velocity
	
func hit(object):
	var what = object.get_parent().gameObjectType
	if what == "PlayerBullet":
		life = life - 1
	elif what == "Player":
		life = 0
	if life <= 0:
		die()

func die():
	queue_free()