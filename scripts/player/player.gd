extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
signal placeExperiment(object, point)
@export var playerHeight = 128
var inventory = [1,1,1]

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("moveJump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("moveLeft", "moveRight")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


	print($experimentDetector.get_overlapping_areas())


	move_and_slide()



func placeExperimentObject(index):
	if inventory[index] == 1:
		if index != 2:
			placeExperiment.emit(index, $RayCast2D.get_collision_point())
		else:
			placeExperiment.emit(index, global_position)
			
		inventory[index] = 0
	



func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("select1") and len($experimentDetector.get_overlapping_areas()) == 0:
		placeExperimentObject(0)
	elif Input.is_action_just_pressed("select2") and len($experimentDetector.get_overlapping_areas()) == 0:
		placeExperimentObject(1)
	elif Input.is_action_just_pressed("select3") and len($experimentDetector.get_overlapping_areas()) == 0:
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
