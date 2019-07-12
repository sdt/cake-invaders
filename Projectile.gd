# This is the base class for all projectiles
class_name Projectile
extends Sprite

const Explosion = preload("res://Explosion.tscn")

func _ready():
	$Area2D.connect("area_entered", self, "hit")
	
func die():
	var explosion = Explosion.instance()
	explosion.position = position
	get_parent().add_child(explosion)
	queue_free()