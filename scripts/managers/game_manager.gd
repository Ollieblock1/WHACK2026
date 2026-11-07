extends Node2D


var colonyExpectations
var planetValues


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
	$Thermometer.setTemp(-50)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_camera_oxygen_lost() -> void:
	print("DIE")
