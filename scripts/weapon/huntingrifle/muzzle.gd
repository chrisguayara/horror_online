extends Node3D

@onready var muzzle = $Muzzle
@export var flashModel : PackedScene 
@onready var timer = $Timer

var currFlash : Node3D = null
var rotation_step = 0

func shoot():
	if flashModel:
		if currFlash:
			currFlash.queue_free()
		
		currFlash = flashModel.instantiate()
		muzzle.get_parent().add_child(currFlash)
		
		currFlash.global_transform = muzzle.global_transform
		
		var angle = rotation_step * (PI / 4.0)
		currFlash.rotate_object_local(Vector3(0,0,1), angle)
		
		rotation_step = (rotation_step + 1) % 8
		
		timer.start()


func _on_timer_timeout():
	if currFlash:
		currFlash.queue_free()
		currFlash = null


func _physics_process(delta):
	if currFlash:
		currFlash.global_transform = muzzle.global_transform
