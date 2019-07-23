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
	checkExit()
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
	if Input.is_action_just_pressed("ui_fire"):
		reset()

func reset():
	player.reset()
	closeLevel()
	levelIndex = 2
	initLevel(Level[levelIndex])
	gameMode = GameMode.Playing
	
const quitKeys = [
	"ui_gamepad_quit_1", 
	"ui_gamepad_quit_2", 
	"ui_gamepad_quit_3", 
	"ui_gamepad_quit_4", 
];

func checkExit():
	if Input.is_action_just_pressed("ui_kb_quit"):
		get_tree().quit()
	if allPressed(quitKeys) && Input.is_action_just_pressed("ui_gamepad_quit"):
		get_tree().quit()
	
func allPressed(inputs):
	for input in inputs:
		if !Input.is_action_pressed(input):
			return false
	return true
		
		
		
