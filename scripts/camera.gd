extends Node3D

@export var mouse_sensitivity := 0.002
var pitch := 0.0  # Up/down rotation
var canLook = true
var using_pc = false

var isMovng = false
var speed = 5.0
@onready var camera: Camera3D = $camera



func _ready():
	if not camera:
		push_warning("Camera not assigned in inspector!")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event: InputEvent) -> void:
	if canLook:
		
		if event is InputEventMouseMotion:
			# Yaw rotates the player body (left/right)
			get_parent().rotate_y(-event.relative.x * mouse_sensitivity)

			# Pitch rotates only the head (up/down)
			pitch -= event.relative.y * mouse_sensitivity
			pitch = clamp(pitch, deg_to_rad(-89), deg_to_rad(89))
			rotation.x = pitch


func _on_pc_transition(pos: Vector3, rota: Vector3):
	var target = Vector3(pos[0], pos[1], pos[2])
	
	isMovng = true
	
	camera.global_position = camera.global_position.lerp(pos, 0.3)
	camera.global_rotation = camera.global_rotation.lerp(rota, 0.3)
