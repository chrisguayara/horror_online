extends CharacterBody3D
class_name Enemy

@export var enemy_name: String = "Placeholder"
@export var health: int = 100
@export var speed: int = 5

var state: String = "idle" # current state: idle, alert, dead

func _physics_process(delta):
	if state == "dead":
		return 
	
	
	pass

func take_damage(amount: int) -> void:
	if state == "dead":
		return  
	
	health -= amount
	print("%s took %d damage. Remaining health: %d" % [enemy_name, amount, health])
	
	if health <= 0:
		die()

func die() -> void:
	if state == "dead":
		return
	state = "dead"
	print("%s: I died" % enemy_name)
	
	
	
	
	queue_free()
