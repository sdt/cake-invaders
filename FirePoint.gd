class_name FirePoint
extends Position2D

tool

export(String, "HomingMissile", "Bomb") var missileType = "HomingMissile" setget setMissileType

const missileClass = {
	"HomingMissile": preload("res://HomingMissile.tscn"),
	"Bomb": preload("res://Bomb.tscn"),
}

func _ready():
	if Engine.editor_hint:
		attachMissile()

func setMissileType(type):
	missileType = type
	if not Engine.editor_hint:
		return
	detachMissile()
	attachMissile()

func attachMissile():
	var missile = missileClass.get(missileType).instance()
	for child in missile.get_children():
		missile.remove_child(child)
		child.queue_free()
	missile.z_index = 90
	add_child(missile)
	
func detachMissile():
	if get_child_count() == 0:
		return
	var child = get_child(0)
	remove_child(child)
	child.queue_free()