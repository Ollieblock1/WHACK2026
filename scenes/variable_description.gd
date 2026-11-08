extends Control

func set_variable_description(colony_expectations):
	var alien_status = ""
	if not colony_expectations.aliens:
		alien_status = "and no aliens\nwhatsoever"
	$VariableDescription.text = "in addition, this group has
		\nrequested the planet have a\ntemperature of\
		between" + colony_expectations.lower_temp + "\n
		and" + colony_expectations.upper_temp + alien_status


func _on_next_page_pressed() -> void:
	pass # Replace with function body.
