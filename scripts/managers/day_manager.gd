extends Node3D
#
#var currentDay := 1
#@onready var soundmanager = $"../Soundmanager"
#@onready var sp := get_node("/root/Main/SubViewportContainer/SubViewport/EnemyManager/spawnpoints")
#
#var currGoal := {}
#var currKills := {}
#
#@export var rabbit_scene: PackedScene
#@export var owl_scene: PackedScene
#@export var deer_scene: PackedScene
#
#@onready var enemy_manager = get_node("/root/SubViewportContainer/SubViewport/EnemyManager")
#
#@onready var deer_spawns = get_spawn_points("Deer")
#@onready var owl_spawns = get_spawn_points("Owl")
#@onready var rabbit_spawns = get_spawn_points("Rabbit")
#
#func get_spawn_points(category: String) -> Array:
	#var list := []
	#var folder := sp.get_node(category)
	#for child in folder.get_children():
		#if child is Marker3D:
			#list.append(child)
	#return list
#
#func _ready():
	#start_day(currentDay)
#
#func start_day(day: int):
	#currentDay = day
	#currGoal = {"rabbit": 2, "owl": 0, "raccoon": 0, "deer": 0}
	#currKills = {"rabbit": 0, "owl": 0, "raccoon": 0, "deer": 0}
#
	#for e in get_tree().get_nodes_in_group("enemies"):
		#e.queue_free()
#
	#spawn_animals_for_day()
#
#func spawn_animals_for_day():
	#var spawn_multiplier = 2.5
	#for animal in currGoal.keys():
		#var required_amount = currGoal[animal]
		#if required_amount > 0:
			#var spawn_amount = ceil(required_amount * spawn_multiplier)
			#for i in spawn_amount:
				#spawn_one(animal)
#
#func spawn_one(animal: String):
	#var scene: PackedScene = null
	#var spawn_markers: Array = []
	#
	#match animal:
		#"rabbit":
			#scene = rabbit_scene
			#spawn_markers = rabbit_spawns
		#"owl":
			#return
		#"raccoon":
			#return
		#"deer":
			#return
#
	#if scene and spawn_markers.size() > 0:
		#var enemy = scene.instantiate()
		#enemy_manager.add_child(enemy)
#
		#var random_marker: Marker3D = spawn_markers.pick_random()
		#enemy.global_position = random_marker.global_position
		#
		#enemy.global_position += Vector3(
			#randf_range(-2, 2),
			#0,
			#randf_range(-2, 2)
		#)
		#
		#if enemy.has_signal("enemydeath"):
			#enemy.connect("enemydeath", Callable(self, "_on_enemy_death"))
#
#func get_random_spawn() -> Vector3:
	#return Vector3(randf()*30-15, 0, randf()*30 - 15)
#
#func _on_enemy_death(enemy_name: String):
	#if enemy_name in currKills:
		#currKills[enemy_name] += 1
	#if soundmanager and soundmanager.has_method("playDeath"):
		#soundmanager.playDeath(enemy_name)
	#if check_stats():
		#try_end_day()
#
#func check_stats() -> bool:
	#for anim in currGoal.keys():
		#if currKills.get(anim, 0) < currGoal.get(anim, 0):
			#return false
	#return true
#
#func try_end_day():
	#if check_stats():
		#currentDay += 1
		#if currentDay <= 5:
			#start_day(currentDay)
