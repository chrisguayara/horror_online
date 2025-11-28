extends MarginContainer


@onready var quit_button = $VBoxContainer/button_quit
@onready var crt_button = $VBoxContainer/button_crt
func _ready():
	visible = false
	quit_button.pressed.connect(_on_quit_pressed)
	crt_button.pressed.connect(_on_crt_pressed)


func toggleVisibility():
	visible = false if visible else true
	return visible





func _on_quit_pressed():
	get_tree().quit()

func _on_crt_pressed():
	# assuming your camera is under player head
	var p = get_parent()
	p.toggle_crt_effect()  # your custom function
