class_name Explosion

extends Sprite

export(float, 0.2, 2) var lifeTime = 1
export(float, 0.3, 0.5) var minScale = 0.3
export(float, 0.5, 1.5) var maxScale = 0.7
var time = 0.0
var rot

func _ready():
	rot = rand_range(-PI, +PI)

func _process(delta):
	time += delta
	if time > lifeTime:
		queue_free()
	var t = time / lifeTime
	var s = minScale + (maxScale - minScale) * t
	scale = Vector2(s, s)
	rotate(rot * delta)
	