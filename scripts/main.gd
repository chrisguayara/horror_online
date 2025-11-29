extends Node3D

@onready var player = $SubViewport/player  # adjust path
@onready var ui_layers = $SubViewport/player/head/camera/UILayers
@onready var escape = $SubViewport/player/head/camera/UILayers/Escape
@onready var inventory_menu = $SubViewport/player/head/camera/UILayers/InventoryMenu
var inInventory = false
var menu_active = false

func _ready():
	pass


	
func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("fullscreen"):
		toggle_fullscreen()
	if Input.is_action_just_pressed("settings"):
		escape.toggleVisibility()
		player.toggleInput()
	if Input.is_action_just_pressed("inventory"):
		
		if ui_layers.can_open_inventory():
			if inInventory:
				inInventory = false
			else: 
				inInventory = true
			inventory_menu.visible = inInventory
		else:
			# Optional: Play a sound or show message that inventory can't be opened while scoped
			print("Cannot open inventory while scoped")


func _input(event):
	if event is InputEventMouseMotion and player.canInput:
		player.head._input(event)

func toggle_fullscreen():
	var mode := DisplayServer.window_get_mode()
	if mode == DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_WINDOWED)
	elif mode == DisplayServer.WindowMode.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN)
		
