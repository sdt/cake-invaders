class_name Level

extends Node2D

export(String) var message = "Get Ready";

var enemies = [ ];

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		printt("Enemies = ", child.health)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
