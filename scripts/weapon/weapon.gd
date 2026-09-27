extends Node3D
class_name Weapon

var bullet_count 
@export var max_ammo : int
# Called when the node enters the scene tree for the first time.
func fire() -> void:
	pass # Replace with function body.

func reload()-> void:
	bullet_count = max_ammo

func get_bullet() ->int:
	return bullet_count
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
