extends Node3D  
class_name Shootable 

@export var max_health := 40
var health := max_health

func take_damage(amount: float, shooter: Node = null) -> void:
	health -= amount
	if health <= 0:
		die()

func die() -> void:
	
	queue_free()
