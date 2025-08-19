extends CharacterBody3D

@export var speed := 5.0
@export var jump_velocity := 5.5
@export var gravity := 9.8
var canMove = true

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if canMove:
		
		var input_dir := Vector2.ZERO
		input_dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		input_dir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
		input_dir = input_dir.normalized()

		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed

		# Jump
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_velocity

		move_and_slide()
func _on_pc_used():
	canMove = false

func exit_pc():
	canMove = true
	
