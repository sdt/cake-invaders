class_name Level

extends Node2D

export(String, MULTILINE) var message = "Get Ready";

var shown = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var hb = $HealthBar
	print_tree_pretty()
	printt("HealthBar=", hb)
	for child in get_children():
		if child is Enemy:
			child.healthBar = hb
			break
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
