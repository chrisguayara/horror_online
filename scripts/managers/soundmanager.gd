extends Node3D

@export var alarm_node: AudioStreamPlayer
@export var inventory_node: AudioStreamPlayer
@export var shotGun_PU_node : AudioStreamPlayer
var interactable_sounds = {}

@onready var bunnyD = $deathSounds/bunny
@onready var intro = $intro/startup
@onready var windssong = $intro/windssong
@onready var select = $select
@onready var outdoorSounds = $outdoors



func _ready():
	interactable_sounds = {
		"inventoryDef" : inventory_node,
		"alarmclock": alarm_node,
		"shotGun_Pickup" : shotGun_PU_node
		}
	var inventory = $"../player/inventory"   

	inventory.connect("addSound", Callable(self, "_on_inventory_add_sound"))

func startup():
	intro.play()

func loopIntro():
	
	windssong.volume_db = -30              # start silent
	windssong.play()

	var tw = create_tween()
	tw.tween_property(windssong, "volume_db", -1, 1.0)
func endmm():
	windssong.playing = false
	windssong.queue_free()
	playSelect()
	await get_tree().create_timer(.3).timeout
	outDoors()

func outDoors():
	outdoorSounds.play()
	

func _on_alarmclock_playsound(str: String):
	if interactable_sounds.has(str):
		interactable_sounds[str].play()
	else:
		print("not a song")


func _on_inventory_add_sound(str: String):
	if interactable_sounds.has(str):
		interactable_sounds[str].pitch_scale = randf_range(0.99,1.01)
		interactable_sounds[str].play()
		
	else:
		print("not a song")


func playSelect():
	select.play()

func playDeath(enemy_name: String) -> void:
	
	if enemy_name == "bunny":
		bunnyD.play()
