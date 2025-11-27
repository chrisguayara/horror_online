extends RayCast3D

@export var player: Node3D
@onready var label = $"../aimlabel"
@export var dmg: int = 45

var inv: Node = null
var current_gun: Node = null

func _ready():
	if not player:
		push_error("Player not assigned in GunRayCast!")
		return
	inv = player.get_node("inventory")
	if not label:
		push_error("Aim label not found! Check path.")
		return
	label.text = ""

func _process(delta):
	label.text = ""
	if not inv or not inv.current_item:
		_disconnect_gun()
		return

	if inv.current_item is HuntingRifle:
		if current_gun != inv.current_item:
			_connect_gun(inv.current_item)
	else:
		_disconnect_gun()

	if is_colliding():
		var hit = get_collider()
		if hit is Enemy:
			label.text = "Aiming at: %s" % hit.enemy_name

# Connect dynamically when gun is equipped
func _connect_gun(gun: Node) -> void:
	_disconnect_gun()
	current_gun = gun
	current_gun.fired.connect(Callable(self, "_on_gun_fired"))

# Disconnect previous gun signal safely
func _disconnect_gun() -> void:
	if current_gun and current_gun.fired.is_connected(Callable(self, "_on_gun_fired")):
		current_gun.fired.disconnect(Callable(self, "_on_gun_fired"))
	current_gun = null

func _on_gun_fired():
	if not is_colliding():
		return
	var hit = get_collider()
	if hit is Enemy:
		hit.take_damage(current_gun.damage)
		print("Hit %s for %d damage!" % [hit.enemy_name, current_gun.damage])
