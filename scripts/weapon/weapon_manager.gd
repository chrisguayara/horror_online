extends Node3D

@onready var inventory = $inventory
@export var first_weapon : PackedScene

var current_weapon: Weapon
func _ready():
	inventory.selected_item_changed.connect(_on_selected_changed)
	if first_weapon:
		equip_new(first_weapon)

func equip_new(weapon : PackedScene) -> void:
	var gun = weapon.instantiate()
	add_child(gun)
	inventory.add_weapon(gun)

func _on_selected_changed():
	if current_weapon:
		current_weapon.visible = false
	current_weapon = inventory.get_selected_weapon()
	if current_weapon:
		current_weapon.viisble = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		pass

func _unhandled_input(event):
	if event.is_action_pressed("shoot") and current_weapon:
		current_weapon.fire()
