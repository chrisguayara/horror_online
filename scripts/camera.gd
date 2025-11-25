extends Node3D

@export var mouse_sensitivity := 0.002
var default = 0.002
var scopedSens = default * .50
var pitch := 0.0
var canLook = true
var settingsOn = false
@onready var camera: Camera3D = $camera

func _ready():
	camera.current = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if not canLook or settingsOn:
		return
	if event is InputEventMouseMotion:
		get_parent().rotate_y(-event.relative.x * mouse_sensitivity)
		pitch -= event.relative.y * mouse_sensitivity
		pitch = clamp(pitch, deg_to_rad(-89), deg_to_rad(89))
		rotation.x = pitch

func settingsToggle() -> void:
	settingsOn = not settingsOn
	Input.set_mouse_mode(
		Input.MOUSE_MODE_VISIBLE if settingsOn else Input.MOUSE_MODE_CAPTURED
	)

func set_sensitivity(value: float) -> void:
	mouse_sensitivity = value

func scoped(isScoped: bool):
	if not isScoped:
		mouse_sensitivity = default
		camera.fov = 75.0
		return
	mouse_sensitivity = scopedSens
	camera.fov = 55.0
