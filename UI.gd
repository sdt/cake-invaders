extends Node2D

var messageTimeRemaining
var messageTimeout
var messageCaller
var messageMethod
var messageIndex
var messages

onready var messageBox = $Message

func _process(delta):
	updateMessage(delta)
	
func clearMessage():
	messageBox.visible = false
	messageCaller = null
	messageMethod = ""
	messages = []
	messageBox.text = ""

func setMessage(text, timeout = 0.0, caller = null, method = ""):
	if text is Array:
		messages = text
	else:
		messages = [ text ]
	messageIndex = 0	
	messageTimeout = timeout
	messageTimeRemaining = timeout
	messageCaller = caller
	messageMethod = method
	messageBox.text = messages[messageIndex]
	messageBox.visible = true
	
func updateMessage(delta):
	if messageTimeRemaining <= 0:
		return
	messageTimeRemaining -= delta
	if messageTimeRemaining > 0:
		return
	messageIndex += 1
	if messageIndex < messages.size():
		messageTimeRemaining = messageTimeout
		messageBox.text = messages[messageIndex]
	else:
		messageBox.visible = false
		if messageCaller != null:
			messageCaller.call(messageMethod)