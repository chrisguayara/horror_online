extends RayCast3D


@onready var prompt = $Prompt




func _process(delta):
	prompt.text = ""
	if is_colliding():
		var collider = get_collider()
		
		if collider is Interactable:
			
			prompt.text = collider.prompt_msg
			if Input.is_action_just_pressed("interact"):
				collider.interact(owner)
				#var p = get_tree().current_scene.get_node("Main/Player")
				#collider.interact(p)
				#print("working ")
		
