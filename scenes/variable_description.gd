extends Control

signal levelEnded

func set_variable_description(colony_expectations):
	var alien_status = ""
	if not colony_expectations.aliens:
		alien_status = "and no aliens\nwhatsoever"
	$VariableDescription.text = "in addition, this group has
		requested the planet have a\ntemperature of\
		 between " + str(colony_expectations.lower_temp) + "
		and " + str(colony_expectations.upper_temp) + str(alien_status)


func _on_next_page_pressed() -> void:
	levelEnded.emit()
	print("ENDED")
