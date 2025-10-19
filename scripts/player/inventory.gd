extends Node3D

@onready var main_inventory: Array = []
var inventory_space = 5
var itemAmount = 0
signal addSound
signal activeInHand
@onready var hand = $"../head/camera/hand"

func checkActive():
	if main_inventory:
		var activeHandItem = main_inventory[0]
		emit_signal("activeInHand",main_inventory[0])
		#this makes it so that the first item in inventory will always be the in hand item. 


func add_to_inventory(item: Dictionary):
	
		
	if itemAmount < inventory_space:
		main_inventory.append(item)
		emit_signal("addSound", "inventory")
		return true
	return false

func remove_item(item) : 
	if item in main_inventory:
		main_inventory.erase(item)
