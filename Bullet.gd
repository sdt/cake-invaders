extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 5
const gameObjectType = "PlayerBullet"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("area_entered", self, "hit")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position.y = self.position.y - speed
	if self.position.y < 0:
		self.queue_free()

func hit(object):
	queue_free()