extends CharacterBody3D

var states: Dictionary = {
	"stalking": _stalking_state,
	"hunting": _hunting_state,
	"hurt": _hurt_state,
	"entry": _entry_state
}

var currentstate: String = "hunting"

var health = 200
var visitedEntries = {}
@export var axe: Node3D
@export var player: Node3D
var speed = 1.2
var isRunning = false
var isDead = false
var charactername: String = "breach"
var aggresiveness = 1.0
var fear = 1.0
var characteristics = [aggresiveness, fear]
var update_ready = false
@onready var timer = $Timer

func _ready():
	timer.wait_time = 2.0
	timer.timeout.connect(_on_Timer_timeout)
	timer.start()
	speed = 2 * characteristics[0]

func _physics_process(delta):
	if update_ready:
		_timed_update()
		update_ready = false
	states[currentstate].call(delta)

func _timed_update():
	
	var timed_method = currentstate + "_timed_update"
	if has_method(timed_method):
		call(timed_method)

func _stalking_state(delta):
	characteristics[0] = 1.02
	pass

func _hunting_state(delta):
	characteristics[0] = 1.2
	if player:
		var direction = (player.global_transform.origin - global_transform.origin).normalized()
		velocity = direction * speed
		move_and_slide()
	pass

func _hurt_state(delta):
	characteristics[0] = 1.4
	characteristics[1] = 1.7
	
	pass

func _entry_state(delta):
	characteristics[0]=1.02
	pass






func _on_Timer_timeout():
	update_ready = true
