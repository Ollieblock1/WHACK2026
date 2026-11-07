extends Node2D

var random = RandomNumberGenerator.new()
var temp
var viewedTemp

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	viewedTemp = random.randf_range(-100, 100)

func setTemp(inTemp) -> void:
	temp = inTemp

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	viewedTemp += ((temp-viewedTemp)/5) * delta
	print(viewedTemp)
