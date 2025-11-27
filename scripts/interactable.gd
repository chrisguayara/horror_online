extends Node3D
class_name Interactable

signal interacted(body)
@export var prompt_msg := "Interact"
@export var active := true   # ADD THIS

func interact(body):
	print("yo")
	interacted.emit(body)
