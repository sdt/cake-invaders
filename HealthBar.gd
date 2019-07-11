class_name HealthBar
extends Sprite

export(Vector2) var bar
export(Color) var healthyColor = Color.green
export(Color) var sickColor = Color.red

var value = 1.0
onready var barOffset = -bar / 2
	
func setValue(currentHealth, maxHealth):
	value = currentHealth * 1.0 / maxHealth
	$BarCanvas.update()