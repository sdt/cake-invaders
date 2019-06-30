extends Sprite

var target

const angleAdjust = 3 * PI / 2
const angleDelta = PI * 0.2
const angleLimit = PI / 4
const minAngle = PI - angleLimit
const maxAngle = PI + angleLimit
var life = 3
const gameObjectType = "EnemyBullet"

func _ready():
	$Area2D.connect("area_entered", self, "hit")

func _process(delta):
	if position.y >= 1080:
		die()
	elif position.y < 900:
		updateHoming(delta)
			
	position = position - transform.y * 3.0
	
func updateHoming(delta):
	var targetAngle = position.angle_to_point(target.position) + angleAdjust
	var angle = get_rotation()
	if angle > targetAngle:
		angle = angle - angleDelta * delta
		if angle < minAngle:
			angle = minAngle
	elif angle < targetAngle:
		angle = angle + angleDelta * delta
		if angle > maxAngle:
			angle = maxAngle
	set_rotation(angle)	
	
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