extends CollisionObject3D


class_name Interactable

signal interacted(body)
@export var prompt_msg = "Interact"

func interact(body):
	print("yo")
	interacted.emit(body)
