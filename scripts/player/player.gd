extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
signal placeExperiment(object, point)
@export var playerHeight = 128
var inventory = [1,1,1]
signal damage
var enemyIn = false
var alive = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if velocity.y>=0 and alive:
			$AnimatedSprite2D.animation = "fall"
			$AnimatedSprite2D.play()
	if Input.is_action_pressed("moveLeft") and is_on_floor() and alive:
		$AnimatedSprite2D.flip_h = true
		if is_on_floor():
			$AnimatedSprite2D.animation = "run"
			$AnimatedSprite2D.play()
	if Input.is_action_pressed("moveRight") and is_on_floor() and alive:
		$AnimatedSprite2D.flip_h = false
		if is_on_floor():
			$AnimatedSprite2D.animation = "run"
			$AnimatedSprite2D.play()
	# Handle jump.
	if Input.is_action_just_pressed("moveJump") and is_on_floor() and alive:
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.animation = "jump"
		$AnimatedSprite2D.play()
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("moveLeft", "moveRight")
	if direction and alive:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if is_on_floor() and alive and not(Input.is_action_pressed("moveLeft") or Input.is_action_pressed("moveRight") or Input.is_action_pressed("moveJump")):
		$AnimatedSprite2D.animation = "idle"
		$AnimatedSprite2D.play()
			

	move_and_slide()



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


func _on_ui_oxygen_lost() -> void:
	$AnimatedSprite2D.animation = "death"
	$AnimatedSprite2D.play()
	alive = false
	
