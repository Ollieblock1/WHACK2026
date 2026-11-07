extends Camera2D

var timeCount
signal oxygenLost
var emitted = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timeCount = 120



func decreaseTimer(delta):
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
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timeCount -= delta
	if timeCount >= 0:
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
	else:
		$Label.text = "00"
		if emitted == false:
			oxygenLost.emit()
			emitted = true
	


func _on_player_show_info() -> void:
	$InfoScreen.show()


func _on_player_hide_info() -> void:
	$InfoScreen.hide()
