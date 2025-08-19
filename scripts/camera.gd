extends Node3D

@export var mouse_sensitivity := 0.002
var pitch := 0.0  # Up/down rotation

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# Yaw rotates the player body (left/right)
		get_parent().rotate_y(-event.relative.x * mouse_sensitivity)

		# Pitch rotates only the head (up/down)
		pitch -= event.relative.y * mouse_sensitivity
		pitch = clamp(pitch, deg_to_rad(-89), deg_to_rad(89))
		rotation.x = pitch
