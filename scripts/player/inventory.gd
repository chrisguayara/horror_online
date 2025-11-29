extends Node3D

@onready var main_inventory: Array = []
var inventory_space = 5
var itemAmount = 0
signal addSound
signal activeInHand
signal inventory_updated

@onready var hand = $"../head/camera/hand"
@onready var quantity_label = $"../quantitylabel"
var current_item: Node3D = null
var handIsShowing = true

func hideHand():
	if handIsShowing:
		hand.visible = false
		handIsShowing = false

func checkActive():
	if current_item and current_item.is_inside_tree():
		if current_item.name == "HuntingRifle": 
			for inv_item in main_inventory:
				if inv_item.name == "Hunting Rifle":
					inv_item.curr_loaded = current_item.loadedBullets
					inv_item.curr_stock = current_item.stock
					break
		current_item.get_parent().remove_child(current_item)
		current_item.queue_free()
		current_item = null
	
	# Hide quantity label when no item or switching
	hide_quantity_label()

	if main_inventory.size() == 0:
		return

	var first_item = main_inventory[0]
	
	if "scene" in first_item and first_item.scene:
		current_item = first_item.scene.instantiate()
		hand.add_child(current_item)
		current_item.transform = Transform3D()
		
		if first_item.name == "Hunting Rifle":
			if "curr_loaded" in first_item:
				current_item.loadedBullets = first_item.curr_loaded
			if "curr_stock" in first_item:
				current_item.stock = first_item.curr_stock
			
			if current_item.has_signal("scope_toggled"):
				current_item.scope_toggled.connect(get_parent()._on_rifle_scope_toggled)
		
		# Show quantity for stackable items (not weapons)
		update_quantity_label(first_item)

func update_quantity_label(item: Dictionary):
	if quantity_label:
		# Show quantity for consumables/stackable items, but not for weapons
		if item.name != "Hunting Rifle" and item.get("quantity", 1) > 1:
			quantity_label.text = str(item.quantity)
			quantity_label.visible = true
		else:
			hide_quantity_label()

func hide_quantity_label():
	if quantity_label:
		quantity_label.visible = false

func add_to_inventory(item: Dictionary) -> bool:
	for inv_item in main_inventory:
		if "name" in inv_item and inv_item.name == item.name:
			if inv_item.name == "Hunting Rifle":
				inv_item.curr_stock = inv_item.get("curr_stock", 0) + item.get("curr_stock", 10)
			else:
				inv_item.quantity = inv_item.get("quantity", 1) + item.get("quantity", 1)
			
			# Update quantity label if this item is currently equipped
			if current_item and main_inventory.size() > 0 and main_inventory[0].name == item.name:
				update_quantity_label(inv_item)
			
			emit_signal("addSound", item.get("pickup", "inventoryDef"))
			checkActive()
			emit_signal("inventory_updated")
			return true

	if itemAmount >= inventory_space:
		emit_signal("addSound", "inventoryFull")
		return false

	if item.name == "Hunting Rifle":
		main_inventory.insert(0, item)
	else:
		main_inventory.append(item)

	itemAmount += 1
	checkActive()
	emit_signal("addSound", item.get("pickup", "inventoryDef"))
	emit_signal("inventory_updated")
	return true

func remove_item(item: Dictionary) -> void:
	if item in main_inventory:
		main_inventory.erase(item)
		itemAmount -= 1
		checkActive()
		emit_signal("inventory_updated")

func activate_item(item: Dictionary) -> void:
	if item in main_inventory:
		print("Activating item:", item.name)

func update_rifle_ammo(loaded: int, stock: int):
	for inv_item in main_inventory:
		if inv_item.name == "Hunting Rifle" and inv_item == main_inventory[0]:
			inv_item.curr_loaded = loaded
			inv_item.curr_stock = stock
			break
