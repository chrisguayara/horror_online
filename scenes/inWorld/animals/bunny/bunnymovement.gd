extends Node3D
class_name MovementManager

@export var move_speed: float = 2.0
@export var turn_interval: float = 1.2
@export var alert_speed: float = 10.0

var state: String = "idle" # idle, moving, alert
var timer: float = 0.0
var move_direction: Vector3 = Vector3.ZERO
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	timer = turn_interval
	state = "idle"

func _physics_process(delta):
	var enemy = get_parent() as Enemy
	if not enemy or enemy.state == "dead":
		print("Justdead")
		return
	
	timer -= delta
	if timer <= 0:
		move_direction = Vector3(rng.randf_range(-1,1), 0, rng.randf_range(-1,1)).normalized()
		timer = turn_interval
		state = "idle" if rng.randi_range(0,1) == 0 else "moving"

	# Apply gravity
	enemy.velocity.y += -9.8 * delta

	match state:
		"idle":
			pass
		"moving":
			move(enemy, move_direction, move_speed, delta)
			print("Moved!")
		"alert":
			move(enemy, move_direction, alert_speed, delta)
			print("Alert!")

func move(enemy: Enemy, direction: Vector3, speed: float, delta: float):
	if direction == Vector3.ZERO:
		return
	enemy.look_at(enemy.global_transform.origin + direction, Vector3.UP)
	var velocity = direction * speed
	velocity.y = enemy.velocity.y
	enemy.velocity = velocity
	enemy.move_and_slide()
