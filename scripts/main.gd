extends Node3D

@onready var player = $SubViewport/player  # adjust path
@onready var settings_menu = $UILayers/SettingsMenu
var menu_active = false

func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()
	if event.is_action_pressed("fullscreen"):
		toggle_fullscreen()
	if event.is_action_pressed("settings"):
		settings_menu.toggle()

	
	if not player.head.settingsOn and event is InputEventMouseMotion:
		player.head._input(event)
	


func toggle_fullscreen():
	var mode := DisplayServer.window_get_mode()
	if mode == DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_WINDOWED)
	elif mode == DisplayServer.WindowMode.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN)
		
