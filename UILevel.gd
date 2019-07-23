class_name UILevel
extends Level

export(Array, String, MULTILINE) var messages = []
export(bool) var canClickPast = false
export(float) var messageTime = 2

var finished = false

func _ready():
	ui.setMessage(messages, messageTime, self, "onMessageComplete")

func _process(delta):
	if finished:
		return

	if Input.is_action_just_pressed("ui_fire") && canClickPast:
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
