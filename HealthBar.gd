class_name HealthBar
extends Sprite

export(Vector2) var bar

var value = 1.0
var barOffset = bar / 2

func _ready():
	barOffset = -bar / 2
	show_behind_parent = true

func setValue(currentHealth, maxHealth):
	value = currentHealth * 1.0 / maxHealth
	update()
	
func _draw():
	var foo = Vector2(bar.x * value, bar.y)
	var z = z_index
	z_index = z_index + 1
	draw_rect(Rect2(barOffset, foo), Color(0.75, 0.5, 0.2), true)
	z_index = z
	
