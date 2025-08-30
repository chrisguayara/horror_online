extends Node3D

@export var alarm_node: AudioStreamPlayer
var interactable_sounds = {}

func _ready():
	interactable_sounds = {
		"alarmclock": alarm_node
	}



func _on_alarmclock_playsound(str):
	if interactable_sounds.has(str):
		interactable_sounds[str].play()
	else:
		print("not a song")
