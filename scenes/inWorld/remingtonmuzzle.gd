extends Node3D
@onready var muzzle_1 = $Muzzle1
@onready var muzzle_2 = $Muzzle2
@export var flashModel : PackedScene 
@onready var timer = $Timer

var currFlash : Node3D = null


var currMuzz := 1
var rotation_step = 7


func shoot():
	var spawn = muzzle_1 if currMuzz == 1 else muzzle_2
	
	if flashModel:
		if currFlash:
			currFlash.queue_free()
		
		currFlash = flashModel.instantiate()
		get_tree().current_scene.add_child(currFlash)
		
		# Match the muzzle's full transform (position + rotation)
		currFlash.global_transform = spawn.global_transform
		
		# Apply the 45° step rotation around the local forward axis (Z)
		var angle = rotation_step * PI / 4
		currFlash.rotate_object_local(Vector3(1,0,0), angle)
		
		# Increment step for next spawn
		rotation_step = (rotation_step + 1) % 8
		
		currMuzz = 2 if currMuzz == 1 else 1
		timer.start()


func _on_timer_timeout():
	if currFlash:
		currFlash.queue_free()
		currFlash = null

func _physics_process(delta):
	var spawn = muzzle_1 if currMuzz == 1 else muzzle_2
	if currFlash:
		currFlash.global_position = spawn.global_position
	
