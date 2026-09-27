extends RayCast3D

@onready var prompt = $Prompt

func _ready():
	enabled = true
	prompt.visible = false

func _process(delta):
	if is_colliding():
		var collider = get_collider()

		if collider is Interactable:
			prompt.visible = true
			prompt.text = collider.prompt_msg

			if Input.is_action_just_pressed("interact"):
				var player = get_tree().get_first_node_in_group("player")
				collider.interact(player)
		else:
			prompt.visible = false  # colliding, but not an Interactable
	else:
		prompt.visible = false    # not colliding at all
		prompt.text = ""
