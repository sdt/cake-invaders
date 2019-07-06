extends Enemy

const gameObjectType = "Enemy"
const HomingMissile = preload("res://HomingMissile.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func makeMissile():
	return HomingMissile.instance();