extends Interactable

signal used

func _ready():
	interacted.connect(_on_interacted)

func _on_interacted(body):
	emit_signal("used", body)
