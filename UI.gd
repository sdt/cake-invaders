extends Node2D

var messageTimeRemaining
var messageCaller
var messageMethod

onready var messageBox = $Message

func _process(delta):
	updateMessage(delta)
	
func clearMessage():
	messageBox.visible = false
	messageCaller = null
	messageMethod = ""

func setMessage(text, timeout = 0.0, caller = null, method = ""):
	messageBox.text = text
	messageBox.visible = true
	messageTimeRemaining = timeout
	messageCaller = caller
	messageMethod = method
	
func updateMessage(delta):
	if messageTimeRemaining <= 0:
		return
	messageTimeRemaining -= delta
	if messageTimeRemaining > 0:
		return
	messageBox.visible = false
	if messageCaller != null:
		messageCaller.call(messageMethod)