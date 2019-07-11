class_name HealthBar
extends Sprite

export(Vector2) var bar
export(Color) var healthyColor = Color.green
export(Color) var sickColor = Color.red

var value = 1.0
var targetValue = 1.0
onready var barOffset = -bar / 2
const targetRate = 1
	
func setValue(currentHealth, maxHealth):
	targetValue = currentHealth * 1.0 / maxHealth
	
func _process(delta):
	var adjust = delta * targetRate
	if targetValue < value:
		value -= adjust
		if value < targetValue:
			value = targetValue
		$BarCanvas.update()