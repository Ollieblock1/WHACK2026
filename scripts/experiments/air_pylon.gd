extends Node2D

var random = RandomNumberGenerator.new()
var air
var viewable = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func setAir(inAir) -> void:
	air = inAir

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if viewable:
		print(air)


func _on_reading_time_timeout() -> void:
	viewable = true
	
