extends Node3D

var damage = 45
var spread = 1.0
var fire_rate = 2.4
var mag_capacity = 3
var can_shoot = true
var reloading = false
var loadedBullets = 0
var stock = 10
var scoped = false
@onready var debug_label = $debug_label
@onready var uimanager = get_tree().current_scene.get_node("UILayers")


@onready var muzzleNode = $MuzzleNode
@onready var sound_manager = $soundManager
@onready var fire_timer = Timer.new()
@onready var reload_timer = Timer.new()
@onready var graphics = $Graphics

func _ready():
	add_child(fire_timer)
	fire_timer.wait_time = fire_rate
	fire_timer.one_shot = true
	fire_timer.connect("timeout", Callable(self, "_on_fire_rate_timeout"))
	
	add_child(reload_timer)
	reload_timer.one_shot = true
	reload_timer.connect("timeout", Callable(self, "_on_reload_tick"))

func shoot():
	if reloading or not can_shoot:
		return
	if loadedBullets <= 0:
		reload()
		return
	if muzzleNode and muzzleNode.has_method("shoot"):
		muzzleNode.shoot()
	if sound_manager:
		sound_manager.play("shoot")
	loadedBullets -= 1
	can_shoot = false
	fire_timer.start()

func _on_fire_rate_timeout():
	can_shoot = true

func reload():
	if reloading:
		return
	if loadedBullets >= mag_capacity:
		return
	if stock <= 0:
		return
	reloading = true
	can_shoot = false
	reload_timer.start()

func _on_reload_tick():
	if loadedBullets >= mag_capacity or stock <= 0:
		reloading = false
		can_shoot = true
		return
	if sound_manager:
		sound_manager.play("reload")
	loadedBullets += 1
	stock -= 1
	reload_timer.start()

func get_ammoCount():
	return stock + loadedBullets

func get_loaded():
	return loadedBullets

func scope():
	if reloading:
		return
	scoped = not scoped
	uimanager.scope(scoped)
	graphics.visible = not scoped
	return scoped
	


func _process(delta):
	if debug_label:
		var info = "Loaded: %d\nStock: %d\nReloading: %s\nCan Shoot: %s\nScoped: %s" % [
			loadedBullets,
			stock,
			str(reloading),
			str(can_shoot),
			str(scoped)
		]
		debug_label.text = info
