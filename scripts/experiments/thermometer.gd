extends Node2D

var random = RandomNumberGenerator.new()
var temp # actual temperature
var viewedTemp 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	viewedTemp = random.randf_range(-100, 100)
	


# use setTemp when instantiated 
func setTemp(inTemp) -> void:
	temp = inTemp
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	viewedTemp += ((temp-viewedTemp)/5) * delta
	var displayedText
	if viewedTemp < 0:
		displayedText = "-" 
	else: 
		displayedText = "+"
	if len(str(int(abs(viewedTemp)))) < 2:
		displayedText += "0"
	displayedText += str(snapped(abs(viewedTemp), 0.1)) 

	$ProgressBar.value = viewedTemp
	$Label.text = displayedText


func _on_area_entered(area: Area2D) -> void:
	$Label.visible = true


func _on_area_exited(area: Area2D) -> void:
	$Label.visible = false
