extends Interactable
class_name PhoneInteractable

var can_answer := false

func _ready():
	EventManager.phone_interactable = self


func interact(body):
	if !can_answer:
		return
	EventManager.answer_current_call()
