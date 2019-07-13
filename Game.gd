extends Node2D

var player

enum { ModeBegin, ModeStartScreen, ModeMainGame, ModeGameOver }
var mode = ModeBegin

const StartScreen = preload("res://StartScreen.tscn")
const Level = [
	preload("res://Level4.tscn"),
	preload("res://Level1.tscn"),
	preload("res://Level2.tscn"),
	preload("res://Level3.tscn"),
];
var startScreen
var levelIndex = 0
var currentLevel
const messageTime = 2
var messageTimeRemaining = 0

func _init():
	randomize() # Replace with function body.

func _ready():
	for child in get_children():
		if child is Player:
			player = child
	initLevel(Level[levelIndex])
		
func _process(delta):
	if messageTimeRemaining > 0:
		messageTimeRemaining = messageTimeRemaining - delta
		if messageTimeRemaining <= 0:
			$Message.visible = false
	if currentLevel.isFinished():
		remove_child(currentLevel)
		levelIndex = (levelIndex + 1) % Level.size()
		initLevel(Level[levelIndex])
		
func updateMode():
	return
	match mode:
		ModeBegin:
			initStartScreen()
			mode = ModeStartScreen
		ModeStartScreen:
			if updateStartScreen():
				startScreen.queue_free()
				#initNextLevel()
				mode = ModeMainGame

func initStartScreen():
	startScreen = StartScreen.instance()
	add_child(startScreen)
	print_tree_pretty()
	
func updateStartScreen():
	return Input.is_key_pressed(KEY_SPACE)
		
func initLevel(type):
	currentLevel = type.instance()
	currentLevel.setPlayer(player)
	var message = $Message
	message.text = currentLevel.message
	message.visible = true
	
	messageTimeRemaining = messageTime
	add_child(currentLevel)