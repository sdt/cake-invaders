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

enum GameMode { Playing, GameOver, PlayAgain };

var gameMode = GameMode.Playing
var spaceWasPressed = false

func _init():
	randomize()

func _ready():
	for child in get_children():
		if child is Player:
			player = child
	initLevel(Level[levelIndex])
		
func _process(delta):
	match gameMode:
		GameMode.Playing:
			updatePlaying(delta)
			
		GameMode.GameOver:
			pass
			
		GameMode.PlayAgain:
			updatePlayAgain(delta)
	
func updatePlaying(delta):
	if player.dead:
		ui.setMessage("Game Over", 2.5, self, "startPlayAgain")
		gameMode = GameMode.GameOver
	elif currentLevel.isFinished():
		if levelIndex == Level.size() - 1:
			ui.setMessage("You won!", 5, self, "startPlayAgain")
			gameMode = GameMode.GameOver
		else:
			closeLevel()
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
	
func closeLevel():
	remove_child(currentLevel)
	currentLevel.queue_free()
	
func startPlayAgain():
	ui.setMessage("Press space to play again")
	gameMode = GameMode.PlayAgain
	
func updatePlayAgain(delta):
	if spacePressed():
		reset()
		
func reset():
	player.reset()
	closeLevel()
	levelIndex = 1
	initLevel(Level[levelIndex])
	gameMode = GameMode.Playing
	
func spacePressed():
	var spaceIsPressed = Input.is_key_pressed(KEY_SPACE)
	var pressed = spaceWasPressed && !spaceIsPressed
	spaceWasPressed = spaceIsPressed
	return pressed