extends Node3D

@export var alarm_node: AudioStreamPlayer
@export var inventory_node: AudioStreamPlayer
var interactable_sounds = {}

func _ready():
	interactable_sounds = {
		"alarmclock": alarm_node,
		"inventory" : inventory_node
	}



func _on_alarmclock_playsound(str: String):
	if interactable_sounds.has(str):
		interactable_sounds[str].play()
	else:
		print("not a song")


func _on_inventory_add_sound(str: String):
	if interactable_sounds.has(str):
		interactable_sounds[str].pitch_scale = randf_range(0.97,1.03)
		interactable_sounds[str].play()
	else:
		print("not a song")
