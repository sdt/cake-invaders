class_name GameLevel
extends Level

export(String, MULTILINE) var message = "Get Ready";

const endOfLevelWaitTime = 3
var waitTime = 0.0

var enemy
var player

func _ready():
	for child in get_children():
		if child is Enemy:
			enemy = child
			enemy.healthBar = $HealthBars/EnemyHealthBar
	ui.setMessage(message, 2)
			
func _process(delta):
	if waitTime == 0 && enemy.currentHealth <= 0:
		waitTime = delta
		player.setPausedMode(true)
	elif waitTime > 0:
		waitTime += delta
			
func setPlayer(p):
	player = p
	p.healthBar = $HealthBars/PlayerHealthBar
	p.updateHealth(0)
	p.setPausedMode(false)
			
func isFinished():
	return waitTime >= endOfLevelWaitTime