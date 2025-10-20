extends Marker3D

@onready var hand = self
var current_item: Node3D = null
@export var inventory_node: Node


func _on_inventory_active_in_hand():
	if current_item:
		current_item.queue_free()
		current_item = null
	if not inventory_node.main_inventory or inventory_node.main_inventory.empty():
		return
	var first_item = inventory_node.main_inventory[0]
	if first_item.has("scene") and first_item["scene"]:
		current_item = first_item["scene"].instantiate()
		hand.add_child(current_item)
		current_item.transform = Transform3D()
	else:
		push_warning("First item in inventory has no scene assigned.")
