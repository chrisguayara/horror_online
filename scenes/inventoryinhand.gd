extends Marker3D

var inInventory = false
@export var inventory : Node3D

var currentItem: Node3D = null

func _ready():
	for child in get_children():
		child.visible = false


func _on_inventory_active_in_hand(itemName:String ):
	#check dictionary for dict[firstItem]
	pass
	if currentItem:
		currentItem.visible = false
		currentItem = null
	if itemName in inventory:
		currentItem = inventory.inventory[itemName]
		currentItem.visible = true
	else:
		push_warning("Item %s' not found in inventory." % itemName)
	
