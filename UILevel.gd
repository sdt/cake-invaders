class_name UILevel
extends Level

export(Array, String, MULTILINE) var messages = []

var spaceWasDown = false
var finished = false
var messageIndex = -1
var messageTime = 2
var showingLastMessage = false

func _ready():
	onMessageComplete()

func _process(delta):
	if finished:
		return
	
	if spaceWasPressed() && showingLastMessage:
		ui.clearMessage()
		finished = true

func onMessageComplete():
	messageIndex += 1
	if messageIndex < messages.size() - 1:
		ui.setMessage(messages[messageIndex], messageTime, self, "onMessageComplete")
	else:
		ui.setMessage(messages[messageIndex]) # last message stays on screen
		showingLastMessage = true
			

func isFinished():
	return finished
	
func spaceWasPressed():
	var spaceIsDown = Input.is_key_pressed(KEY_SPACE)
	var wasPressed = spaceWasDown && !spaceIsDown
	spaceWasDown = spaceIsDown
	return wasPressed