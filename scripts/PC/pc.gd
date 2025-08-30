extends Interactable

@onready var marker = $button/PC/Marker3D
signal transition



func interact(body):
	
	var marker := get_node_or_null("button/PC/Marker3D")
	if not marker:
		# fallback: try to find any Marker3D in children (use sparingly)
		marker = find_child("Marker3D", true, false)
	if not marker:
		push_warning("Marker3D not found for " + str(get_path()))
		return

	var pos: Vector3 = marker.global_position
	var rotation : Vector3 = marker.global_rotation
	body.pcEnter()
	emit_signal("transition", pos, rotation)
	
