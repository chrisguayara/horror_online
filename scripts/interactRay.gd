extends RayCast3D

@onready var prompt = get_tree().root.get_node("Main/SubViewport/player/head/camera/Label")

func _process(delta):
	prompt.text = ""

	if !is_colliding():
		return

	var hit = get_collider()
	var interactable = _get_interactable(hit)

	if interactable and interactable.active:
		prompt.text = interactable.prompt_msg

		if Input.is_action_just_pressed("interact"):
			interactable.interact(self)


func _get_interactable(node):
	while node:
		if node is Interactable:
			return node
		node = node.get_parent()
	return null
