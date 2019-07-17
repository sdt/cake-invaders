class_name HomingMissile

extends Projectile

var target

const angleAdjust = deg2rad(90)
const angleDelta = PI * 0.2
const angleLimit = deg2rad(45)
const minAngle = -angleLimit
const maxAngle = +angleLimit
var life = 1
const gameObjectType = "EnemyBullet"

# angle = 0 -> straight down = transform.y

func _ready():
	var angle = get_rotation()
	set_rotation(normalise(angle))

func _process(delta):
	if position.y >= 1080:
		die()
	elif position.y < 1800:
		updateHoming(delta)
	position = position + transform.y * 3.5 * 60 * delta
	
func updateHoming(delta):
	var targetAngle = normalise(position.angle_to_point(target.position) + angleAdjust)
	
	# We have a min/max angle, but we don't clamp to it. The missile can start outside that range
	# and the move into it, but once inside that range, can't move out.
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
		
# Normalises an angle to be between 
func normalise(angle):
	return wrapf(angle, -PI, +PI)