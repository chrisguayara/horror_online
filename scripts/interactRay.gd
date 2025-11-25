extends RayCast3D



var gunActive = true

@export var label : Label

var dmg = 45
func _process(delta):
	if not gunActive: return
	
	if is_colliding():
		#label.text = "Colliding"
		var collider = get_collider()
		if collider is Interactable:
			if Input.is_action_just_pressed("interact"):
				collider.interact()
				print("SHOTTTT")
				
		
