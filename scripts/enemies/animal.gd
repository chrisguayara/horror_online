extends CharacterBody3D
class_name Enemy

@export var enemy_name: String = "Placeholder"
@export var health: int = 100
@export var speed: int = 5
@onready var hitbox = $"../bunny2/hitbox"
@export var deadBody : PackedScene

var state: String = "idle" # current state: idle, alert, dead
signal enemydeath(enemy_name: String)

func _ready():
	add_to_group("enemies")
	
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
	print("EMITTING:", enemy_name)
	emit_signal("enemydeath",enemy_name)
	var p = get_parent()
	var pos = position
	var rot = rotation
	
	
	if deadBody:
		var corpse = deadBody.instantiate()
		corpse.global_transform = global_transform
		get_parent().add_child(corpse)

	
	queue_free()
