extends "res://alienEntity/base_alien.gd"

var target : Area2D
@export var SPEEDINCREASE = 2.5

func _on_detector_area_entered(area: Area2D) -> void:
	target = area
	currentState = State.MOVING


func _process(delta: float) -> void:
	if currentState == State.MOVING:
		var positionDelta = self.global_position.x - target.global_position.x
		velocity.x = lerp(velocity.x, SPEEDINCREASE*VELOCITY*delta*-sign(positionDelta), 0.1)
	super._process(delta)
	
	
