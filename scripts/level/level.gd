extends Node2D

signal displayMenu
var friendlyPassive = preload("res://alienEntity/base_alien.tscn")
var friendlyActive = preload("res://alienEntity/chargingAlien.tscn")
var Hostile = preload("res://alienEntity/hostile_alien.tscn")
var infoScreen = preload("res://scenes/infoScreen.tscn")
var rng = RandomNumberGenerator.new()
var colonyPreferences
signal levelOver


var backgrounds 
var floors

func _ready() -> void:
	backgrounds = [
		preload("res://assets/backgrounds/origbig.png"),
		preload("res://assets/backgrounds/origbig (2).png"),
		preload("res://assets/backgrounds/origbig (3).png"),
		preload("res://assets/backgrounds/origbig (4).png"),
		preload("res://assets/backgrounds/origbig (5).png"),
		preload("res://assets/backgrounds/origbig (6).png"),
		preload("res://assets/backgrounds/origbig (7).png"),
		preload("res://assets/backgrounds/origbig (8).png"),	
	]
	floors = [
		preload("res://assets/floor/map.png"),
		preload("res://assets/floor/metal_floor(1).png"),
		preload("res://assets/floor/metal_floor.png")
	]


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
	$Sprite2D.texture = backgrounds[rng.randi_range(0,len(backgrounds)-1)]
	$floor/Sprite2D.texture = floors[rng.randi_range(0,len(floors)-1)]


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
