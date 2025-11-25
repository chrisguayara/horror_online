extends CharacterBody3D

@export var health: int = 100
@export var speed: int = 5
var states = {
	"idle" : "idle",
	"alert" : "alert",
	"dead" : "dead"
}

func _physics_process(delta):
	pass
