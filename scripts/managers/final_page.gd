extends Control

signal nextLevel


func _on_button_pressed() -> void:
	nextLevel.emit()


func setText(text):
	$Label2.text= text
