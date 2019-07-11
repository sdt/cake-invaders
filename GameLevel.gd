class_name GameLevel

extends Level

export(bool) var hasPlayer = true;

var player
var enemy

func _ready():
	for child in get_children():
		if child is Enemy:
			enemy = child
			
func isFinished():
	return enemy.currentHealth <= 0