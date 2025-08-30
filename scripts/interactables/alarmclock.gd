extends Interactable

signal playsound(str: String)

var id = "alarmclock"

func interact(user):
	emit_signal("playsound", id)
