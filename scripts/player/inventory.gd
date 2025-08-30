extends Node3D

@onready var main_inventory: Array = []
var inventory_space = 5
var itemAmount = 0

func add_to_inventory(item: Dictionary):
	if itemAmount < inventory_space:
		main_inventory.append(item)
		return true
	return false

func remove_item(item) : 
	if item in main_inventory:
		main_inventory.erase(item)
