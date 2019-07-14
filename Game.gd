extends Node2D

var player

const Level = [
	preload("res://StartScreen.tscn"),
	preload("res://Level1.tscn"),
	preload("res://Level2.tscn"),
	preload("res://Level3.tscn"),
	preload("res://Level4.tscn"),
	preload("res://Level5.tscn"),
	preload("res://Level6.tscn"),
]
var levelIndex = 0 # Level.size() - 1;
var currentLevel
onready var ui = $UI

func _init():
	randomize()

func _ready():
	for child in get_children():
		if child is Player:
			player = child
	initLevel(Level[levelIndex])
		
func _process(delta):
	if player.dead:
		ui.setMessage("Game Over")
		 
	if currentLevel.isFinished():
		remove_child(currentLevel)
		levelIndex = (levelIndex + 1) % Level.size()
		initLevel(Level[levelIndex])

func initLevel(type):
	currentLevel = type.instance()
	currentLevel.ui = ui
	if currentLevel is GameLevel:
		player.visible = true
		currentLevel.setPlayer(player)
	else:
		player.setPausedMode(true)
		player.visible = false

	add_child(currentLevel)