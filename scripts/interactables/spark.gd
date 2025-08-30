extends Interactable

@onready var item: Dictionary = {
	"name" : "Blank",
	"description" : "the placeholder"
	}
	
func interact(body):
	if body.add_to_inventory(item):
		print("Picked up: ", item["name"])
		queue_free() 
	else:
		print("Inventory")
	
