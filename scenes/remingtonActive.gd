extends Node3D

var damage = 20
var spread= 1.5
var fire_rate = 0.5

var can_shoot : bool =  true

var maxAmmo =  6
var currAmmo = 6


func _physics_process(delta):
	if currAmmo <=0:
		can_shoot = false
	pass

func on_shoot():
	if not can_shoot:
		return
	print("BANG! %d Damage Done!" %damage)
	
