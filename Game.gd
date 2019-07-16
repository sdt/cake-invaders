extends Node2D

var player

const Level = [
	preload("res://StartScreen.tscn"),
	preload("res://AttractScreen.tscn"),
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

export(String, MULTILINE) var winMessage = "Congratulations!\n\nYou won!"
export(String, MULTILINE) var loseMessage = "Game Over"
export(String, MULTILINE) var playAgainMessage = "Press space to play again"
export(int, 2, 6) var winLoseMessageTime = 3

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
		ui.setMessage(loseMessage, winLoseMessageTime, self, "startPlayAgain")
		gameMode = GameMode.GameOver
	elif currentLevel.isFinished():
		if levelIndex == Level.size() - 1:
			ui.setMessage(winMessage, 3, self, "startPlayAgain")
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
	
func setWinLoseMessage():
	var message = loseMessage if player.dead else winMessage
	ui.setMessage(message, winLoseMessageTime, self, "startPlayAgain")
	
func startPlayAgain():
	gameMode = GameMode.PlayAgain
	ui.setMessage(playAgainMessage, winLoseMessageTime, self, "setWinLoseMessage")
	
func updatePlayAgain(delta):
	if spacePressed():
		reset()
		
func reset():
	player.reset()
	closeLevel()
	levelIndex = 2
	initLevel(Level[levelIndex])
	gameMode = GameMode.Playing
	
func spacePressed():
	var spaceIsPressed = Input.is_key_pressed(KEY_SPACE)
	var pressed = spaceWasPressed && !spaceIsPressed
	spaceWasPressed = spaceIsPressed
	return pressed