extends CharacterBody3D

@export var speed := 4.2
@export var jump_velocity := 1.5
@export var gravity := 9.8
var canMove = true
@onready var interact_ray = $head/camera/InteractRay
@onready var head = $head
var mode = "idle"
@onready var inventorymanager = $inventory



func _physics_process(delta: float) -> void:
	
	
	if Input.is_action_just_pressed("interact"):
		if interact_ray.is_colliding():
			var body = interact_ray.get_collider()
			
			var target = body
			while target and not (target is Interactable):
				target = target.get_parent()

			if target and target is Interactable:
				target.interact(self)


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

		
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_velocity

		move_and_slide()
		
		
func add_to_inventory(item):
	
	return inventorymanager.add_to_inventory(item)

func pcEnter():
	mode = "surfing"
	canMove = false
	head.canLook = false
	

func pcExit():
	canMove = true
