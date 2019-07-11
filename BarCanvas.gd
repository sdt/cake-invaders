extends Node2D

func interpolate(a, b, t):
	return a + (b - a) * t
	
func interpolate_color(a, b, t):
	var h = interpolate(a.h, b.h, t)
	var s = interpolate(a.s, b.s, t)
	var v = interpolate(a.v, b.v, t)
	return Color.from_hsv(h, s, v)

func _draw():
	var p = get_parent()
	var bar = Vector2(p.bar.x * p.value, p.bar.y)
	var c = interpolate(p.healthyColor, p.sickColor, 1.0 - p.value)
	draw_rect(Rect2(p.barOffset, bar), c, true)