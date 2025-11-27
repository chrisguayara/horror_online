extends Node3D
class_name DuckMovement

@export var center: Vector3 = Vector3.ZERO
@export var radius: float = 5.0
@export var move_speed: float = 2.0
@export var height: float = 2.0
@export var variation: float = 0.5
@export var figure8_speed: float = 1.0

var rng = RandomNumberGenerator.new()
var angle: float = 0.0

func _ready():
	rng.randomize()
	center = get_parent().global_transform.origin

func _physics_process(delta):
	var enemy = get_parent() as Enemy
	if not enemy or enemy.state == "dead":
		return

	
	angle += figure8_speed * delta
	if angle > PI * 2:
		angle -= PI * 2

	
	var x = sin(angle) * radius
	var z = sin(angle * 2) * radius * 0.5
	var clean_pos = center + Vector3(x, height, z)

	
	var target_pos = clean_pos + Vector3(0, rng.randf_range(-variation, variation), 0)

	
	enemy.global_transform.origin = target_pos

	
	var look_dir = (clean_pos - enemy.global_transform.origin).normalized()
	
