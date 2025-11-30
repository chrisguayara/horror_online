extends Control

@onready var cursor = $Panel/Cursor
@onready var player_inventory = $"../../../../inventory"
@onready var soundmanager = $"../../../../../Soundmanager"
var canvas_height = -35.0 - 220.0

var selected_index: int = 0
var labels: Array[Label] = []

func _ready():
	visible = false
	player_inventory.connect("inventory_updated", Callable(self, "refresh_inventory"))
	refresh_inventory()

# REMOVE the entire _input function - let Godot handle mouse events automatically

func refresh_inventory():
	for label in labels:
		if is_instance_valid(label):
			label.queue_free()
	labels.clear()
	
	var inv = player_inventory.main_inventory
	var count = inv.size()
	if count == 0:
		return

	var start_y = -120.0
	var end_y = -35.0
	var spacing = (end_y - start_y) / max(count - 1, 1)

	for i in range(count):
		var item = inv[i]
		var lbl = Label.new()
		lbl.text = "%s x%d" % [item.name, item.quantity if "quantity" in item else 1]
		lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		lbl.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		lbl.position = Vector2(-160, start_y + i * spacing)
		lbl.size = Vector2(200, 30)
		
		if i == selected_index:
			lbl.add_theme_color_override("font_color", Color.BLACK)
		else:
			lbl.add_theme_color_override("font_color", Color.WHITE)
		
		add_child(lbl)
		labels.append(lbl)

	selected_index = clamp(selected_index, 0, count - 1)

func select_item():
	if player_inventory.main_inventory.size() == 0:
		return
	var item = player_inventory.main_inventory[selected_index]
	player_inventory.activate_item(item)

func hide_inventory():
	visible = false
