class_name GameLevel

extends Level

export(bool) var hasPlayer = true;

var enemy

func _ready():
	for child in get_children():
		if child is Enemy:
			enemy = child
			enemy.healthBar = $HealthBars/EnemyHealthBar
			
func setPlayer(player):
	player.healthBar = $HealthBars/PlayerHealthBar
			
func isFinished():
	return enemy.currentHealth <= 0