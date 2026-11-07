extends Node2D

signal levelOver

func _on_ship_2_level_over() -> void:
	levelOver.emit()
