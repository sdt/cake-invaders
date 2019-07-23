class_name HealthBar
extends Sprite

export(Vector2) var bar
export(Color) var healthyColor = Color.green
export(Color) var sickColor = Color.red

var value = 1.0
var targetValue = 1.0
var indicatedValue = -1

var indicator

func _ready():
	for child in get_children():
		if child is Sprite:
			indicator = setupIndicator(child)

onready var barOffset = -bar / 2
const targetRate = 0.6
	
func _process(delta):
	var adjust = delta * targetRate
	if targetValue < value:
		value -= adjust
		if value < targetValue:
			value = targetValue
	if indicatedValue != value:
		indicatedValue = value
		setIndicatorValue(indicator, value)
		
func setupIndicator(i):
	i.region_rect.position = Vector2.ZERO
	i.region_rect.size = i.texture.get_size()
	return i
	
func setIndicatorValue(i, v):
	var width = i.region_rect.size.x
	var offset = (1.0 - v) * width
	i.region_rect.position.x = offset
			
func setValue(currentHealth, maxHealth, immediate = false):
	targetValue = currentHealth * 1.0 / maxHealth
	if immediate:
		value = targetValue
		indicatedValue = -1 # force refresh