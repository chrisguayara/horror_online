extends CharacterBody3D

var states: Array = ["stalking", "hunting", "hurt", "entry"]

var health = 200
var visitedEntries = {}
@export var axe : Node3D
var speed = 10
var isRunning = false
var isDead = false

func _ready():
	pass

func _physics_process(delta):
	pass
