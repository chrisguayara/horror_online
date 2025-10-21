extends Node3D
@onready var muzzle_1 = $Muzzle1
@onready var muzzle_2 = $Muzzle2
@export var flashModel : PackedScene 
@onready var timer = $Timer

var currFlash : Node3D = null


var currMuzz := 1

func shoot():
	var spawn = muzzle_1 if currMuzz == 1 else muzzle_2
	if flashModel:
		if currFlash:
			currFlash.queue_free()
		currFlash = flashModel.instantiate()
		get_tree().current_scene.add_child(currFlash)
		currFlash.global_transform = spawn.global_transform
		currMuzz = 2 if currMuzz == 1 else 1
		print("spawned!")
		timer.start()


func _on_timer_timeout():
	if currFlash:
		currFlash.queue_free()
		currFlash = null
