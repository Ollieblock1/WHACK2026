extends "res://alienEntity/charging_alien.gd"

func _on_detector_area_entered(area: Area2D) -> void:
	$eyebrows.visible = false
	self.modulate = Color(1.877, 0.161, 0.0, 0.482)
	super._on_detector_area_entered(area)
	
