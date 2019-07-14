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
const messageTime = 2
var messageTimeRemaining = 0
onready var messageBox = $UI/Message

func _init():
	randomize()

func _ready():
	for child in get_children():
		if child is Player:
			player = child
	initLevel(Level[levelIndex])
		
func _process(delta):
	if messageTimeRemaining > 0:
		messageTimeRemaining = messageTimeRemaining - delta
		if messageTimeRemaining <= 0:
			messageBox.visible = false
	if currentLevel.isFinished():
		remove_child(currentLevel)
		levelIndex = (levelIndex + 1) % Level.size()
		initLevel(Level[levelIndex])

func initLevel(type):
	currentLevel = type.instance()
	if currentLevel is GameLevel:
		player.visible = true
		messageBox.visible = true
		messageBox.text = currentLevel.message
		currentLevel.setPlayer(player)
		messageTimeRemaining = messageTime
	else:
		player.setPausedMode(true)
		player.visible = false
		currentLevel.messageBox = messageBox
		messageTimeRemaining = 0
	
	add_child(currentLevel)