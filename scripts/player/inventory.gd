extends Node

signal inventory_updated
signal selected_item_changed
signal inventory_toggled(is_open)

const MAX_ITEMS := 3

var items: Array = []
var selected_index := -1
var inventory_open := false


func add_to_inventory(item: Dictionary) -> bool:
	if items.size() >= MAX_ITEMS:
		print("Inventory Full")
		return false

	items.append(item)

	if selected_index == -1:
		selected_index = 0

	inventory_updated.emit()
	selected_item_changed.emit()
	return true


func remove_item(item: Dictionary) -> void:
	if item in items:
		var removed_index = items.find(item)
		items.erase(item)

		if items.is_empty():
			selected_index = -1
		elif selected_index >= items.size():
			selected_index = items.size() - 1

		inventory_updated.emit()
		selected_item_changed.emit()


func toggle_inventory():
	inventory_open = !inventory_open
	inventory_toggled.emit(inventory_open)


func open_inventory():
	inventory_open = true
	inventory_toggled.emit(true)


func close_inventory():
	inventory_open = false
	inventory_toggled.emit(false)


func select_item(index: int):
	if index >= 0 and index < items.size():
		selected_index = index
		selected_item_changed.emit()


func get_selected_item():
	if selected_index == -1:
		return null
	return items[selected_index]


func get_items():
	return items
