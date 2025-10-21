extends Node3D

var damage = 20
var spread= 1.5
var fire_rate = 0.5

var can_shoot : bool =  true

var ammo =  6
var stock = 1
var loadedBullets = 0

@onready var muzzle = $Muzzle







func shoot():
	if not can_shoot:
		return
	if loadedBullets <=0:
		reload()
		return
	if muzzle and muzzle.has_method("shoot"):
		muzzle.shoot()
		print("muzzle activated")
	
	print("BANG! %d Damage Done!" %damage)
	
	
	loadedBullets -= 1
	ammo -= 1

func _physics_process(delta):
	if ammo <=0:
		can_shoot = false
	
func reload():
	if can_shoot:
		for i in range(stock):
			loadedBullets += 1
			print("reloaded %d bullet(s) !" %(i+1))

func get_ammoCount():
	return ammo - loadedBullets

func get_loaded():
	return loadedBullets
