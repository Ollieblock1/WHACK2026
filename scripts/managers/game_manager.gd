extends Node2D


var procgenEngine
var procgenResults
var infoScreen = preload("res://scenes/infoScreen.tscn")

var experiments = [
	preload("res://scenes/experiments/thermometer.tscn"),
	preload("res://scenes/experiments/airPylon.tscn"),
	preload("res://scenes/experiments/flyingMetal.tscn")
]

signal levelOver(results)
'''
What is the purpose of this?
this sits on the game, takes input from the procedural_generation code, 
1. distributes to UI
2. loads level in relation to chosen generation
3. detect when level over
4. generally connect things :)
'''



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	procgenEngine = preload("res://scripts/procedural_generation.gd").new()
	
	procgenResults = procgenEngine.generate_planet()
	print(procgenResults)
	$Level.buildLevel(procgenResults[0])
	$Level.setColonyPreferences(procgenResults[1])
	print(procgenResults[0])
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_camera_oxygen_lost() -> void:
	print("DIE")




	


func _on_player_place_experiment(object: Variant, point: Variant) -> void:
	
	var instance = experiments[object].instantiate()
	print(procgenResults)
	match object:
		0:
			instance.setTemp(procgenResults[0].temp)
		1:
			instance.setAir(procgenResults[0].air)
		2:
			
			instance.setDirection(procgenResults[0].magnet)

	
	$Level.addObject(instance)
	instance.global_position = point
	$UI.updateInventory(object)


func _on_level_level_over() -> void:
	levelOver.emit(procgenResults[2])
