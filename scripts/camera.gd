extends Node3D

@export var default_sensitivity := 0.002
var scoped_sensitivity := default_sensitivity * 0.5
var current_sensitivity := default_sensitivity

var pitch := 0.0
var canLook := true

@onready var camera: Camera3D = $camera

func _ready():
	camera.current = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and canLook:
		get_parent().rotate_y(-event.relative.x * current_sensitivity)
		pitch -= event.relative.y * current_sensitivity
		pitch = clamp(pitch, deg_to_rad(-89), deg_to_rad(89))
		rotation.x = pitch

func setCanLook(enabled: bool):
	canLook = enabled
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if enabled else Input.MOUSE_MODE_VISIBLE)

func scoped(isScoped: bool):
	if isScoped:
		current_sensitivity = scoped_sensitivity
		camera.fov = 55.0
	else:
		current_sensitivity = default_sensitivity
		camera.fov = 75.0
