extends Node

@onready var phone_ring = $phone_ring
@onready var phone_call_one = $call1
@onready var phone_call_two = $call2

var calls_answered := 0
var phone_interactable = null
var phone_ringing := false

func start_first_call():
	phone_ringing = true
	phone_ring.play()
	
	if phone_interactable:
		phone_interactable.can_answer = true

func answer_current_call():
	if !phone_ringing:
		return

	phone_ringing = false
	phone_ring.stop()

	if phone_interactable:
		phone_interactable.can_answer = false

	match calls_answered:
		0:
			answer_call_one()
		1:
			answer_call_two()

func answer_call_one():
	phone_call_one.play()
	calls_answered += 1

func answer_call_two():
	phone_call_two.play()
	calls_answered += 1
