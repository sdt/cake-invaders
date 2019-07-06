extends Enemy

# Declare member variables here. Examples:
# var a = 2
var damageTime = 0
var originalPosition
const xRadius = 450
const yRadius = 50
var xTheta = 0
var yTheta = 0
const timeScale = 3.0
const gameObjectType = "Enemy"
const HomingMissile = preload("res://HomingMissile.tscn")
const missileTime = 2
var timeUntilMissile = 1

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	originalPosition = position
	$Area2D.connect("area_entered", self, "hit")
	player = get_parent().find_node("Player", true, false);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	xTheta = xTheta + delta * 0.13 * timeScale
	while xTheta > PI * 2:
		xTheta = xTheta - PI * 2
	yTheta = yTheta + delta * 0.57 * timeScale
	while yTheta > PI * 2:
		yTheta = yTheta - PI * 2 
	position.x = originalPosition.x + sin(xTheta) * xRadius
	position.y = originalPosition.y + sin(yTheta) * yRadius
		
	if damageTime > 0:
		damageTime = damageTime - delta
	elif damageTime < 0:
		damageTime = 0
		modulate.g = 1
		modulate.b = 1
		
	timeUntilMissile = timeUntilMissile - delta
	if timeUntilMissile < 0:
		timeUntilMissile = timeUntilMissile + missileTime
		fire(player)

func hit(object):
	damageTime = 0.33
	modulate.g = 0.5
	modulate.b = 0.5
	
func fire(target):
	var missile = HomingMissile.instance();
	missile.position = position
	missile.position.y = missile.position.y + 40
	missile.target = target
	get_parent().add_child(missile)