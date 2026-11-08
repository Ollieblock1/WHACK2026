extends Node2D

const gameManager = preload("res://scenes/managers/game_manager.tscn")
const postgame = preload("res://scenes/UI/post_game.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func clear():
	for i in get_children():
		i.queue_free()


func postGame(val):
	clear()
	print("ACTUAL", val)
	var instance = postgame.instantiate()
	instance.newLevel.connect(newLevel)
	add_child(instance)
	instance.setActual(val)
	
	
func newLevel():
	clear()
	var manager = gameManager.instantiate()
	manager.levelOver.connect(postGame)
	add_child(manager)
	

func _on_main_menu_start_game() -> void:
	newLevel()
	
