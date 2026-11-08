extends CharacterBody2D

@export var VELOCITY = 50
var dir = 1
var rng = RandomNumberGenerator.new()
enum State {IDLE, MOVING}
var currentState = State.IDLE

func _ready():
	var anim = rng.randi_range(0,3)
	match anim:
		0: $AnimatedSprite2D.animation = "large"
		1: $AnimatedSprite2D.animation = "squid"
		2: $AnimatedSprite2D.animation = "squiggly"
	$AnimatedSprite2D.play()


func _process(delta: float) -> void:
	if currentState == State.IDLE:
		velocity.x = lerp(velocity.x, VELOCITY*delta*dir, 1)
	if not is_on_floor():
		velocity += get_gravity()*delta
	move_and_slide()
	


func _on_timer_timeout() -> void:
	$Timer.wait_time = rng.randi_range(1,5)
	dir *= -1
