extends Control

var inhabitableValue = false
signal choiceMade(choice)




func _on_check_button_toggled(toggled_on: bool) -> void:
	inhabitableValue = toggled_on


func _on_button_pressed() -> void:
	choiceMade.emit(inhabitableValue)
