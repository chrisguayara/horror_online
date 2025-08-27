extends Node3D


var interactable_sounds = {
	"alarmclock" : $alarm
}

func _on_alarmclock_playsound(str):
	$alarm.playing
