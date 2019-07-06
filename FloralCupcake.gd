extends Enemy

# Declare member variables here. Examples:
# var a = 2
var damageTime = 0
const gameObjectType = "Enemy"
const HomingMissile = preload("res://HomingMissile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("area_entered", self, "hit")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):		
	if damageTime > 0:
		damageTime = damageTime - delta
	elif damageTime < 0:
		damageTime = 0
		modulate.g = 1
		modulate.b = 1
		
func hit(object):
	damageTime = 0.33
	modulate.g = 0.5
	modulate.b = 0.5

func makeMissile():
	return HomingMissile.instance();