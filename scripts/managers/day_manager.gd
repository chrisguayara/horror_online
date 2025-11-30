extends Node3D

var currentDay := 1
@onready var soundmanager = $"../Soundmanager"
@onready var world := $"../SubViewportContainer/SubViewport/World"

var currGoal := {}
var currKills := {}

@export var rabbit_scene: PackedScene
@export var owl_scene: PackedScene
@export var deer_scene: PackedScene

# Spawn markers - assign these in the editor
@export var rabbit_spawn_markers: Array[Marker3D]
@export var owl_spawn_markers: Array[Marker3D]  
@export var deer_spawn_markers: Array[Marker3D]

func _ready():
	start_day(currentDay)

func start_day(day: int):
	currentDay = day
	print("Starting day: ", day)

	# daily quota
	currGoal = pick_daily_goals(day)

	# reset kill count
	currKills = {
		"rabbit": 0,
		"owl": 0,
		"raccoon": 0,
		"deer": 0
	}

	# wipe old animals
	for e in get_tree().get_nodes_in_group("enemies"):
		e.queue_free()

	spawn_animals_for_day(day)

func pick_daily_goals(day: int) -> Dictionary:
	match day:
		1:
			return {"rabbit": 2, "owl": 0, "raccoon": 0, "deer": 0}
		2:
			return {"rabbit": 1, "owl": 3, "raccoon": 0, "deer": 0}
		3:
			return {"rabbit": 2, "owl": 1, "raccoon": 0, "deer": 2}
		4:
			return {"rabbit": 0, "owl": 2, "raccoon": 0, "deer": 3}
		5:
			return {"rabbit": 3, "owl": 3, "raccoon": 0, "deer": 2}
	return {}

func spawn_animals_for_day(day: int):
	# Spawn more animals than needed - adjust multiplier as needed
	var spawn_multiplier = 2.5  # Spawn 2.5x the required amount
	
	for animal in currGoal.keys():
		var required_amount = currGoal[animal]
		if required_amount > 0:
			var spawn_amount = ceil(required_amount * spawn_multiplier)
			print("Spawning ", spawn_amount, " ", animal, "(s) - need ", required_amount)
			for i in spawn_amount:
				spawn_one(animal)

func spawn_one(animal: String):
	var scene: PackedScene = null
	var spawn_markers: Array[Marker3D] = []
	
	match animal:
		"rabbit":
			scene = rabbit_scene
			spawn_markers = rabbit_spawn_markers
		"owl":
			scene = owl_scene
			spawn_markers = owl_spawn_markers
		"raccoon":
			return
		"deer":
			scene = deer_scene
			spawn_markers = deer_spawn_markers

	if scene and spawn_markers.size() > 0:
		var enemy = scene.instantiate()
		world.add_child(enemy)
		
		# Pick random spawn marker from the appropriate list
		var random_marker = spawn_markers[randi() % spawn_markers.size()]
		enemy.global_position = random_marker.global_position
		
		# Optional: Add slight random offset to avoid exact same positions
		var random_offset = Vector3(randf_range(-2, 2), 0, randf_range(-2, 2))
		enemy.global_position += random_offset
		
		if enemy.has_signal("enemydeath"):
			enemy.connect("enemydeath", Callable(self, "_on_enemy_death"))

func get_random_spawn() -> Vector3:
	# Fallback if no markers are set up
	return Vector3(randf()*30-15, 0, randf()*30 - 15)

func _on_enemy_death(enemy_name: String):
	if enemy_name in currKills:
		currKills[enemy_name] += 1
		print("Killed ", enemy_name, " - Total: ", currKills[enemy_name], "/", currGoal.get(enemy_name, 0))

	if soundmanager and soundmanager.has_method("playDeath"):
		soundmanager.playDeath(enemy_name)

	if check_stats():
		print("Goal met! Return to the cabin.")
		try_end_day()

func check_stats() -> bool:
	for anim in currGoal.keys():
		if currKills.get(anim, 0) < currGoal.get(anim, 0):
			return false
	return true

func try_end_day():
	if check_stats():
		currentDay += 1
		if currentDay > 5:
			print("GAME OVER ENDING")
		else:
			start_day(currentDay)
	else:
		print("Not enough kills yet!")
