extends CharacterBody2D

var direction
var speed = 200
var directions = [Vector2(0,1*speed), Vector2(-1*speed,0), Vector2(0,-1*speed), Vector2(1*speed,0)]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func setDirection(inDirection):
	# 0: fall
	# 1: left
	# 2: up
	# 3: right
	direction = inDirection

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity+=(directions[direction])*delta
	move_and_slide()
