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
	$ProgressBar.value = 100-($readingTime.time_left*10)


func _on_reading_time_timeout() -> void:
	$Label.text = "Air quality: good" if air else "Air quality: bad"
	


func _on_area_entered(area: Area2D) -> void:
	$Label.show()


func _on_area_exited(area: Area2D) -> void:
	$Label.hide()
