extends Interactable

signal transition
signal exit

var mode = "person"
var canExit = true
var lastPos: Vector3
var alinteracted = false
var uses = 0
var useLimit = 1

@export var label: Label


func interact(body):
	if mode == "person" and uses < useLimit:
		var marker := get_node_or_null("button/PC/Marker3D")
		if not marker:
			marker = find_child("Marker3D", true, false)
		if not marker:
			push_warning("Marker3D not found for " + str(get_path()))
			return

		var pos: Vector3 = marker.global_position
		var rotation: Vector3 = marker.global_rotation

		body.pcEnter()
		emit_signal("transition", pos, rotation)

		mode = "pc"
		uses += 1
		alinteracted = false
		print("Entered PC")

	elif mode == "pc" and canExit:
		exit_pc(body)


func _physics_process(delta):
	if label:
		label.text = "Mode: " + mode


func exit_pc(body):
	if mode == "pc" and not alinteracted:
		body.pcExit()
		emit_signal("exit")
		alinteracted = true
		mode = "person"
		print("Exited PC")
