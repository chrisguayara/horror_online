extends CharacterBody3D

@export var speed := 4.2
@export var jump_velocity := 4.5
@export var gravity := 9.8
var canMove = true
@onready var head = $head
@onready var inventorymanager = $inventory
@onready var interact_ray = $head/camera/InteractRay
@export var floor_marker : Marker3D
var canInput = true

var prevLocation : Vector3
var is_scoped = false
var mode = "idle"
var crtOn = true


func _physics_process(delta: float) -> void:
	if canInput:
		if Input.is_action_just_pressed("interact") and interact_ray.is_colliding():
			var target = interact_ray.get_collider()
			while target and not (target is Interactable):
				target = target.get_parent()
			if target and target is Interactable:
				target.interact(self)

	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0

	if canInput and canMove:
		var input_dir := Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		).normalized()
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed

		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_velocity
	else:
		velocity.x = 0
		velocity.z = 0



	move_and_slide()



func add_to_inventory(item):
	return inventorymanager.add_to_inventory(item)

func toggleInput():
	canInput = !canInput
	head.setCanLook(canInput)

func toggle_crt_effect():
	if crtOn:
		
		crtOn = false
