extends Camera2D

var timeCount
signal oxygenLost


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timeCount = 20


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timeCount -= delta
	var displayText = ""
	if int(timeCount/60) != 0:
		displayText += str(int(timeCount/60)) + ":"
	if int(timeCount) % 60 < 10:
		displayText += "0" + str(int(timeCount) % 60)
		if int(timeCount/60) == 0:
			$Label.modulate = Color(1.0, 0.0, 0.0, 1.0)
	else:
		displayText += str(int(timeCount) % 60)
	
	$Label.text = displayText
	if timeCount < 0:
		timeCount = 0
		oxygenLost.emit()
		
		
