class_name UILevel
extends Level

export(Array, String, MULTILINE) var messages = []
export(bool) var canClickPast = false
export(float) var messageTime = 2

var spaceWasDown = false
var finished = false

func _ready():
	ui.setMessage(messages, messageTime, self, "onMessageComplete")

func _process(delta):
	if finished:
		return
	
	if spaceWasPressed() && canClickPast:
		ui.clearMessage()
		finished = true

func onMessageComplete():
	if canClickPast:
		ui.setMessage(messages, messageTime, self, "onMessageComplete")
	else:
		ui.clearMessage()
		finished = true
			

func isFinished():
	return finished
	
func spaceWasPressed():
	var spaceIsDown = Input.is_key_pressed(KEY_SPACE)
	var wasPressed = spaceWasDown && !spaceIsDown
	spaceWasDown = spaceIsDown
	return wasPressed