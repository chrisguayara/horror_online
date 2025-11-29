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

	if canInput:
		if Input.is_action_just_pressed("shoot") and inventorymanager.current_item:
			inventorymanager.current_item.shoot()
		if Input.is_action_just_pressed("reload") and inventorymanager.current_item:
			inventorymanager.current_item.reload()
		if Input.is_action_just_pressed("scope") and inventorymanager.current_item:
			if inventorymanager.current_item.has_method("toggle_scope"):
				inventorymanager.current_item.toggle_scope()
		for i in range(1, 6):  # Numbers 1-5
			if Input.is_action_just_pressed("slot_" + str(i)):
				switch_to_slot(i - 1)  # Convert to 0-based index

	move_and_slide()

func switch_to_slot(slot_index: int):
	if slot_index < inventorymanager.main_inventory.size():
		# Move the selected item to the front
		var item = inventorymanager.main_inventory[slot_index]
		inventorymanager.main_inventory.erase(item)
		inventorymanager.main_inventory.insert(0, item)
		inventorymanager.checkActive()
		print("Switched to slot ", slot_index + 1, ": ", item.name)

func _on_rifle_scope_toggled(is_scoped: bool):
	self.is_scoped = is_scoped
	head.set_scope_state(is_scoped)
	var ui_layers = get_node("head/camera/UILayers")
	if ui_layers and ui_layers.has_method("set_scope_overlay"):
		ui_layers.set_scope_overlay(is_scoped)
func add_to_inventory(item):
	return inventorymanager.add_to_inventory(item)

func toggleInput():
	canInput = !canInput
	head.setCanLook(canInput)

func toggle_crt_effect():
	if crtOn:
		
		crtOn = false
