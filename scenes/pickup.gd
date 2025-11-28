extends Interactable

@export var item_name: String
@export var item_description: String
@export var item_scene: PackedScene
@export var item_pickup: String = "inventoryDef"
@export var item_amount: int = 1
var canSpin = true

func _ready():
	prompt_msg = "Pick Up [E]"

func interact(body):
	var item_data = {
		"name": item_name,
		"description": item_description,
		"scene": item_scene,
		"pickup": item_pickup,
		"quantity" : item_amount
	}
	if item_name == "Hunting Rifle":
		item_data["curr_loaded"] = 0
		item_data["curr_stock"] = 10
	
	if body.add_to_inventory(item_data):
		print("Picked up: ", item_name)
		queue_free()
	else:
		print("Inventory full")


	
	
