class_name UILevel
extends Level

export(Array, String, MULTILINE) var messages = []

var messageBox

var spaceWasDown = false
var finished = false
var messageIndex = 0

func _ready():
	messageBox.text = messages[messageIndex]

func _process(delta):
	if finished:
		return
		
	if spaceWasPressed():
		messageIndex += 1
		if messageIndex >= messages.size():
			finished = true
			messageBox.visible = false
		else:
			messageBox.text = messages[messageIndex]


func isFinished():
	return finished
	
func spaceWasPressed():
	var spaceIsDown = Input.is_key_pressed(KEY_SPACE)
	var wasPressed = spaceWasDown && !spaceIsDown
	spaceWasDown = spaceIsDown
	return wasPressed