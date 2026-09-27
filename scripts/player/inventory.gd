extends Node

signal inventory_updated
signal selected_item_changed

const MAX_WEAPONS := 3

var weapons: Array[Node3D] = []
var selected_index := -1

func add_weapon(weapon: Node3D) -> bool:
	if weapons.size() >= MAX_WEAPONS:
		return false
	weapons.append(weapon)
	weapon.visible = false
	if selected_index == -1:
		select_weapon(0)
	inventory_updated.emit()
	return true

func select_weapon(index: int) -> void:
	if index < 0 or index >= weapons.size():
		return
	if selected_index != -1:
		weapons[selected_index].visible = false
	selected_index = index
	weapons[selected_index].visible = true
	selected_item_changed.emit()

func get_selected_weapon() -> Node3D:
	return weapons[selected_index] if selected_index != -1 else null
