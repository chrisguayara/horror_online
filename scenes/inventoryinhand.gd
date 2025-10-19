extends Marker3D

var inInventory = false
var inventory = {}
@export var remington : Node3D


func _on_inventory_active_in_hand(firstItem:String ):
	#check dictionary for dict[firstItem]
	var curr = ""
	for item in inventory:
		item.hide
	inventory[firstItem] = show()
	
	##fix code this is just pseudo
	
