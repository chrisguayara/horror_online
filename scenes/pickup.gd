extends Interactable

@export var item_name: String
@export var item_description: String
@export var item_scene: PackedScene
@export var item_pickup: String = ""

var canSpin = true

func _ready():
	prompt_msg = "Pick Up [E]"

func interact(body):
	var item_data = {
		"name": item_name,
		"description": item_description,
		"scene": item_scene,
		"pickup": item_pickup
	}
	
	if body.add_to_inventory(item_data):
		print("Picked up: ", item_name)
		queue_free()
	else:
		print("Inventory full")


	
	
