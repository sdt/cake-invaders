extends Sprite

var target

const angleAdjust = 3 * PI / 2

func _ready():
	pass # Replace with function body.

func _process(delta):
	if position.y >= 1080:
		die()
		
	var angle = position.angle_to_point(target.position) + angleAdjust
	set_rotation(angle)
	printt(get_transform())
	position = position - transform.y * 2.0

func die():
	queue_free()