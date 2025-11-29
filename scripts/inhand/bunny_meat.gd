extends Node3D
@onready var countLabel = $Label

var bunnyinhand = false

func toggleLabel():
	countLabel.visible = bunnyinhand

func set_quantity(quantity: int):
	countLabel.text = str(quantity)
