class_name Bullet

extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 5
const gameObjectType = "PlayerBullet"
var damage = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("area_entered", self, "hit")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y = position.y - speed
	if position.y < 0:
		queue_free()

func hit(object):
	queue_free()
