extends Control
#
#@export var inventory: Array = [] # Array of dictionaries {name: String, quantity: int}
#@onready var item_list = $Panel/VBoxContainer
#@onready var cursor = $Panel/Cursor
#
#var selected_index: int = 0
#
#func _ready():
	#refresh_inventory()
	#update_cursor()
#
#func _unhandled_input(event):
	#if event.is_action_pressed("down"):
		#selected_index = min(selected_index + 1, inventory.size() - 1)
		#update_cursor()
	#elif event.is_action_pressed("up"):
		#selected_index = max(selected_index - 1, 0)
		#update_cursor()
	#elif event.is_action_pressed("interact"):
		#select_item()
	#elif event.is_action_pressed("ui_cancel"):
		#hide_inventory()
#
#func refresh_inventory():
	#item_list.clear()
	#for item in inventory:
		#var lbl = Label.new()
		#lbl.text = "%s x%d" % [item.name, item.quantity]
		#lbl.add_theme_color_override("font_color", Color.WHITE)
		#item_list.add_child(lbl)
#
#func update_cursor():
	#if inventory.size() == 0:
		#cursor.visible = false
		#return
	#cursor.visible = true
	#var slot = item_list.get_child(selected_index)
	#cursor.global_position = slot.global_position
#
#func select_item():
	#if inventory.size() == 0:
		#return
	#var item = inventory[selected_index]
	#print("Selected item: %s" % item.name)
	## Here you can trigger a popup: Use / Equip / Drop
#
#func hide_inventory():
	#visible = false
	#
