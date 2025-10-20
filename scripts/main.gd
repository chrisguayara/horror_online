extends Node3D


func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()
	elif event.is_action_pressed("fullscreen"):
		toggle_fullscreen()

func toggle_fullscreen():
	var mode := DisplayServer.window_get_mode()
	if mode == DisplayServer.WindowMode.
