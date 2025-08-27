extends Interactable

signal playsound(str: String)
var id = name

func interact(user):
	emit_signal("playsound", id)
