extends Area2D

signal levelOver

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		levelOver.emit()
