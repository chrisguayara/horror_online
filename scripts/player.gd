extends CharacterBody3D

@export var speed := 4.2
@export var jump_velocity := 2.5
@export var gravity := 9.8
var canMove = true
@onready var interact_ray = $head/camera/InteractRay
@onready var head = $head
var mode = "idle"
@onready var inventorymanager = $inventory
@export var floor_marker : Marker3D

var prevLocation : Vector3


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
	else:
		velocity.y = 0

	if canMove:
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
		
	if Input.is_action_just_pressed("shoot"):
		if inventorymanager.current_item and inventorymanager.current_item.has_method("shoot"):
			inventorymanager.current_item.shoot()
	if Input.is_action_just_pressed("reload"):
		if inventorymanager.current_item and inventorymanager.current_item.has_method("reload"):
			inventorymanager.current_item.reload()
	
	move_and_slide()


func add_to_inventory(item):
	return inventorymanager.add_to_inventory(item)


func pcEnter():
	mode = "surfing"
	canMove = false
	head.canLook = false
	prevLocation = global_position
	var fmPos = floor_marker.global_position
	global_position = global_position.lerp(fmPos, 0.5)

func pcExit():
	mode = "idle"
	canMove = true
	head.canLook = true
	global_position = global_position.lerp(prevLocation, 0.5)
