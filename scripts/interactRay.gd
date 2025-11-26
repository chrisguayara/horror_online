extends RayCast3D


@onready var prompt = get_tree().root.get_node("Main/SubViewport/player/head/camera/Label")




func _process(delta):
	prompt.text = ""
	if is_colliding():
		var collider = get_collider()
		
		if collider is Interactable:
			
			prompt.text = collider.prompt_msg
			if Input.is_action_just_pressed("interact"):

				collider.prompt_msg = ""

		
