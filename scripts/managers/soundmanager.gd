extends Node3D


var interactable_sounds = {}

func _ready():
	interactable_sounds = {
		"alarmclock": $alarm
	}



func _on_alarmclock_playsound(str):
	if interactable_sounds.has(str):
		interactable_sounds[str].play()
	else:
		print("not a song")
