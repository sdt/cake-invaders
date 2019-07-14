class_name OneShotTimer
extends Object

var endTime
var currentTime

func _init(duration):
	currentTime = 0.0
	endTime = duration
	
func update(delta):
	currentTime += delta
	if currentTime > endTime:
		currentTime = endTime
	return isFinished()
		
func normalised():
	return currentTime / endTime
	
func isFinished():
	return currentTime >= endTime