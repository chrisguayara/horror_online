extends Node3D

@onready var player = $SubViewportContainer/SubViewport/player
@onready var ui_layers = $SubViewportContainer/SubViewport/player/head/camera/UILayers
@onready var escape = $SubViewportContainer/SubViewport/player/head/camera/UILayers/Escape
@onready var inventory_menu = $SubViewportContainer/SubViewport/player/head/camera/UILayers/InventoryMenu
var inInventory = false
@onready var crteffect = $CRT
var crtOn = true
@onready var logoIntro = $AboveUI
@onready var soundmanager = $SubViewportContainer/SubViewport/Soundmanager
var isInMenu = false
var isInLogo = true
var SKIP_INTRO = true

func _ready():
	if SKIP_INTRO:
		skip_intro_scene()
	else: 
		intro_scene()

func intro_scene():
	crteffect.visible = true
	logoIntro.pre()
	soundmanager.startup()
	player.canInput = false
	
func skip_intro_scene():
	isInLogo = false
	isInMenu = false
	crteffect.visible = true
	logoIntro.visible = false
	player.canInput = true
	endmmsounds()

func mmscreen():
	isInLogo = false
	soundmanager.loopIntro()
	logoIntro.playmm()
	isInMenu = true
func endmmsounds():
	soundmanager.endmm()

func _process(delta):
	if isInMenu:
		if Input.is_action_just_pressed("interact"):
			
			logoIntro.endmm()
			endmmsounds()
			player.canInput = true
			isInMenu = false

	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("fullscreen"):
		toggle_fullscreen()
	if Input.is_action_just_pressed("settings"):
		var menu_visible = escape.toggleVisibility()
		player.toggleInput()
		if menu_visible:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Input.is_action_just_pressed("inventory"):
		if ui_layers.can_open_inventory():
			inInventory = not inInventory
			inventory_menu.visible = inInventory
			if inInventory:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				player.canInput = false  # Add this
			else:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				player.canInput = true   # Add this
		else:
			print("Cannot open inventory while scoped")



func _input(event):
	if event is InputEventMouseMotion and player.canInput and not isInMenu or isInLogo:
		player.head._input(event)

func toggle_fullscreen():
	var mode := DisplayServer.window_get_mode()
	if mode == DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_WINDOWED)
	elif mode == DisplayServer.WindowMode.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN)

func toggleCRT():
	if crtOn:
		crteffect.visible = false
		crtOn = false
	else:
		crteffect.visible = true
		crtOn = true
