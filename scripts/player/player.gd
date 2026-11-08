extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
signal placeExperiment(object, point)
@export var playerHeight = 128
var inventory = [1,1,1]
signal damage
var enemyIn = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if $AnimatedSprite2D.animation_finished:
			$AnimatedSprite2D.animation = "fall"

	# Handle jump.
	if Input.is_action_just_pressed("moveJump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.animation="jump"
		$AnimatedSprite2D.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("moveLeft", "moveRight")
	if direction:
		velocity.x = direction * SPEED
		if Input.is_action_pressed("moveLeft"):
			$AnimatedSprite2D.flip_h = true
		if Input.is_action_pressed("moveRight"):
			$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.animation = "run"
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if not (Input.is_anything_pressed() or is_on_floor()):
		$AnimatedSprite2D.animation = "idle"
	
	$AnimatedSprite2D.play()


	move_and_slide()
	print(enemyIn)



func placeExperimentObject(index):
	if inventory[index] == 1:
		if index != 2:
			placeExperiment.emit(index, $RayCast2D.get_collision_point())
		else:
			placeExperiment.emit(index, global_position)
			
		inventory[index] = 0
	



func _input(event: InputEvent) -> void:
	if len($experimentDetector.get_overlapping_areas()) == 0 and is_on_floor():
		if Input.is_action_just_pressed("select1"):
			placeExperimentObject(0)
		elif Input.is_action_just_pressed("select2"):
			placeExperimentObject(1)
		elif Input.is_action_just_pressed("select3"):
			placeExperimentObject(2)

'''
func _on_show_info_body_entered(body: Node2D) -> void:
	print("Running check")
	if body==self:
		print("Check success")
		showInfo.emit()


func _on_show_info_body_exited(body: Node2D) -> void:
	if body == self:
		hideInfo.emit()
'''


func _on_iframes_timeout() -> void:
	if enemyIn:
		damage.emit()
		$iframes.start()


func _on_experiment_detector_body_entered(body: Node2D) -> void:
	print(body.get_groups())
	if "evil" in body.get_groups():
		enemyIn = true
		damage.emit()
		$iframes.start()


func _on_experiment_detector_body_exited(body: Node2D) -> void:
	if "evil" in body.get_groups():
		enemyIn = false
