extends Node3D

@onready var main_inventory: Array = []
var inventory_space = 5
var itemAmount = 0
signal addSound
signal activeInHand
@onready var hand = $"../head/camera/hand"
var current_item: Node3D = null

func checkActive():
	if current_item and current_item.is_inside_tree():
		current_item.get_parent().remove_child(current_item)
		current_item.queue_free()
		current_item = null
	if main_inventory.size() == 0:
		return
	var first_item = main_inventory[0]
	if first_item.has("scene") and first_item["scene"]:
		current_item = first_item["scene"].instantiate()
		hand.add_child(current_item)
		current_item.transform = Transform3D()

func add_to_inventory(item: Dictionary) -> bool:
	if itemAmount < inventory_space:
		main_inventory.insert(0, item)
		itemAmount += 1
		emit_signal("addSound", "inventory")
		checkActive()
		return true
	return false

func remove_item(item: Dictionary) -> void:
	if item in main_inventory:
		main_inventory.erase(item)
		itemAmount -= 1
		checkActive()
