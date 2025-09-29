extends CharacterBody3D

var states: Dictionary = {
	"stalking": _stalking_state,
	"hunting": _hunting_state,
	"hurt": _hurt_state,
	"entry": _entry_state
}

var currentstate: String = "stalking"

var health = 200
var visitedEntries = {}
@export var axe : Node3D
var speed = 10
var isRunning = false
var isDead = false
var charactername: String = "breach"

func _physics_process(delta):
	
	states[currentstate].call(delta)
	





#state logic !

func _stalking_state(delta):
	pass

func _hunting_state(delta):
	pass
	

func _hurt_state(delta):
	pass

func _entry_state(delta):
	pass
	
