extends Node2D
var chosenValue
var actualValue

var loss = preload("res://scenes/UI/loss_page.tscn")
var win = preload("res://scenes/UI/win_page.tscn")
signal newLevel

func setActual(val):
	actualValue = val
	
	
func clear():
	for i in get_children():
		i.queue_free()


func _on_choice_page_choice_made(val) -> void:
	clear()
	chosenValue = val
	var instance
	print("chosen", chosenValue)
	print("actual",actualValue)
	if chosenValue == actualValue:
		instance = win.instantiate()
		if chosenValue == false: #success!!! you helped people
			instance.setText("That planet wasn't habitable,\n you saved the colony")
		else:
			instance.setText("You found a new home for the colony")
			
	else:
		instance = loss.instantiate()
		if chosenValue == false: #success!!! you helped people
			instance.setText("This could've been the perfect home")
		else:
			instance.setText("This planet wasn't habitable,\n you killed everyone")
	
	
	add_child(instance)
	instance.nextLevel.connect(newLevelChosen)

func newLevelChosen():
	newLevel.emit()
			
