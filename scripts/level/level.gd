extends Node2D

signal displayMenu
var friendlyPassive = preload("res://alienEntity/base_alien.tscn")
var friendlyActive = preload("res://alienEntity/chargingAlien.tscn")
var Hostile = preload("res://alienEntity/hostile_alien.tscn")
var infoScreen = preload("res://scenes/infoScreen.tscn")
var rng = RandomNumberGenerator.new()
var colonyPreferences
signal levelOver


func setColonyPreferences(colonyObject):
	colonyPreferences = colonyObject


func addObject(object):
	$Experiments.add_child(object)


func buildLevel(levelObject):
	var instance
	if levelObject.aliens:
		if levelObject.aliens_friendly:
			if rng.randi() == 0:
				instance = friendlyActive.instantiate()
			else:
				instance = friendlyPassive.instantiate()
		else:
			instance = Hostile.instantiate()
		
		$Path2D/PathFollow2D.progress_ratio = rng.randf_range(0,1)
		instance.global_position = $Path2D/PathFollow2D.global_position
		$aliens.add_child(instance)
	
	print(levelObject.aliens)


func endLevel():
	levelOver.emit()

func _on_ship_2_body_exited(body: Node2D) -> void:
	for i in $UI.get_children():
		i.queue_free()


func _on_ship_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var instance = infoScreen.instantiate()
		instance.global_position = $screen.global_position
		#once implemented
		instance.set_variable_description(colonyPreferences)
		instance.levelEnded.connect(endLevel)
		$UI.add_child(instance)
