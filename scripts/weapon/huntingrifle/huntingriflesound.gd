extends Node3D


@onready var reload = $reload

@onready var shoot = $shoot

func play(sound: String):
	if sound == "shoot":
		shoot.play()
	elif sound == "reload":
		reload.play()
