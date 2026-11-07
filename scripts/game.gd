extends Node2D

const gameManager = preload("res://scenes/managers/game_manager.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_main_menu_start_game() -> void:
	$MainMenu.queue_free()
	var manager = gameManager.instantiate()
	add_child(manager)
	
